# Production environment
This is a possible production-like environment to use Overleaf with separated microservices.

To run this container, run the following scripts:
```bash
./build-images.sh # Regenerate the images from the repository
./initial-setup.sh # Generate directories to use as bind-mounts, with the correct permissions
docker compose up -d
```

# S3 setup
There is a ```docker-compose-s3.yml``` file that is meant to test an S3 deployment. It installs 
minio as S3 backend. To use it, follow these steps:

 * Edit ```production.env``` and enable the environment variables related with S3.
 * Prepare the folders by running ```./initial-setup.sh``` (otherwise, you will need to check the permission afterwards).
 * Start the minio container: ```docker compose -f docker-compose-s3.yml up minio -d```.
 * Run the setup script to configure the minio server: ```docker compose -f docker-compose-s3.yml exec minio /overleaf-policies/minio-setup```.
 * Start all containers: ```docker compose -f docker-compose-s3.yml up -d```
