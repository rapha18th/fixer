function "issue_refund" {
  input {
    int order_id
    email email filters=lower
    text reason? filters=trim
  }
  stack {
    db.get "order" {
      field_name = "id"
      field_value = $input.order_id
    } as $order
    precondition ($order != null) {
      error_type = "notfound"
      error = "Order not found"
    }

    db.get "customer" {
      field_name = "id"
      field_value = $order.customer_id
    } as $customer
    precondition ($customer != null) {
      error_type = "notfound"
      error = "Customer not found"
    }
    precondition ($customer.email == $input.email) {
      error_type = "accessdenied"
      error = "Email does not match this order"
    }
    precondition ($order.status != "refunded") {
      error_type = "inputerror"
      error = "This order has already been refunded"
    }
    precondition ($order.status == "delivered") {
      error_type = "inputerror"
      error = "Only delivered orders are eligible for refund"
    }

    db.edit "order" {
      field_name = "id"
      field_value = $order.id
      data = { status: "refunded" }
    } as $updated_order

    db.add "ticket" {
      data = {
        customer_id: $customer.id,
        order_id: $order.id,
        category: "refund",
        status: "resolved",
        action_taken: "Refund issued for order #" ~ ($order.id|to_text),
        reason: $input.reason,
        resolved_at: now
      }
    } as $ticket

    api.realtime_event {
      channel = "ticket_feed"
      auth_id = null
      data = { event: "ticket_resolved", ticket: $ticket, customer_name: $customer.name }
    }
  }
  response = { success: true, order: $updated_order, ticket: $ticket }
  guid = "E_Vp7Xgx0ux5Qw2TDzKsGVid5S8"
}
