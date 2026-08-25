table "order" {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    int customer_id {
      table = "customer"
    }
    decimal amount filters=min:0
    enum status?="pending" {
      values = ["pending", "delivered", "refunded"]
    }
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "customer_id"}]}
  ]
  guid = "cn3uevtEQVs7FJrGXbr7C0fboEA"
}
