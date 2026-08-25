query "seed" verb=POST {
  api_group = "dashboard"
  description = "Seeds demo customers and orders. Safe to call multiple times; skips if data already exists."
  auth = "none"
  input { }
  stack {
    db.query "customer" {
      return = { type: "count" }
    } as $existing_count
    conditional {
      if ($existing_count == 0) {
        db.add "customer" {
          data = { name: "Amara Okonkwo", email: "amara@northwind.io", plan: "pro", service_status: "suspended", trial_ends_at: now }
        } as $c1
        db.add "customer" {
          data = { name: "Diego Fernandez", email: "diego@brightpath.co", plan: "free", service_status: "active" }
        } as $c2
        db.add "order" {
          data = { customer_id: $c1.id, amount: 149.00, status: "delivered" }
        } as $o1
        db.add "order" {
          data = { customer_id: $c2.id, amount: 29.00, status: "pending" }
        } as $o2
      }
    }
  }
  response = { seeded: ($existing_count == 0) }
  guid = "2JV0yA-JoE47es0Et0LkUpHXwCM"
}
