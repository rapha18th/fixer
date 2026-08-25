tool "escalate_to_human" {
  description = "Escalate the conversation to a human support agent"
  instructions = "Use this when the request falls outside your other tools, the customer is upset, or you are not confident in the right action. Always explain to the customer that a human will follow up."
  input {
    int customer_id { description = "The customer ID to escalate" }
    email email filters=lower { description = "The customer's email address, used to verify identity" }
    text reason filters=trim { description = "Why this is being escalated" }
  }
  stack {
    function.run "escalate_to_human" {
      input = { customer_id: $input.customer_id, email: $input.email, reason: $input.reason }
    } as $result
  }
  response = $result
  guid = "rOFjxXF7tgx5iE5V8GyVR-UOeW8"
}
