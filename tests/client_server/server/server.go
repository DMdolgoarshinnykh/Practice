package server

import (
        "encoding/json"
        "fmt"
        "log"
        "net/http"
        "time"
)

type Data struct {
        Time string `json:"time"`
}

func main() {
        http.HandleFunc("/get", func(w http.ResponseWriter, r *http.Request) {
                if r.Method != http.MethodGet {
                        http.Error(w, "Invalid request method", http.StatusBadRequest)
                        return
                }

                currentTime := time.Now().Format("2006-01-02 15:04:05")
                data := Data{
                        Time: currentTime,
                }

                jsonData, err := json.Marshal(data)
                if err != nil {
                        http.Error(w, err.Error(), http.StatusInternalServerError)
                        return
                }

                w.Header().Set("Content-Type", "application/json")
                w.Write(jsonData)
        })

        fmt.Println("Сервер запущен на порту 8080")
        log.Fatal(http.ListenAndServe(":8080", nil))
}
