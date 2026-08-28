query "reset-demo" verb=POST {
  api_group = "dashboard"
  description = "Wipes and reseeds demo data for Loopline, a fictional project-management SaaS. Destructive — for demo prep only, safe to call as many times as needed before recording."
  auth = "none"
  input { }
  stack {
    db.truncate "ticket" { reset = true }
    db.truncate "order" { reset = true }
    db.truncate "customer" { reset = true }

    db.add "customer" {
      data = { name: "Amara Okonkwo", email: "amara@northwind.io", plan: "pro", service_status: "active", trial_ends_at: now }
    } as $c1
    db.add "customer" {
      data = { name: "Diego Fernandez", email: "diego@brightpath.co", plan: "free", service_status: "active" }
    } as $c2
    db.add "customer" {
      data = { name: "Priya Natarajan", email: "priya@quicklaunch.dev", plan: "pro", service_status: "active" }
    } as $c3
    db.add "customer" {
      data = { name: "Marcus Chen", email: "marcus@fernwoodstudio.com", plan: "free", service_status: "suspended" }
    } as $c4
    db.add "customer" {
      data = { name: "Sofia Martins", email: "sofia@driftlabs.io", plan: "pro", service_status: "active" }
    } as $c5
    db.add "customer" {
      data = { name: "Tobias Reinholt", email: "tobias@haventech.no", plan: "free", service_status: "active" }
    } as $c6
    db.add "customer" {
      data = { name: "Rairo Mukamuri", email: "rairorr@gmail.com", plan: "pro", service_status: "active" }
    } as $c7

    db.add "order" { data = { customer_id: $c1.id, amount: 149.00, status: "delivered" } } as $o1
    db.add "order" { data = { customer_id: $c2.id, amount: 29.00, status: "pending" } } as $o2
    db.add "order" { data = { customer_id: $c3.id, amount: 299.00, status: "delivered" } } as $o3
    db.add "order" { data = { customer_id: $c4.id, amount: 49.00, status: "refunded" } } as $o4
    db.add "order" { data = { customer_id: $c5.id, amount: 199.00, status: "delivered" } } as $o5
    db.add "order" { data = { customer_id: $c6.id, amount: 19.00, status: "pending" } } as $o6
    db.add "order" { data = { customer_id: $c7.id, amount: 89.00, status: "delivered" } } as $o7

    db.add "ticket" {
      data = {
        customer_id: $c4.id,
        order_id: $o4.id,
        category: "refund",
        status: "resolved",
        action_taken: "Refund issued for order #" ~ ($o4.id|to_text),
        reason: "Accidentally purchased a duplicate plan",
        resolved_at: now
      }
    } as $t1
    db.add "ticket" {
      data = {
        customer_id: $c3.id,
        category: "restart",
        status: "resolved",
        action_taken: "Service restarted",
        resolved_at: now
      }
    } as $t2
    db.add "ticket" {
      data = {
        customer_id: $c5.id,
        category: "escalation",
        status: "escalated",
        reason: "Wants a custom enterprise contract, needs sales"
      }
    } as $t3
  }
  response = {
    reset: true,
    business: "Loopline",
    customers: 7,
    orders: 7,
    tickets: 3
  }
  guid = "hTgCFBEVYtuXhKDPhYsmySZICaQ"
}
