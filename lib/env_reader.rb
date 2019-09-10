require 'json'
require 'dotenv/load'

class EnvReader
  attr_accessor :slack_url, :channel_name, :greeting_msg, :bot_name, :bot_emoji

  def load
    if valid?
      @slack_url = ENV['SlackUrl']
      @channel_name = ENV['ChannelName']
      @greeting_msg = ENV['GreetingMessage']
      @bot_name = ENV['BotName']
      @bot_emoji = ENV['BotEmojiCode']

      return true
    else
      return false
    end
  end

  def valid?
    puts 'Validating configurations'
    value = false
    if not ENV['SlackUrl']
      puts 'ERROR: Missing "SlackUrl" on configuration file'
    elsif not ENV['ChannelName']
      puts 'ERROR: Missing "ChannelName" on configuration file'
    elsif not ENV['GreetingMessage']
      puts 'ERROR: Missing "GreetingMessage" on configuration file'
    elsif not ENV['BotName']
      puts 'ERROR: Missing "BotName" on configuration file'
    elsif not ENV['BotEmojiCode']
      puts 'ERROR: Missing "BotEmojiCode" on configuration file'
    else
      value = true
    end
    return value
  end
end
