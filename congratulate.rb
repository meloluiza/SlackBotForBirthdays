APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'birthday_bot'
require 'env_reader'
require 'dotenv/load'

puts '🤖 Bot is booting...'

configs = EnvReader.new()
abort '❌ Bot is shutting down' if not configs.load

puts 'Reading configurations'

url = configs.slack_url
channel = configs.channel_name
greeting = configs.greeting_msg
name = configs.bot_name
emoji = configs.bot_emoji

puts '🤖 Bot is activating...'
bot = SlackBot.new(url, channel, greeting, name, emoji)
bot.launch!
