#Encoding: UTF-8


#require libs
require 'json'
require 'rubygems'
require 'telegram/bot'
require 'yaml/store'
require "colorize"
require 'securerandom'



#Config file
@ConfigFile = File.read('config.json')
@config = JSON.parse(@ConfigFile)

#Game database
db = YAML::Store.new('Game.yml')
bd = YAML::Store.new('band.yml')
#bot token
token = @config["electrovirus"]

V = @config["Version"]

#game start
Telegram::Bot::Client.run(token) do |bot|
	puts "tofiko".on_red
	begin
		bot.listen do |message|
			#require bot files
			bd.transaction do
				db.transaction do
						eval(File.read("./plugins/self.rb"))
				end
			end
		end
	rescue Telegram::Bot::Exceptions::ResponseError => e
    	retry
	end
end

#TELEGRAM_BOT_POOL_SIZE=16 ruby bot.rb
