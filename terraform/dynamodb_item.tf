resource "aws_dynamodb_table_item" "initial_string" {
  table_name = aws_dynamodb_table.dynamic_string.name
  hash_key   = "id"

  item = jsonencode({
    id    = { S = "string" }
    value = { S = "Hola desde Santiago" }
  })
}
