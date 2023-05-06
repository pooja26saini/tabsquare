terraform {
  required_version = ">= 0.13"
  required_providers {

    google = {
      source  = "hashicorp/google"
      version = ">= 3.53, < 5.0"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-pubsub:cloudiot/v3.2.0"
  }

}
resource "google_pubsub_schema" "example" {
  name = "example"
  type = "AVRO"
  definition = "{\n  \"type\" : \"record\",\n  \"name\" : \"Avro\",\n  \"fields\" : [\n    {\n      \"name\" : \"StringField\",\n      \"type\" : \"string\"\n    },\n    {\n      \"name\" : \"IntField\",\n      \"type\" : \"int\"\n    }\n  ]\n}\n"
}

resource "google_pubsub_topic" "example" {
  name = "example-topic"

  depends_on = [google_pubsub_schema.example]
  schema_settings {
    schema = "projects/my-project-name/schemas/example"
    encoding = "JSON"
  }
}