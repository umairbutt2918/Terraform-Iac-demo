resource "aws_cloudwatch_log_group" "demo_logs" {
 name = "terraform-demo-logs"
 retention_in_days = 7
}