## Installation
    git clone https://github.com/yutv/cagen
    cd cagen
    docker build . -t "cagen"
    docker create --name cagen --mount type=bind,source="$(pwd)/certs",target=/app/certs cagen
    docker start cagen

## Usage
        
    docker exec -it cagen /app/cagen dev.local
    ll certs/
    openssl x509 -text -noout -in certs/dev.local.crt
    openssl x509 -text -noout -in certs/dev.local-ca.pem
