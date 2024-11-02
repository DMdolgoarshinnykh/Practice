package main

import (
        "testing"
        "net/http"
        "net/http/httptest"
        "fmt"
		"bytes"
		"encoding/json"
)

func TestIntegration(t *testing.T) {
        srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
                if r.URL.Path == "/time" {
                        w.Write([]byte(`{"time": "2023-10-12 14:30:00"}`))
                } else if r.URL.Path == "/message" {
                        w.Write([]byte(`{"message": "Сообщение отправлено успешно"}`))
                } else {
                        w.WriteHeader(http.StatusNotFound)
                }
        }))
        defer srv.Close()

        client := &http.Client{}

        resp, err := client.Get(srv.URL + "/time")
        if err != nil {
                t.Errorf("Ошибка при отправке запроса: %v", err)
        }
        defer resp.Body.Close()

        if resp.StatusCode != http.StatusOK {
                t.Errorf("Неправильный статус ответа: %d", resp.StatusCode)
        }

        var data struct {
                Time string `json:"time"`
        }
        err = json.NewDecoder(resp.Body).Decode(&data)
        if err != nil {
                t.Errorf("Ошибка при парсинге ответа: %v", err)
        }

        if data.Time != "2023-10-12 14:30:00" {
                t.Errorf("Неправильное время: %s", data.Time)
        }

        msg := "Hello, world!"
        resp, err = client.Post(srv.URL+"/message", "application/json", bytes.NewBuffer([]byte(fmt.Sprintf(`{"message": "%s"}`, msg))))
        if err != nil {
                t.Errorf("Ошибка при отправке запроса: %v", err)
        }
        defer resp.Body.Close()

        if resp.StatusCode != http.StatusOK {
                t.Errorf("Неправильный статус ответа: %d", resp.StatusCode)
        }

        var message struct {
                Message string `json:"message"`
        }
        err = json.NewDecoder(resp.Body).Decode(&message)
        if err != nil {
                t.Errorf("Ошибка при парсинге ответа: %v", err)
        }

        if message.Message != "Сообщение отправлено успешно" {
                t.Errorf("Неправильный ответ: %s", message.Message)
        }
}
