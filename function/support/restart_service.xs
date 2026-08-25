function "restart_service" {
  input {
    int customer_id
    email email filters=lower
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

    db.edit "customer" {
      field_name = "id"
      field_value = $customer.id
      data = { service_status: "active" }
    } as $updated_customer

    db.add "ticket" {
      data = {
        customer_id: $customer.id,
        category: "restart",
        status: "resolved",
        action_taken: "Service restarted",
        resolved_at: now
      }
    } as $ticket

    api.realtime_event {
      channel = "ticket_feed"
      auth_id = null
      data = { event: "ticket_resolved", ticket: $ticket, customer_name: $customer.name }
    }
  }
  response = { success: true, customer: $updated_customer, ticket: $ticket }
  guid = "_wgyLAX412SzGVmEluBggQfMGug"
}
