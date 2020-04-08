# CustomRootCA
A simple script that generates a custom root CA and certificates signed by it.

Follow the steps below to use it:

1. Edit the files `ca.cnf` and `crt.cn` with information about your company.

2. Run the script `generate.sh` and it will create the root CA and a certificate signed by it. 

3. Once the files are created, you can use the certificate (certname.crt) and private key (certname.key) in your HTTP server. For example, the nginx config would look like:

```
server {
    listen 443 ssl default_server http2;

    # enables SSLv3/TLSv1, but not SSLv2 which is weak and should no longer be used.
    ssl_protocols SSLv3 TLSv1;

    server_name mycompany.ca;

    ## Keep alive timeout set to a greater value for SSL/TLS.
    keepalive_timeout 75 75;

    ssl on;
    ssl_certificate /path/to/certname.crt;
    ssl_certificate_key /path/to/certname.key;

    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    ssl_prefer_server_ciphers on;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256';


    root /var/www/;
    index index.html;
}

```

4. Finally, you need to distributed your CA (root.crt) to clients (browsers, systems, etc).

