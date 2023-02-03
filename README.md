# Minio Dev Server and Terraform Plan Notes
Credits to: https://pet2cattle.com/2021/06/minio-backend-terraform

## Run Minio Dev Server
Ref: https://min.io/docs/minio/container/operations/installation.html

### Podman
Create a podman volume to store Minio data (optional)
```bash
podman volume create minio
```

Run minio server
```bash
podman run -dt -p 9000:9000 -p 9999:9090 -v minio:/data -e "MINIO_ROOT_USER=<admin_user>" -e "MINIO_ROOT_PASSWORD=<admin_password" quay.io/minio/minio server /data --console-address ":9090"
```

### Docker
Run minio server
```bash
docker run -dt -p 9000:9000 -p 9999:9090 -v $(pwd):/data -e "MINIO_ROOT_USER=<admin_user>" -e "MINIO_ROOT_PASSWORD=<admin_password" quay.io/minio/minio server /data --console-address ":9090"
```

Access the Minio console at: `http://127.0.0.1:9999` and API at: `http://127.0.0.1:9000`

### Minio Configurations
* Create Access Key and Access Secret Key
    * Go to `http://127.0.0.1:9999/access-keys`
    * Click `Create Access Key`
    * Note down the `Access Key` and `Secret Key` values

* Create bucket
    * Go to `http://127.0.0.1:9999/buckets`
    * Click `Create Bucket`
    * Type in `Bucket Name`
    * Check `Versioning` to `ON`

## Set environment variables
* `AWS_S3_ENDPOINT` - should point to your Minio server's API endpoint, e.g., `http://127.0.0.1:9000`
* `AWS_REGION` - can name it whatever you want, or if you want to leave it blank, make sure to make it a single space between quotes.
* `AWS_ACCESS_KEY_ID` - the `Access Key` you got from above
* `AWS_SECRET_ACCESS_KEY` - the `Secret Key` you got from above

Example:
```bash
export AWS_S3_ENDPOINT="http://127.0.0.1:9000"
export AWS_REGION=" "
export AWS_SECRET_ACCESS_KEY="myaccesskey12345"
export AWS_ACCESS_KEY_ID="hunter123"
```
## Terraform Backend Configuration
* `bucket` - the name of the bucket you created above
* `key` - name of the state file inside the bucket.

The example configurations in the `main.tf` will create a state file called `terraform` under the `minio-svc` folder, inside the `test` bucket.

## Run Terraform
Initialize terraform
```bash
terraform init
```

Check terraform plan
```bash
terraform plan
```

Apply terraform
```bash
terraform apply
```

Check plan file in: `http://127.0.0.1:9999/browser/<bucket_name>/`