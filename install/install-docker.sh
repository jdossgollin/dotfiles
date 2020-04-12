brew cask install docker

open /Applications/Docker.app
sleep 60

docker pull tianon/latex:latest
docker pull pandoc/latex:latest
docker pull jekyll/jekyll:3.8
