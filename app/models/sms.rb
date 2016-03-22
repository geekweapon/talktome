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
    elsif @payload == "poostachio"
      "Hi Mustachio, I <3 you."
    else
      "Sorry, but I don't know how to respond to, #{@payload}. Send 'help' for more information"
    end
  end
end
