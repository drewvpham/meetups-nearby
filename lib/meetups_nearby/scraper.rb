class MeetupsNearby::Scraper

  def self.today
    html = open("https://www.meetup.com/find/events/?allMeetups=true&radius=#{MeetupsNearby::CLI.input.radius.to_i}&userFreeform=#{MeetupsAround::CLI.input.zip_code.to_i}")
    doc = Nokogiri::HTML(html)
    meetups = []
    today = Time.new
    todays_date = today.strftime('%A, %B %-d')

    if today.strftime('%A, %B %-d') != doc.search('li.date-indicator').first.text.strip
      puts 'There are no more events today.'
    else
      MeetupsNearby::Meetup.update_todays_date(todays_date)
      doc.css('ul.event-listing-container li.row.event-listing.clearfix.doc-padding').each do |row|
        meetup = MeetupsNearby::Meetup.new
        # binding.pry
        meetup.time = row.css('time').text
        meetup.group = row.css('div.text--labelSecondary').text.strip
        meetup.event = row.css('span').last.text.strip
        meetup.attending = row.css('div.attendee-count').text.strip.tr("\n", ' ').gsub(/\s+/, ' ')
        meetup.save
      end
    end
  end


end
