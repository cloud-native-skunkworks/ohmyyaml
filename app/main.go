package main

import (
	"io"
	"net/http"
	"os"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	log "github.com/sirupsen/logrus"
)

var (
	countHits = promauto.NewCounter(
		prometheus.CounterOpts{Name: "hits_total",
			Help: "The total number of hits",
		},
	)
)

func serveImage(w http.ResponseWriter, r *http.Request) {
	log.Debugf("Incoming IP address %s", r.RemoteAddr)
	img, err := os.Open("./images/image.png")
	if err != nil {
		log.Errorf("Error opening image file: %s", err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	defer img.Close()
	w.Header().Set("Content-Type", "image/png")
	io.Copy(w, img)
	countHits.Inc()
}
func main() {
	log.SetLevel(log.DebugLevel)
	log.Debug("Starting http server")
	http.HandleFunc("/", serveImage)
	http.Handle("/metrics", promhttp.Handler())
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic(err)
	}
}
