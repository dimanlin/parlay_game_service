module ParlayGameService
	require 'net/http'
  require 'active_support/core_ext/hash/conversions'

  class Proxy
    attr_accessor :debug, :locale

    def initialize params = {}
			raise "You mast use access token for auth, mebe you foget write check config/initializers/parlay_game_services.rb or generate it rails g parlay_game_services:install" if ParlayGameService.key.blank? || ParlayGameService.site_id.blank?
      @debug = false || params[:debug]
			@key = ParlayGameService.key
      @site_id = ParlayGameService.site_id
      @jsessionid = params['jsessionid']
      @admin_login = ParlayGameService.admin_login
      @admin_password = ParlayGameService.admin_password
    end

    def invoke(method, args, super_user = false)
      args.merge!({'admin_user_name' => @admin_login, 'admin_password' => @admin_password}) if super_user
      args.merge!({'site_id' => ParlayGameService.site_id, 'key' => ParlayGameService.key})
      uri = URI("http://blws1.parlaygames.net/site-api/#{method}#{@jsessionid ? ";jsessionid=#{@jsessionid}" : nil}")
      args.delete('jsessionid')
			c = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
		  	req = Net::HTTP::Post.new uri.request_uri
        req.set_form_data(args.camelize_keys_lower)
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

    def method_missing(name, args, super_user = false, &block)
      invoke(name.to_s.to_s.tableize.gsub("_", ".").singularize, args, super_user)
    end
  end
end
