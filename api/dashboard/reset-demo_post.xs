query "reset-demo" verb=POST {
  api_group = "dashboard"
  description = "Wipes and reseeds demo data with five fictional customers, each set up to demo one of Fixer's five actions. Destructive — for demo prep only, safe to call as many times as needed."
  auth = "none"
  input { }
  stack {
    db.truncate "ticket" { reset = true }
    db.truncate "order" { reset = true }
    db.truncate "customer" { reset = true }

    db.add "customer" {
      data = { name: "Marcus Webb", email: "marcus.webb@northfield.dev", plan: "pro", service_status: "suspended", trial_ends_at: null }
    } as $c1
    db.add "order" { data = { customer_id: $c1.id, amount: 149.00, status: "delivered" } } as $o1

    db.add "customer" {
      data = { name: "Elena Cross", email: "elena.cross@brightloop.io", plan: "free", service_status: "active", trial_ends_at: null }
    } as $c2
    db.add "order" { data = { customer_id: $c2.id, amount: 29.00, status: "pending" } } as $o2

    db.add "customer" {
      data = { name: "Dara Osei", email: "dara.osei@fernbridge.dev", plan: "pro", service_status: "active", trial_ends_at: now }
    } as $c3

    db.add "customer" {
      data = { name: "Priya Shah", email: "priya.shah@moatline.io", plan: "free", service_status: "suspended", trial_ends_at: null }
    } as $c4
    db.add "order" { data = { customer_id: $c4.id, amount: 89.00, status: "delivered" } } as $o4

    db.add "customer" {
      data = { name: "Tomas Reyes", email: "tomas.reyes@haldercreek.com", plan: "pro", service_status: "active", trial_ends_at: null }
    } as $c5
    db.add "order" { data = { customer_id: $c5.id, amount: 199.00, status: "refunded" } } as $o5
  }
  response = {
    reset: true,
    business: "Loopline",
    customers: [
      { name: "Marcus Webb", id: $c1.id, order_id: $o1.id, try: "restart service, or refund order " ~ $o1.id ~ " (delivered, eligible)" },
      { name: "Elena Cross", id: $c2.id, order_id: $o2.id, try: "refund order " ~ $o2.id ~ " (pending, should be refused)" },
      { name: "Dara Osei", id: $c3.id, try: "extend trial, ending today" },
      { name: "Priya Shah", id: $c4.id, order_id: $o4.id, try: "escalate to a human" },
      { name: "Tomas Reyes", id: $c5.id, order_id: $o5.id, try: "check order status on an already-refunded order" }
    ]
  }
  guid = "hTgCFBEVYtuXhKDPhYsmySZICaQ"
}
