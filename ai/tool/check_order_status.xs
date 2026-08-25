tool "check_order_status" {
  description = "Look up the status of a customer order"
  instructions = "Use this to check an order's status before taking any action on it. Requires the order ID and the customer's email to confirm identity."
  input {
    int order_id { description = "The order ID to check" }
    email email filters=lower { description = "The customer's email address, used to verify they own this order" }
  }
  stack {
    function.run "check_order_status" {
      input = { order_id: $input.order_id, email: $input.email }
    } as $result
  }
  response = $result
  guid = "vvGSQkXxtyAQJ9K0IKvoUKtkWoA"
}
