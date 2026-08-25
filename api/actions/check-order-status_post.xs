query "check-order-status" verb=POST {
  api_group = "actions"
  description = "Look up an order's status"
  auth = "none"
  input {
    int order_id
    email email filters=lower
  }
  stack {
    function.run "check_order_status" {
      input = { order_id: $input.order_id, email: $input.email }
    } as $result
  }
  response = $result
  guid = "Bz4L3IthM4xHimcvPyunOQVzxZs"
}
