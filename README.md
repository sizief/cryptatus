# What?
Bunch of microservice to answer the current price of BTC.
Two services are defined: `ticker` and `pricer`. Pricer with get the price and store it somewhere. Ticker would return the latest price which updated every seconds asynchronously.

# HOW
`docker-compose up --build`  
Navigate to `http://localhost:8080` to see the traefik panel.  
Scale it with `docker-compose scale ticker=10`  
Run load test with `ab -n 10000 -c 1000 http://localhost/tick`  
Add more rules to navigate to services, if needed, as a docker-compose labels. I am using `Traefik` see [this](https://docs.traefik.io/configuration/backends/docker/)  
