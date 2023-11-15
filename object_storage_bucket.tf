# Create a compute instance
resource "oci_core_instance" "example_instance" {
  availability_domain = "YOUR_AVAILABILITY_DOMAIN"
  compartment_id = "YOUR_COMPARTMENT_OCID"
  display_name = "example-instance"
  shape = "YOUR_INSTANCE_SHAPE"
  image_id = "YOUR_IMAGE_OCID"
  subnet_id = "YOUR_SUBNET_OCID"

  # You can specify your block volume attachments here
  block_volume_attachments {
    volume_id = "YOUR_BLOCK_VOLUME_OCID"
  }
}

# Create an Object Storage bucket
resource "oci_objectstorage_bucket" "example_bucket" {
  name = "backup-bucket"
  compartment_id = "YOUR_COMPARTMENT_OCID"
}

# Create a scheduled block volume snapshot
resource "oci_core_volume_backup_policy_assignment" "example_snapshot" {
  display_name = "example-snapshot"
  resource_id = oci_core_instance.example_instance.id
  policy_id = oci_core_volume_backup_policy.example_policy.id
}

resource "oci_core_volume_backup_policy" "example_policy" {
  display_name = "example-policy"
  compartment_id = "YOUR_COMPARTMENT_OCID"
  schedules {
    # Set the schedule to take hourly backups
    cron_schedule = "0 * * * *"
  }
  type = "CUSTOM"
  retention_in_days = 7
  volume_id = "YOUR_BLOCK_VOLUME_OCID"
}

# Grant permissions to the compute instance to write snapshots to the Object Storage bucket
resource "oci_identity_policy" "example_policy" {
  name = "example-policy"
  compartment_id = "YOUR_COMPARTMENT_OCID"
  statements = [
    "Allow service objectstorage-policies to use buckets in compartment YOUR_COMPARTMENT",
    "Allow service blockstorage to read snapshots in compartment YOUR_COMPARTMENT",
    "Allow service blockstorage to manage volumes in compartment YOUR_COMPARTMENT",
    "Allow any-user to manage buckets in compartment YOUR_COMPARTMENT where request.principal.type = 'Instance'",
  ]
}
