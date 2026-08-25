query "customers" verb=GET {
  api_group = "dashboard"
  description = "List customers"
  auth = "none"
  input { }
  stack {
    db.query "customer" {
      sort = { created_at: "desc" }
    } as $customers
  }
  response = $customers
  guid = "4xSHCvxX9F2bEFRrcdEddmnuqAQ"
}
