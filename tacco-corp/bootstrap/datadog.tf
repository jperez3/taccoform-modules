resource "datadog_monitor" "service" {

  count = var.enable_dd_monitor

  name               = "basic monitor for ${var.service}"
  type               = "metric alert"
  message            = "Monitor triggered. Notify: @operations-team"
  escalation_message = "Escalation message @pagerduty-${var.service}"

  query = "avg(last_1h):avg:aws.ec2.cpu{environment:prod,host:foo} by {host} > 4"

  monitor_thresholds {
    warning           = 2
    warning_recovery  = 1
    critical          = 4
    critical_recovery = 3
  }

  notify_no_data    = false
  renotify_interval = 60

  notify_audit = false
  include_tags = true

  tags = ["service:${var.service}", "env:prod"]
}
