# Production environment
This is a possible production-like environment to use Overleaf with separated microservices.

To run this container, run the following scripts:
```bash
./build-images.sh # Regenerate the images from the repository
./initial-setup.sh # Generate directories to use as bind-mounts, with the correct permissions
docker compose up -d
```
