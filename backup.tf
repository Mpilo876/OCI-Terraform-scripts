# 2 answers found for backup workload that backs up in an hours time not daily#####

#oracle database backup service 

provider "oci" {
  # Configure your Oracle Cloud provider settings here
}

resource "oci_database_db_system" "my_db" {
  # Define your DB System configuration
  # ...
}

resource "oci_database_db_home" "my_db_home" {
  # Define your DB Home configuration
  # ...
}

resource "oci_database_db_backup_destination" "backup_destination" {
  db_system_id = oci_database_db_system.my_db.id
  type = "LOCAL"
  display_name = "Hourly Backup Destination"
}

resource "oci_database_db_backup_config" "hourly_backup" {
  db_system_id = oci_database_db_system.my_db.id
  db_home_id = oci_database_db_home.my_db_home.id
  db_backup_destination_id = oci_database_db_backup_destination.backup_destination.id
  backup_type = "INCREMENTAL"
  backup_window_start_time = "23:00"
  freeform_tags = {
    "Frequency" = "Hourly"
  }
}

#OCI object storage 
provider "oci" {
  # Configure your Oracle Cloud provider settings here
}

resource "oci_objectstorage_bucket" "backup_bucket" {
  name = "my-hourly-backups"
  compartment_id = var.compartment_id
  force_destroy = true
}

resource "oci_objectstorage_bucket_objects" "backup_objects" {
  bucket = oci_objectstorage_bucket.backup_bucket.name
  source = "/path/to/local/backup/files/*"
}

resource "oci_objectstorage_bucket_event_rule" "hourly_backup_rule" {
  compartment_id = var.compartment_id
  bucket = oci_objectstorage_bucket.backup_bucket.name
  name = "hourly-backup-rule"
  enabled = true
  event_type = "com.oraclecloud.objectstorage.createobject"
  condition {
    name = "hourly-condition"
    sourceservice = "all"
  }
  actions {
    name = "hourly-action"
    action_type = "com.oraclecloud.notification.ONS"
    topic = var.notification_topic_id
  }
}
