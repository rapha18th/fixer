tool "restart_service" {
  description = "Restart a suspended customer's service"
  instructions = "Use this when a customer's service is down or suspended and they ask for it to be restarted."
  input {
    int customer_id { description = "The customer ID whose service needs restarting" }
    email email filters=lower { description = "The customer's email address, used to verify identity" }
  }
  stack {
    function.run "restart_service" {
      input = { customer_id: $input.customer_id, email: $input.email }
    } as $result
  }
  response = $result
  guid = "e_oUHe4lx8ZvYO0glc2zsXK1dOw"
}
