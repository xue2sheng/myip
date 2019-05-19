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
