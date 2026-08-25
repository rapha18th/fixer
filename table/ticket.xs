table "ticket" {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    int customer_id {
      table = "customer"
    }
    int order_id? {
      table = "order"
    }
    enum category {
      values = ["refund", "restart", "trial", "escalation"]
    }
    enum status?="open" {
      values = ["open", "resolved", "escalated"]
    }
    text action_taken?
    text reason?
    timestamp resolved_at?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "customer_id"}]}
    {type: "btree", field: [{name: "status"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
  guid = "DQS5r1owdvtiuwlqMwdl_-Y_hYQ"
}
