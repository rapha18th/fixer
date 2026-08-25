tool "issue_refund" {
  description = "Refund a customer's order"
  instructions = "Use this when a customer asks for a refund and the order is eligible (status must be 'delivered'). Always confirm the order ID and email first with check_order_status. Explain the outcome to the customer afterward."
  input {
    int order_id { description = "The order ID to refund" }
    email email filters=lower { description = "The customer's email address, used to verify they own this order" }
    text reason? filters=trim { description = "Why the refund is being issued" }
  }
  stack {
    function.run "issue_refund" {
      input = { order_id: $input.order_id, email: $input.email, reason: $input.reason }
    } as $result
  }
  response = $result
  guid = "-O8GJJZave1104R6lFdxE4ns3kM"
}
