# Collection of scripts and configurations 
Let's save your local desktop public ipv6 address on your remote webserver, where your personal webpage usually lingers.

## Public IP 

Following every boot up, your desktop will try to [copy its current public ip](myip.sh), typically ipv6 on current ISP, onto your remote server. There you can define some alias to talk back to your desktop. Take into account that both local desktop and remote server got its ssh keys properly configured.

```
if [ -f /home/user/archlinux.txt]; then
	alias archlinux="ssh user@`cat /home/user/archlinux.txt` "
fi
``` 

## Hidden link to public IP

Once you got that desktop address information on your server, you can make it **semi-public** by means of a hidden link on your personal webpage:

1) nginx (commented out protection by password): 

```
    location /desktop/ {
        alias /var/www/desktop/;
#	autoindex on;
#	auth_basic "Restricted Content";
#       auth_basic_user_file /etc/nginx/.htpasswd;
    }
```

2) HTML code:

```
<a title="Desktop" href="/desktop/index.html" target="_blank">&nbsp;&nbsp;&nbsp;</a>
```

## Simple HTTPS server

Following [Denis Denisov's instructions](https://github.com/denji/golang-tls), a simple HTTPS server will be running on the desktop box, waiting for http/https request:

```
# Key considerations for algorithm "ECDSA" (X25519 || ≥ secp384r1)
# https://safecurves.cr.yp.to/
# List ECDSA the supported curves (openssl ecparam -list_curves)
openssl ecparam -genkey -name secp384r1 -out server.key

# Generation of self-signed(x509) public key (PEM-encodings .pem|.crt) based on the private (.key)
openssl req -new -x509 -sha256 -key server.key -out server.crt -days 3650
```

```
package main

import (
    "net/http"
    "log"
    "net/url"
)

func HelloServer(w http.ResponseWriter, req *http.Request) {
    w.Header().Set("Content-Type", "text/html")
    w.Write([]byte("<!DOCTYPE html><html><head><title>Archlinux</title></head><body><h1>Archlinux</h1></body></html>"))
}

func redirectToHttps(w http.ResponseWriter, r *http.Request) {
	targetUrl := url.URL{ Scheme: "https", Host: r.Host, Path: r.URL.Path, RawQuery: r.URL.RawQuery, }
	http.Redirect(w, r, targetUrl.String(), http.StatusMovedPermanently)
}

func main() {
    http.HandleFunc("/", HelloServer)
    go http.ListenAndServeTLS(":443", "/home/user/Code/simpleHTTPS/server.crt", "/home/user/Code/simpleHTTPS/server.key", nil)
    err := http.ListenAndServe(":80", http.HandlerFunc(redirectToHttps))
    if err != nil {
        log.Printf("ListenAndServe: ", err)
    }
    log.Println("Listening to http and https")
}
```


