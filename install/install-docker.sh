brew install --cask docker

open /Applications/Docker.app
sleep 60 # give it time to open

docker pull opencoconut/ffmpeg:latest
docker pull minidocks/poppler:latest
docker pull avitase/docker-imagemagick:latest
