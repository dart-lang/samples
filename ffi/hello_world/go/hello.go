package main
import(
	"C"
	"fmt"
)
func main(){
}
//export HelloWorld
func HelloWorld() {
	fmt.Println("Hello Gophers")
}