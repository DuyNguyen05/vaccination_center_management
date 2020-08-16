class NotifisChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifis_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end