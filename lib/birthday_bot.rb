require 'httparty'
require 'birthday_reader'
require 'time_extensions'

class SlackBot
  def initialize(url, channel, greeting, botname, emoji)
    @url = url
    @greeting = greeting
    @botname = botname
    @channel = channel
    @emoji = emoji

    BirthdayReader.filepath = 'config/birthdays.txt'

    if BirthdayReader.file_exist?
      puts 'Found birthdays file'
    else
      abort 'ERROR: Birthdays file not found'
    end
  end

  def format_text(people, greeting)
    final_names = ''
    counter = 0
    people.each_with_index do |names, counter|
      if counter < people.length - 1
        final_names += "#{names[0]} #{names[1]}, "
      else
        final_names += "#{names[0]} #{names[1]}"
      end
    end

    value = greeting + " :confetti_ball: #{final_names} :confetti_ball:"
  end

  def push_to_slack(message, channel_name, bot_name, emoji)
    puts '🤖 Bot is notifying Slack...'
    HTTParty.post(@url, body: { channel: channel_name, username: bot_name, text: message, icon_emoji: emoji }.to_json)
    puts "Pushed \"#{message}\""
  end

  def birthdays
    BirthdayReader.get_birthdays
  end

  def launch!
    birthday_people = []
    today = Time.current.to_date

    birthdays.each do |person|
      if (person[3].to_i == today.month) and (person[4].to_i == today.day)
        birthday_people << person
      end
    end

    print "Checking who was born today (#{today.to_s}): #{birthday_people.length}\n"
    push_to_slack(format_text(birthday_people, @greeting), @channel, @botname, @emoji) if birthday_people.length > 0
    puts '🤖 Bot is shutting down...'
  end
end
