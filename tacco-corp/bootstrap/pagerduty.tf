# data "pagerduty_user" "me" {
#   email = "me@example.com"
# }

# data "pagerduty_team" "devops" {
#   name = "devops"
# }

# resource "pagerduty_escalation_policy" "service" {
#   name      = "DevOps Escalation Policy for ${var.service}"
#   num_loops = 2

#   teams = [data.pagerduty_team.devops.id]

#   rule {
#     escalation_delay_in_minutes = 10

#     target {
#       type = "user"
#       id   = data.pagerduty_user.me.id
#     }
#   }
# }

# resource "pagerduty_service" "service" {
#   name                    = var.service
#   auto_resolve_timeout    = 14400
#   acknowledgement_timeout = 600
#   escalation_policy       = pagerduty_escalation_policy.service.id
#   alert_creation          = "create_alerts_and_incidents"
# }
