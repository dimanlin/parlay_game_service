require "parlay_game_service/version"

module ParlayGameService
  require 'parlay_game_service/proxy'
  require 'parlay_game_service/api_error'
#  require 'curb'
#  require 'json'
  require 'parlay_game_service/hash'
  require 'parlay_game_service/array'
  require 'parlay_game_service/string'

	# Url for request, default for sandbox
	mattr_accessor :url
  @@url = 'https://api-sandbox.direct.yandex.ru/json-api/v4/'

	# Access token
	mattr_accessor :key
	@@key = nil

  # application id 
  mattr_accessor :site_id
  @@site_id

  # auth login
  mattr_accessor :user_name
  @@user_name

  # locale, default en
  mattr_accessor :password
  @@password

	def self.setup
		yield self
	end
end
