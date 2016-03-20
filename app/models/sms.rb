class SMS
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
      "Hello there, how are you?"
    elsif @payload == "bye"
      "Goodbye lone wolf... I will miss you"
    elsif @payload == "how are you?"
      "I'm doing fine, how are you?  Lovely weather we're having"
    elsif @payload == "joke"
      "Did you hear the one about the one-legged dog?"
    else
      "Thanks for stalking me, your phone number is #{@from_number}, your message was #{@payload}"
    end
  end
end
