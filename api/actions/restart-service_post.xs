query "restart-service" verb=POST {
  api_group = "actions"
  description = "Restart a customer's suspended service"
  auth = "none"
  input {
    int customer_id
    email email filters=lower
  }
  stack {
    function.run "restart_service" {
      input = { customer_id: $input.customer_id, email: $input.email }
    } as $result
  }
  response = $result
  guid = "hU5cc9MEYkX4TKO_eQyHE-Tz-Nk"
}
