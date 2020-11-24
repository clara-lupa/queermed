class MessagesController < ApplicationController
  def new
    @message = message.new
  end

  def create
    # if there is no conversation yet: generate new conversation @conversation (after init conv button)
    # else take the given conversation (inside the messages index)
  end

  def index
  end
end
