terraform {
  backend "s3" {
    bucket         = "3tier-aws-bucket"
    key            = "terraform/tfstate"
    region         = "us-east-1"
    use_lockfile = true  # Versioning in s3 must be enabled so no need to create the dynamodb table
    encrypt        = true
    
  }
}
