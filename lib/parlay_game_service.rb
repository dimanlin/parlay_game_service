require "parlay_game_service/version"

module ParlayGameService
  require 'parlay_game_service/proxy'
  require 'parlay_game_service/api_error'
  require 'parlay_game_service/hash'

	mattr_accessor :url
  @@url = 'https://api-sandbox.direct.yandex.ru/json-api/v4/'

	mattr_accessor :key
	@@key = nil

  mattr_accessor :site_id
  @@site_id

  mattr_accessor :admin_login
  @@admin_login

  mattr_accessor :admin_password
  @@admin_password

	def self.setup
		yield self
	end
end
