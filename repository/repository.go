package main

import "net/http"

func main() {
	panic(http.ListenAndServe(":6840", http.FileServer(http.Dir("/Users/crdant/.m2/repository"))))
}
