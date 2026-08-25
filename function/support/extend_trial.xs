function "extend_trial" {
  input {
    int customer_id
    email email filters=lower
    int days?=7
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

    var $base { value = $customer.trial_ends_at ?? now }
    var $new_trial_end { value = $base|transform_timestamp: ("+" ~ ($input.days|to_text) ~ " days") }

    db.edit "customer" {
      field_name = "id"
      field_value = $customer.id
      data = { trial_ends_at: $new_trial_end }
    } as $updated_customer

    db.add "ticket" {
      data = {
        customer_id: $customer.id,
        category: "trial",
        status: "resolved",
        action_taken: "Trial extended by " ~ ($input.days|to_text) ~ " days",
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
  guid = "la3mVWoi4Hje6Uf_dUz9ZY1flEc"
}
