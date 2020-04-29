#!/bin/bash
# For MacOS, replace sensible-browser with open

prometheus(){
    
    kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') 9090:9090 &
    PROMETHEUS_PID=$!
    sensible-browser http://localhost:9090 &

}

grafana(){
    
    kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
    GRAFANA_PID=$!
    sensible-browser http://localhost:3000 &

}

kiali(){
    
    kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=kiali -o jsonpath='{.items[0].metadata.name}') 20001:20001 &
    KIALI_PID=$!
    sensible-browser http://localhost:20001 &

}

jaeger(){
    
    kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 &
    JAEGER_PID=$!
    echo "Jaeger started on 16686"
    sensible-browser http://localhost:16686 &

}

get-pids(){

    echo "Prometheus PID: $PROMETHEUS_PID"
    echo "Grafana PID: $GRAFANA_PID"
    echo "Kiali PID: $KIALI_PID"
    echo "Jaeger PID: $JAEGER_PID"

}

run-istio(){

    prometheus
    grafana
    kiali
    jaeger
    get-pids

}

kill-istio(){

    kill $PROMETHEUS_PID
    kill $GRAFANA_PID
    kill $KIALI_PID
    kill $JAEGER_PID
    get-pids
    ps aux | grep kub

}