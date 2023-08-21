# resource "aws_s3_bucket" "ashprince101" {
#   bucket = "ashprince101"
#   # acl    = "private"
#   # versioning {
#   #   enabled = true
#   # }
# }

# resource "aws_s3_bucket_public_access_block" "ashprince101_access_block" {
#   bucket = aws_s3_bucket.ashprince101.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_versioning" "versioning_ashprince101" {
#   bucket = aws_s3_bucket.ashprince101.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }
