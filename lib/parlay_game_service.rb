require "parlay_game_service/version"

module ParlayGameService
  require 'parlay_game_service/proxy'
  require 'parlay_game_service/api_error'
#  require 'curb'
#  require 'json'
  require 'parlay_game_service/hash'
  require 'parlay_game_service/string'

	mattr_accessor :url
  @@url = 'https://api-sandbox.direct.yandex.ru/json-api/v4/'

	mattr_accessor :key
	@@key = nil

  mattr_accessor :site_id
  @@site_id

  mattr_accessor :user_name
  @@user_name

  mattr_accessor :password
  @@password

	def self.setup
		yield self
	end
end
