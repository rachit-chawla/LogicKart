module ApplicationHelper
	#api_post_request(CONN,'/LogicKart/rest/login/',{"Content-Type"=> "application/json"}, params["User"])
	def api_post_request(connection,endpoint_url,headers,payload)
      response = service_connection.post do |req|
        req.url endpoint_url
        req.headers = headers
        req.body = payload
      end
      response.body
  end
end
