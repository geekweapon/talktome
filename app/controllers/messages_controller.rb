class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def reply
    SMS.new(params["From"], params["Body"]).send
  end
end
