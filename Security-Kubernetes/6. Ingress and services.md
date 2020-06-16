### Deployements :


- Proxy to share your DNS to a 80 port number ( from node port to 80 ) 
- use a google load balacer to your application 


so How to manage all of that in a kubernetes cluster :

- ingress-controller as a layer load balancer just like an another object in kubernetes to configure ssl , load balancing ...
  1. Deploy Nginx ( ingress-controller )
  2. configure to specify a set of rools in ingress resources as a definition file 


```
    internet
        |
   [ Ingress ]
   --|-----|--
   [ Services ]

```


so we ca take this tutorial https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-ingress-guide-nginx-example.html

to create two backend with two services and we have a single domaine name : 

``` yaml
kind: Pod
apiVersion: v1
metadata:
  name: apple-app
  labels:
    app: apple
spec:
  containers:
    - name: apple-app
      image: hashicorp/http-echo
      args:
        - "-text=apple"

---

kind: Service
apiVersion: v1
metadata:
  name: apple-service
spec:
  selector:
    app: apple
  ports:
    - port: 5678 # Default port for image

```



``` yaml

kind: Pod
apiVersion: v1
metadata:
  name: banana-app
  labels:
    app: banana
spec:
  containers:
    - name: banana-app
      image: hashicorp/http-echo
      args:
        - "-text=banana"

---

kind: Service
apiVersion: v1
metadata:
  name: banana-service
spec:
  selector:
    app: banana
  ports:
    - port: 5678 # Default port for image
    
```




and then lets create a ingress layer :

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
        - path: /apple
          backend:
            serviceName: apple-service
            servicePort: 5678
        - path: /banana
          backend:
            serviceName: banana-service
            servicePort: 5678
```


and then lets test our application :

```sh

kubectl get ingress 

curl -kL http://localhost/apple
apple

curl -kL http://localhost/banana
banana

curl -kL http://localhost/notfound
default backend - 404

```

we can configure a default 404 page :
        - path: /Default
          backend:
            serviceName: banana-service
            servicePort: 5678


### different domaine name 

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: apple.my-online.com
    http:
        - path: 
          - backend:
            serviceName: apple-service
            servicePort: 5678
  - host: banana.my-online.com
    http:
        - path:
          - backend:
            serviceName: banana-service
            servicePort: 5678
```
