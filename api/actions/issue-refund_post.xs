query "issue-refund" verb=POST {
  api_group = "actions"
  description = "Refund an order"
  auth = "none"
  input {
    int order_id
    email email filters=lower
    text reason? filters=trim
  }
  stack {
    function.run "issue_refund" {
      input = { order_id: $input.order_id, email: $input.email, reason: $input.reason }
    } as $result
  }
  response = $result
  guid = "N_k8N8I8TBuk6ZiPGRvxJOJ5pTc"
}
