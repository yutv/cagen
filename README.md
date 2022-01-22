## Usage
```
    mkdir certs
    docker run --rm --name cagen -d -v `pwd`/certs:/app/certs:z yutv/cagen
    docker exec -it cagen /app/cagen dev.local
```
output
```
    Generated Files:
      certs/dev.local.key    - SSL Certificate Private Key (use on HTTPS server)
      certs/dev.local.crt    - SSL Certificate Public Key  (use on HTTPS server)
      certs/dev.local-ca.crt - Certificate Authority (import it in your browser as Authority Certificate)
    
    Apache Config Example:
        SSLEngine on
        SSLCertificateFile /etc/ssl/certs/dev.local.crt
        SSLCertificateKeyFile /etc/ssl/private/dev.local.key
    
    Nginx Config Example:
        server {
            server_name dev.local;
            listen 80;
            listen 443 ssl;
            ssl_certificate /etc/ssl/certs/dev.local.crt;
            ssl_certificate_key /etc/ssl/private/dev.local.key;
    
    Ubuntu (curl, etc.)
        sudo cp certs/dev.local-ca.crt /usr/local/share/ca-certificates/
        sudo update-ca-certificates
```
```
    # multiple domains example
    # docker exec -it cagen /app/cagen my.website.local my.website2.local my.website3.local
    docker stop cagen
    ll certs/
    openssl x509 -text -noout -in certs/dev.local.crt
    openssl x509 -text -noout -in certs/dev.local-ca.crt
```
## Develop

    # Build Docker Image
    git clone https://github.com/yutv/cagen
    cd cagen
    docker build . -t "cagen"
    
    # Develop
    docker run --rm --name cagen \
        -d --mount type=bind,source="$(pwd)/app",target=/app \
        -d -v `pwd`/app/certs:/app/certs:z \
        cagen
    docker exec -it cagen /bin/bash
    cd /app
    ./cagen -f dev.local
    
    # Rebuild & Publish Image
    docker stop cagen
    docker image rm cagen
    docker build . -t "cagen"
    docker login
    docker tag cagen yutv/cagen:1.1.0
    docker tag cagen yutv/cagen:latest
    docker push yutv/cagen
