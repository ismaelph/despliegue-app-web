alias php='docker run -u $(id -u):$(id -g) --rm -it -v $(pwd):/usr/src/myapp -w /usr/src/myapp php:8.2-cli php'      
