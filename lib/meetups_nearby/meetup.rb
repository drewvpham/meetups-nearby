class MeetupsAround::Meetup
  attr_accessor :time, :group, :event, :attending, :meetups

  @@meetups = []

  def save
    @@meetups << self
  end

  def self.meetups
    @@meetups
  end

  def self.update_todays_date(date)
    @@todays_date = date
  end

  def self.todays_date
    @@todays_date
  end
end
