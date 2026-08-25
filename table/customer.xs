table "customer" {
  auth = false
  schema {
    int id
    timestamp created_at?=now
    text name filters=trim
    email email filters=trim|lower
    enum plan?="free" {
      values = ["free", "pro"]
    }
    enum service_status?="active" {
      values = ["active", "suspended"]
    }
    timestamp trial_ends_at?
  }
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree|unique", field: [{name: "email"}]}
  ]
  guid = "EGMeilt_PJl70kfQZRJdiY1noR4"
}
