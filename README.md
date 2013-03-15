=====================
API app (appointments) 
=====================

The RESTful API service is built on top of Rails3 app. The middleware stack is reduced by rails-api gem. (The app is likely to be 
further moved to sinatra framework and MD for performance reasons. Benchmarking of two frameworks would be reasonable).

Database: any relational database adapter (MySQL is used). The app is tested with rspec.

The API exposes the following 4 methods to facilitate CRUD operations on the appointment resources:

<pre>
GET /list(.json)
POST /appointments(.json)
PUT /appointments/:id(.json)
DELETE /appointments/:id(.json)
</pre>

In all cases the response body will contain a JSON with all appointments. 

The database is populated with the the initial csv data with a rake task: 

<pre>rake db:csvimport</pre>

A class method filter_by_date performs the database filtering while an instance method dates_valid? validates the dates.
If errors present the JSON file will contain an error message.

Below is an example of how to use the service.

<pre>
module Appointments

require 'net/http'
require 'uri'
require 'cgi'
 
 class API
    
    HOST = "boiling-falls-4863.herokuapp.com"
    
    def appt_list(params_hash)
      #e.g., {start: "2013-04-13T21:24:25Z"}
      if params_hash
        url_string = 'http://'+HOST+'/list?'.concat(params_hash.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))
      else
        url_string = 'http://'+HOST+'/list'
      end
      url = URI.parse(url_string)
      response = Net::HTTP.start(url.host, url.port) { |http| http.get(url.request_uri)}
      response
    end

    def appt_create(params_hash)
      #e.g., {"appointment[first_name]" =>"A", "appointment[last_name]" => "B", "appointment[start_time]" => "2017-03-13T21:24:25Z", "appointment[end_time]" => "2017-04-13T21:24:25Z"}
      response = Net::HTTP.post_form(URI.parse('http://'+HOST+'/appointments'), params_hash)
      response
    end

    def appt_delete(appt_id)
      response = Net::HTTP.new(HOST).delete("/appointments/#{appt_id}")
      response
    end

    def appt_update(appt_id, params_hash)
      #e.g., {"appointment[first_name]" =>"A", "appointment[last_name]" => "B", "appointment[start_time]" => #"2019-03-13T21:24:25Z", "appointment[end_time]" => "2019-04-13T21:24:25Z"}
      conn = Net::HTTP.new(HOST)
      request = Net::HTTP::Put.new "/appointments/#{appt_id}"
      request.set_form_data(params_hash)
      response = conn.request(request)
      response
    end

  end

end 
</pre>

How to use:

<pre>
a = Appointments::API.new
response = a.appt_list({start: "2013-03-13T21:24:25Z"})

puts response.code # HTTP response code
puts response.body # JSON response
</pre>
