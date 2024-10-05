resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "url-shortener"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "short_id"

  attribute {
    name = "short_id"
    type = "S"
  }

  attribute {
    name = "original_url"
    type = "S"
  }
}