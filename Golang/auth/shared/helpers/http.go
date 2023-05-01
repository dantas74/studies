package helpers

import (
	"bytes"
	"encoding/json"
	"github.com/gojek/heimdall/v7"
	"github.com/gojek/heimdall/v7/httpclient"
	"net/http"
	"time"
)

const (
	httpClientTimeout     = 5 * time.Second
	initialTimeout        = 2 * time.Millisecond
	maxTimeout            = 20 * time.Millisecond
	exponentFactor        = 2
	maximumJitterInterval = 2 * time.Millisecond
)

func GetHttpClient() *httpclient.Client {
	backoff := heimdall.NewExponentialBackoff(initialTimeout, maxTimeout, exponentFactor, maximumJitterInterval)

	retrier := heimdall.NewRetrier(backoff)

	return httpclient.NewClient(
		httpclient.WithHTTPTimeout(httpClientTimeout),
		httpclient.WithRetrier(retrier),
		httpclient.WithRetryCount(4),
	)
}

func MakeRequest(url string, method string, body any, headers ...http.Header) (*http.Response, error) {
	client := GetHttpClient()

	bytesBody, err := json.Marshal(body)
	if err != nil {
		return nil, err
	}

	request, err := http.NewRequest(method, url, bytes.NewBuffer(bytesBody))
	if err != nil {
		return nil, err
	}

	request.Header.Set("Content-Type", "application/json")

	if len(headers) > 0 {
		for key, value := range headers[0] {
			request.Header[key] = value
		}
	}

	response, err := client.Do(request)
	if err != nil {
		return nil, err
	}

	return response, nil
}
