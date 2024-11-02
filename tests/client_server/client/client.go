package client

import (
        "encoding/json"
        "fmt"
        "io/ioutil"
        "log"
        "net/http"
        "time"
)

type Data struct {
        Time string `json:"time"`
}

func main() {
        ticker := time.NewTicker(5 * time.Second)
        defer ticker.Stop()

        for range ticker.C {
                resp, err := http.Get("http://localhost:8080/get")
                if err != nil {
                        log.Fatal(err)
                }
                defer resp.Body.Close()

                body, err := ioutil.ReadAll(resp.Body)
                if err != nil {
                        log.Fatal(err)
                }

                var data Data
                err = json.Unmarshal(body, &data)
                if err != nil {
                        log.Fatal(err)
                }

                fmt.Printf("Текущее время на сервере: %s\n", data.Time)
        }
}
