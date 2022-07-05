terraform {
 required_version = "1.0.0" 
 backend "gcs" {
    bucket="tf-state-il" 
    prefix="terraform/np"
  }
}
