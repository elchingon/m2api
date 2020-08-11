module M2api
  class Connection
    attr_accessor :host, :port, :user, :password, :token, :base_path, :scheme

    def initialize uri, user, password, access_token=nil, base_path:nil
      uri = URI(uri)
      @host = uri.host
      @port = uri.port
      @user = user
      @scheme = uri.scheme
      @password = password
      @base_path = base_path || "/rest/V1"
      if access_token
        @token = access_token
      else
        request_token 
      end
    end

    def request_token
      Net::HTTP.start(self.host,self.port, :use_ssl => self.scheme == 'https') do |http|
        url = "#{base_path}/integration/admin/token"
        M2api.logger.info "POST #{url}"
        req = Net::HTTP::Post.new(url)
        req.body = {:username=> self.user, :password=> self.password}.to_json
        req['Content-Type'] = "application/json"
        req['Content-Length'] = req.body.length
        response = http.request(req).body
        @token = response.gsub(/\"/, '')
      end
    end

    def delete path, data
      M2api.logger.info "DELETE #{host}/#{base_path}/#{path}"
      M2api.logger.debug "DATA #{data}"

      url = "#{base_path}/#{path}"
      Net::HTTP.start(self.host,self.port, :use_ssl => self.scheme == 'https') do |http|
        req = Net::HTTP::Delete.new(url)
        req["Authorization"] = "Bearer #{self.token}"
        req['Content-Type'] = "application/json"
        req.body = data
        http.request(req)
      end
    end

    def put path, data
      M2api.logger.info "PUT #{host}/#{base_path}/#{path}"
      M2api.logger.debug "DATA #{data}"
      url = "#{base_path}/#{path}"
      Net::HTTP.start(self.host,self.port, :use_ssl => self.scheme == 'https') do |http|
        req = Net::HTTP::Put.new(url)
        req["Authorization"] = "Bearer #{self.token}"
        req['Content-Type'] = "application/json"
        req.body = data
        http.request(req)
      end
    end

    def post path, data
      M2api.logger.info "POST #{host}/#{path}"
      M2api.logger.debug "DATA #{data}"
      url = "#{base_path}/#{path}"
      Net::HTTP.start(self.host,self.port, :use_ssl => self.scheme == 'https') do |http|
        req = Net::HTTP::Post.new(url)
        req["Authorization"] = "Bearer #{self.token}"
        req['Content-Type'] = "application/json"
        req.body = data
        http.request(req)
      end
    end


    def get path, query = ""
      M2api.logger.info "GET #{host}#{base_path}/#{path}?#{query}"
      url = "#{base_path}/#{path}?#{query}"
      Net::HTTP.start(self.host,self.port, :use_ssl => self.scheme == 'https') do |http|
        req = Net::HTTP::Get.new(url)
        req["Authorization"] = "Bearer #{self.token}"
        req['Content-Type'] = "application/json"
        http.request(req)
      end
    end
  end
end
