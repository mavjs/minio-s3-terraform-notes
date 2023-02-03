terraform {
    backend "s3" {
	bucket = "test"
	key = "minio-svc/terraform"

	/*
	* These are required to work with non-AWS S3 compatible backends
	* See: https://developer.hashicorp.com/terraform/language/settings/backends/s3#configuration
	*/
	skip_credentials_validation = true
	skip_metadata_api_check = true
	skip_region_validation = true
	force_path_style = true
    }
}

resource "null_resource" "test" {
}
