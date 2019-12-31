## Usage
        
    mkdir certs
    docker run --rm --name cagen -d -v `pwd`/certs:/app/certs:z yutv/cagen
    docker exec -it cagen /app/cagen dev.local
    docker exec -it cagen /app/cagen my.website.local
    docker stop cagen
    ll certs/
    openssl x509 -text -noout -in certs/dev.local.crt
    openssl x509 -text -noout -in certs/dev.local-ca.crt

## Develop

    # Build Docker Image
    git clone https://github.com/yutv/cagen
    cd cagen
    docker build . -t "cagen"
    
    # Develop
    docker run --rm --name cagen -d --mount type=bind,source="$(pwd)/app",target=/app cagen
    docker exec -it cagen /bin/bash
    cd /app
    ./cagen -f dev.local
    
    # Rebuild & Publish Image
    docker stop cagen
    docker image rm cagen
    docker build . -t "cagen"
    docker login
    docker tag cagen yutv/cagen:1.0.0
    docker tag cagen yutv/cagen:latest
    docker push yutv/cagen
