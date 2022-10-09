class OnlineUsersChannel < ApplicationCable::Channel
  def subscribed
    @list_name = 'current_online_users_nicknames'

    stream_from 'online_users_channel'

    $redis.rpush(@list_name, nickname)
    appear
  end

  def unsubscribed
    $redis.lrem(@list_name, 1, nickname)
    appear
  end

  def appear
    @users = $redis.lrange(@list_name, 0, -1)
    ActionCable.server.broadcast('online_users_channel', { users: @users.uniq })
  end

  private

  def nickname
    current_user.nickname
  end
end
