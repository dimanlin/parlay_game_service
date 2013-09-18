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
      puts "1777777777777777"
      request_attributes = {'userId' => "OGS12345", 'siteId' => 'OGS', 'sessionId' => '354252352435', 'key' => '62VNKjd29s', 'lang' => 'en'}
      puts "2222222222222222222222222222222222"
      puts args['jsessionid'].inspect
      puts "333333333333333333333333333"
      puts args['jsessionid'] ? ";#{args['jsessionid']}" : nil
      uri = URI("http://blws1.parlaygames.net/site-api/#{method}#{args['jsessionid'] ? ";jsessionid=#{args['jsessionid']}" : nil}")
      puts "444444444444444444444"
      puts uri
			c = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
		  	req = Net::HTTP::Post.new uri.request_uri
        req.set_form_data(request_attributes)
			  response = http.request(req) # Net::HTTPResponse object
			end
      puts "2222222222222222222222"
      puts c.body.inspect
      hash = Hash.from_xml(c.body)

      puts "parlay_game_services output: #{hash}" if @debug
      if (hash.include?("error_code"))
        raise ParlayGameService::ApiError, hash
      else
        hash
      end
    end

    def method_missing(name, args = nil, &block)
      invoke(name.to_s.to_s.tableize.gsub("_", ".").singularize, args)
    end

    def to_hash_params *args
      return {} if args.empty?
      return args.first.camelize_keys
    end
  end
end
