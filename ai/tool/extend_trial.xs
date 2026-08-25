tool "extend_trial" {
  description = "Extend a customer's trial period"
  instructions = "Use this when a customer asks for more time on their trial. Default extension is 7 days unless the customer asks for a specific number."
  input {
    int customer_id { description = "The customer ID whose trial should be extended" }
    email email filters=lower { description = "The customer's email address, used to verify identity" }
    int days?=7 { description = "Number of days to extend the trial by" }
  }
  stack {
    function.run "extend_trial" {
      input = { customer_id: $input.customer_id, email: $input.email, days: $input.days }
    } as $result
  }
  response = $result
  guid = "NRy094ELml6pyy8W08VlojXrAuI"
}
