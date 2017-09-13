class MeetupsNearby::CLI
  attr_accessor :meetups
  attr_reader :zip_code, :radius
  def call
    @@input = self
    input_zipcode
    input_radius
    MeetupsNearby::Scraper.today
    list_meetups
    again?
  end

  def self.input
    @@input
  end

  def input_zipcode
    puts 'What zip code would you like to see meetups for?'
    @zip_code = gets.strip
    if /\b\d{5}\b/.match(@zip_code)
      nil
    else
      puts 'Please enter a five digit zip code.'
      input_zipcode
    end
  end

  def input_radius
    puts 'What radius around that zip code would you like to see meetups for?'
    @radius = gets.strip
    if /\b\d{1,2}\b/.match(@radius)
      nil
    else
      puts 'Please enter a radius less than 100.'
      input_radius
    end
  end

  def list_meetups
    meetups = MeetupsNearby::Meetup.meetups
    unless meetups.nil?
      puts "Today, #{MeetupsNearby::Meetup.todays_date} are the following meetups:"
      meetups.each.with_index(1) do |meetup, i|
        puts "#{i}. #{meetup.time} - #{meetup.group} - #{meetup.event} - #{meetup.attending}"
      end
    end
  end

  def again?
    puts 'Would you like to search again? [Y/N]'
    input = gets.strip.downcase
    puts input == 'y' || input == 'yes' ? call : 'Thank you for using MeetupsNearby!'
  end
end
