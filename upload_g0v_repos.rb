require 'github_api'
require 'firebase'
require 'pry'

#This script loads every repo on g0v minus those already on the hub
#and computes a score for each repo

base_uri = 'https://g0v-project-hub.firebaseio.com/'
firebase = Firebase::Client.new(base_uri)

response = firebase.get('projects')
g0v_repos = []
response.body.each do |element|
  next unless element['workspace'] 
  begin
    github_workspace = element['workspace'].detect{ |ws| ws['url'].include?('github.com') }
    github_url = github_workspace['url']
    url_split = github_url.split('/')
    repo_name = url_split[-1]
    user_name = url_split[-2]
    if user_name == 'g0v'
    	g0v_repos << user_name
    	print "."
    end
  rescue
  	print "E"
  end
end
#log in to get more rate-limit
#github = Github.new basic_auth: 'username:pwd'

gh_response = github.repos.list org: 'g0v'
gh_response.each_page do |page|
	page.each do |element|
		begin
			if !g0v_repos.include?(element)
				print "#{element.name}"
				stargazers_count = element.stargazers_count / 3
			    watchers_count = element.watchers_count / 3
			    subscribers = element.subscribers_count || 0
			    subscribers_count = subscribers / 3
			    issues_count = element.open_issues_count / 2
			    forks_count = element.forks_count 
			    if element.homepage
			      homepage = 20
			    else
			      homepage = 0
			    end
			    has = 0
			    el_has = [element.has_downloads, element.has_wiki, element.has_pages]
			    el_has.each do |att|
			      if att 
			        has += 5
			      end
			    end
			    update_time_array = element.updated_at.split("T")[0].split("-")
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
			      print "#{score}"
				payload = {name: {zh: element.name}, created_at: element.created_at, updated_at: element.updated_at,
					tool: {"0" => element.language}, intro: {zh: {short: element.description}}, achievement: {"0"=> {type: "Web", url: element.homepage }},
					workspace: {"0" => {type: "Github", url: element.html_url}}, score: score}
				firebase.push("projects", payload)
				if response.success?
     				print "."
     			else
     				print "?"
     			end
     		end
     	 end
     end
 end


