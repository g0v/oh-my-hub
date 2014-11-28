require 'firebase'
require 'pry'
require 'github_api'

#This is a test script to compute github activity score


response = Github.repos.list org: 'g0v'
response.each_page do |page|
	page.each do |element|
		begin
			stargazers_count = element.stargazers_count / 3
			watchers_count = element.watchers_count / 3
			issues_count = element.open_issues_count 
			forks_count = element.forks_count *2
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

			puts "#{element.name}: #{score} - update_score: #{update_score}, homepage: #{homepage}"
			
		end
	end
end