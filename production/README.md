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

```bash
./build-images.sh
./initial-setup.sh
docker compose -f docker-compose-s3.yml up minio -d
sleep 5 # Wait for minio to come up - can also be checked with docker compose -f docker-compose-s3.yml logs -f
docker compose -f docker-compose-s3.yml exec minio /overleaf-policies/minio-setup
docker compose -f docker-compose-s3.yml up -d
```

# docker-compose with public images

The file ```docker-compose-ghcr.yml``` is configured to use images published
in the public repositories. Hence, it can be used by just running:

```bash
docker pull ghcr.io/robol/overleaf-texlive-full # The image should be available for compiles to work
./initial-setup.sh # or manual directory creation ...
docker compose -f docker-compose-ghcr.yml up -d
```
