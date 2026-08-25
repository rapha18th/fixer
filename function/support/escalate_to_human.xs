function "escalate_to_human" {
  input {
    int customer_id
    email email filters=lower
    text reason filters=trim
  }
  stack {
    db.get "customer" {
      field_name = "id"
      field_value = $input.customer_id
    } as $customer
    precondition ($customer != null) {
      error_type = "notfound"
      error = "Customer not found"
    }
    precondition ($customer.email == $input.email) {
      error_type = "accessdenied"
      error = "Email does not match this account"
    }

    db.add "ticket" {
      data = {
        customer_id: $customer.id,
        category: "escalation",
        status: "escalated",
        reason: $input.reason
      }
    } as $ticket

    api.realtime_event {
      channel = "ticket_feed"
      auth_id = null
      data = { event: "ticket_escalated", ticket: $ticket, customer_name: $customer.name }
    }
  }
  response = { success: true, ticket: $ticket }
  guid = "H7lI8U42yiC37tCTiQjFa2tSyPU"
}
