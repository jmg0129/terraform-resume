# ──────────────────────────────────────────────
# DynamoDB — Visit Counter
# ──────────────────────────────────────────────

resource "aws_dynamodb_table" "counter" {
  name         = "resume_counter"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
