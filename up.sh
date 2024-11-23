sudo rm -rf _site .jellyfish-cache .jekyll-metadata
docker compose build --no-cache
docker compose down
docker compose up
