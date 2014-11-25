require 'firebase'
require 'pry'
require 'github_api'

#This script fetches those projects with a github url and updates
#its github info as well as computes a score based on github activity

base_uri = 'https://g0v-project-hub.firebaseio.com/'
firebase = Firebase::Client.new(base_uri)
response = firebase.get('projects')
response.body.each do |key, element|
  next unless element['workspace'] 
  begin
    github_workspace = element['workspace'].detect{ |ws| ws['url'].include?('github.com') }
    github_url = github_workspace['url']
    url_split = github_url.split('/')
    repo_name = url_split[-1]
    user_name = url_split[-2]

    response = Github.repos.get(user_name, repo_name)
    if response.status == 200
      stargazers_count = response.body.stargazers_count / 3
      watchers_count = response.body.watchers_count / 3
      subscribers_count = response.body.subscribers_count / 3
      issues_count = response.body.open_issues_count / 2
      forks_count = response.body.forks_count 
      if response.body.homepage
        homepage = 20
      else
        homepage = 0
      end
      has = 0
      el_has = [response.body.has_downloads, response.body.has_wiki, response.body.has_pages]
      el_has.each do |att|
        if att 
          has += 5
        end
      end
      update_time_array = response.body.updated_at.split("T")[0].split("-")
      update_time = Time.new(update_time_array[0],update_time_array[1],update_time_array[2])
      time_from_now = (Time.now - update_time).to_i
      six_months = 15552000
      if time_from_now > six_months
        update_score = 0
      else

        update_score = 50 - (time_from_now.fdiv(six_months).round(2)*50)
      end
      score = update_score + has + homepage + forks_count + watchers_count 
        + stargazers_count + issues_count
      payload = { created_at: response.body['created_at'], updated_at: response.body['updated_at'], open_issues_count: response['open_issues_count'], score: score }
      firebase.update("projects/#{key}", payload)
      print "."
    end
  rescue
    print "E"
  end
end
