resource "aws_sqs_queue" "event_queue" {
  name                      = "event-queue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
}