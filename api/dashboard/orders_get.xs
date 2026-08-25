query "orders" verb=GET {
  api_group = "dashboard"
  description = "List orders"
  auth = "none"
  input { }
  stack {
    db.query "order" {
      sort = { created_at: "desc" }
    } as $orders
  }
  response = $orders
  guid = "aHL4mh7aLfwCBkP-Dibp0OsN4KU"
}
