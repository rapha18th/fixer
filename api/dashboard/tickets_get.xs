query "tickets" verb=GET {
  api_group = "dashboard"
  description = "List recent support tickets with the customer's name and email"
  auth = "none"
  input {
    int limit?=50
  }
  stack {
    db.query "ticket" {
      join = {
        customer: { table: "customer", type: "inner", where: $db.ticket.customer_id == $db.customer.id }
      }
      eval = { customer_name: $db.customer.name, customer_email: $db.customer.email }
      sort = { created_at: "desc" }
      return = { type: "list", paging: { page: 1, per_page: $input.limit } }
    } as $tickets
  }
  response = $tickets
  guid = "OZZBEQNH8Zd6ArvqFzXL2_Q8sRQ"
}
