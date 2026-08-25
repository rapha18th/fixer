query "chat" verb=POST {
  api_group = "dashboard"
  description = "Text-chat fallback that talks to the Fixer agent directly"
  auth = "none"
  input {
    text message filters=trim
  }
  stack {
    ai.agent.run "Fixer" {
      args = { message: $input.message }
      allow_tool_execution = true
    } as $agent_result
  }
  response = $agent_result
  guid = "TXp4FK7QeEYWq75jU3jF5O-iWAw"
}
