query "escalate-to-human" verb=POST {
  api_group = "actions"
  description = "Escalate to a human agent"
  auth = "none"
  input {
    int customer_id
    email email filters=lower
    text reason filters=trim
  }
  stack {
    function.run "escalate_to_human" {
      input = { customer_id: $input.customer_id, email: $input.email, reason: $input.reason }
    } as $result
  }
  response = $result
  guid = "hVJq4dtxOmDaHmV_fMZheJREYiQ"
}
