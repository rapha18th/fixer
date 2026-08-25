realtime_channel "ticket_feed" {
  description = "Live feed of support actions Fixer takes on real accounts"
  active = true

  public_messaging = { active: true, auth: false }
  private_messaging = { active: false, auth: false }

  settings = {
    anonymous_clients: true,
    nested_channels: false,
    message_history: 100,
    auth_channel: false,
    presence: false
  }
}
