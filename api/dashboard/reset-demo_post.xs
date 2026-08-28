query "reset-demo" verb=POST {
  api_group = "dashboard"
  description = "Wipes and reseeds demo data around a single customer (Rairo Mukamuri) so every case is demoable under one name. Destructive — for demo prep only, safe to call as many times as needed before recording."
  auth = "none"
  input { }
  stack {
    db.truncate "ticket" { reset = true }
    db.truncate "order" { reset = true }
    db.truncate "customer" { reset = true }

    db.add "customer" {
      data = { name: "Rairo Mukamuri", email: "rairorr@gmail.com", plan: "pro", service_status: "suspended", trial_ends_at: now }
    } as $c1

    db.add "order" { data = { customer_id: $c1.id, amount: 149.00, status: "delivered" } } as $o1
    db.add "order" { data = { customer_id: $c1.id, amount: 29.00, status: "pending" } } as $o2
  }
  response = {
    reset: true,
    business: "Loopline",
    customer: "Rairo Mukamuri",
    customer_id: $c1.id,
    order_delivered_id: $o1.id,
    order_pending_id: $o2.id,
    service_status: "suspended"
  }
  guid = "hTgCFBEVYtuXhKDPhYsmySZICaQ"
}
