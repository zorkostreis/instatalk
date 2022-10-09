App.online_users = App.cable.subscriptions.create 'OnlineUsersChannel',
  connected: ->
    console.log('Connected to OnlineUsersChannel')

  disconnected: ->
    console.log('Disconnected from OnlineUsersChannel')

  received: (data) ->
    console.log(data)
    
    users = data['users'].map (nickname) -> "<li>#{nickname}</li>"
    $('#online').html(users)
