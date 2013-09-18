module ParlayGameService
	require 'net/http'
  require 'active_support/core_ext/hash/conversions'

  class Proxy
    attr_accessor :debug, :locale

    def initialize params = {}
			raise "You mast use access token for auth, mebe you foget write check config/initializers/parlay_game_services.rb or generate it rails g parlay_game_services:install" if ParlayGameService.key.blank? || ParlayGameService.site_id.blank?
      @params = params
      @debug = false || params[:debug]
			@key = ParlayGameService.key
      @site_id = ParlayGameService.site_id
      @user_name = ParlayGameService.user_name
      @password = ParlayGameService.password
    end

    def invoke(method, args)
      request_attributes = {'userId' => "OGS12345", 'siteId' => 'OGS', 'sessionId' => '354252352435', 'key' => '62VNKjd29s', 'lang' => 'en'}
      uri = URI("http://blws1.parlaygames.net/site-api/#{method}#{args['jsessionid'] ? ";jsessionid=#{args['jsessionid']}" : nil}")
      args.delete('jsessionid')
			c = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
		  	req = Net::HTTP::Post.new uri.request_uri
        req.set_form_data(args)
			  response = http.request(req) # Net::HTTPResponse object
			end
       puts c.body.inspect if @debug
      hash = Hash.from_xml(c.body)

      puts "parlay_game_services output: #{hash}" if @debug
      if (hash['results'].include?("errors"))
        raise ParlayGameService::ApiError, hash
      else
        hash
      end
    end

    def method_missing(name, args = nil, &block)
      invoke(name.to_s.to_s.tableize.gsub("_", ".").singularize, args)
    end
  end
end
