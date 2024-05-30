package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	// 设置路由处理器
	http.HandleFunc("/", helloHandler) // 对于根路径"/"，使用helloHandler函数处理请求

	// 启动服务器监听指定端口
	port := ":8080" // 通常使用8080端口，以避免与HTTP默认端口80冲突
	fmt.Printf("Server is listening on port %s\n", port)
	log.Fatal(http.ListenAndServe(port, nil)) // 第二个参数是处理器链，这里我们传入nil表示使用默认的多路复用器DefaultServeMux
}

// helloHandler 是一个HTTP请求处理器函数
func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "K8S-CICD-DEMO") // 向客户端发送响应消息
}
