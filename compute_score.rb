require 'firebase'
require 'pry'
require 'github_api'

#This script simply puts score = 0 for those prjoects without a github link
#This may not be needed and can be merged with update_github_info.rb

base_uri = 'https://g0v-project-hub.firebaseio.com/'
firebase = Firebase::Client.new(base_uri)

response = firebase.get('projects')
response.body.each do |key, element|
	begin
		if !element['score']
			payload = {score: 0 }
			firebase.update("projects/#{key}", payload)
     		print "."
     	end
    rescue
    print "E"
  	end
 end
