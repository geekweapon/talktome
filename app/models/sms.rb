class SMS
  require 'forecast_io'

  def initialize(from_number, payload)
    @from_number = from_number
    @payload = payload.downcase
  end

  def client
    Twilio::REST::Client.new Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token
  end

  def send
    client.messages.create(
          from: Rails.application.secrets.twilio_number,
          to: @from_number,
          body: "#{body}")
  end

  def body
    if @payload.match(/\b\d{5}\b/)
      "Current conditions are #{weather.currently.summary} with a temperature of #{weather.currently.temperature}F"
    else
      if Knowledge.any? {|k| k.keyword  == @payload }
        Knowledge.find_by(keyword: @payload).response
      else
        "Sorry, I don't know how to respond to #{@payload}"
      end
    end
  end

  def coordinates
    Geocoder.coordinates(@payload)
  end

  def weather
    ForecastIO.forecast(coordinates[0], coordinates[1])
  end
end
