terraform {
  backend "s3" {
    bucket = "terraform-state-mateus-clc16-178708743664-us-east-1-an"
    key    = "terraform/state"
    region = "us-east-1"
    #    use_lockfile = true
    #    encrypt = true
  }
}