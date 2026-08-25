query "extend-trial" verb=POST {
  api_group = "actions"
  description = "Extend a customer's trial"
  auth = "none"
  input {
    int customer_id
    email email filters=lower
    int days?=7
  }
  stack {
    function.run "extend_trial" {
      input = { customer_id: $input.customer_id, email: $input.email, days: $input.days }
    } as $result
  }
  response = $result
  guid = "R0lFTRMYhv77_0KgL2EQyuqnVPg"
}
