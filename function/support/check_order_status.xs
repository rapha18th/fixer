function "check_order_status" {
  input {
    int order_id
    email email filters=lower
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
  }
  response = {
    order_id: $order.id,
    status: $order.status,
    amount: $order.amount,
    customer_name: $customer.name,
    created_at: $order.created_at
  }
  guid = "XoT9AOykoEnC3iCxe6BR1qVmu-c"
}
