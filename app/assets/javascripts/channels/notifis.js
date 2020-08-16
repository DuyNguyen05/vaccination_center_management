App.notifis = App.cable.subscriptions.create("NotifisChannel", {
  connected: function () {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function () {
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    console.log(data);
    $("#notificationList").prepend(data.notification);
    $(".open_notification").html(data.counter);
  },
});