resource "google_composer_environment" "airflow-test" {
  name   = "airflow-test-env"
  region = var.region
  config {
      node_count = 3

      node_config {
          zone = var.zone   
    }
  }
}

data "external" "get_selflink" {
  program = ["/bin/sh", "./grp-instance.sh"]
  depends_on = [google_composer_environment.airflow-test]
}

resource "google_compute_autoscaler" "autoscaler_composer" {
  name   = "autoscaler-composer"
  zone   = var.zone
  target = lookup(data.external.get_selflink.result, "self_link")
  depends_on = [google_composer_environment.airflow-test]
  
  autoscaling_policy {
    max_replicas    = 10
    min_replicas    = 3
    cooldown_period = 60

    cpu_utilization {
      target = 0.8
    }
  }
}