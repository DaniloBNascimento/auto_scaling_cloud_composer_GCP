terraform {
  backend "gcs" {
    bucket = "lab-terraform"
    prefix = "lab-terraform/state-composer"
  }
}