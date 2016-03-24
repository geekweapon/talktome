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
    if @payload == "hi"
      "Hello there, I'm a bot how are you?"
    elsif @payload == "bye"
      "Goodbye lone wolf... I will miss you"
    elsif @payload == "how are you?"
      "I'm doing fine, how are you?  Lovely weather we're having"
    elsif @payload == "joke"
      "Why doesn't Texas float off into the Gulf of Mexico? Because Oklahoma sucks."
    elsif @payload == "help me"
      "Available commands: 'joke', 'hi', 'bye', 'how are you?', 'weather'"
    elsif @payload == "weather"
      "Enter your five digit US zip code i.e. 77057"
    elsif @payload.match(/\d{5}/)
      "Current conditions are #{weather.currently.summary} with a temperature of #{weather.currently.temperature}F"
    else
      "Sorry, but I don't know how to respond to, #{@payload}. Send 'help me' for more information"
    end
  end

  def coordinates
    Geocoder.coordinates(@payload)
  end

  def weather
    ForecastIO.forecast(coordinates[0], coordinates[1])
  end
end
