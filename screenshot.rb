require 'cgi'
require 'openssl'
require 'open-uri'
require 'firebase'
require 'pry'
 
def urlbox(url, options={})
  urlbox_apikey = 'key'
  urlbox_secret = 'secret'
 
  query = {
    :url       => url,
    :force     => options[:force],
    :full_page  => options[:full_page],
    :thumb_width => options[:thumb_width],
    :width  => 217,
    :height  => 185,
  }
 
  query_string = query.
    sort_by {|s| s[0].to_s }. 
    select {|s| s[1] }.       
    map {|s| s.map {|v| CGI::escape(v.to_s) }.join('=') }.
    join('&')
 
  # puts query_string
 
 # puts URI::encode(query_string)
  
  token = OpenSSL::HMAC.hexdigest('sha1', urlbox_secret, query_string)
 
  "https://api.urlbox.io/v1/#{urlbox_apikey}/#{token}/png?#{query_string}"
end
 
base_uri = 'https://g0v-project-hub.firebaseio.com/'
firebase = Firebase::Client.new(base_uri)
response = firebase.get('projects')
response.body.each do |key, element|
  next unless (!element['logo'] || element['logo'] == '') && (element['achievement'][0]['url'] || element['achievement'][0]['url'] != '')
  begin
    if element['achievement'][0]['type'] == "Web"
      screenshot = urlbox element['achievement'][0]['url']
      payload = {logo: screenshot}
      firebase.update("projects/#{key}", payload)
      print "."
    else
      print "?"
    end
  rescue
    print "E"
  end
end


