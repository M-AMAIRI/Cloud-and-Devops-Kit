
### BusyBox with sleep

```yaml

apiVersion: v1
kind: Pod
metadata:
  name: busybox1
  labels:
    app: busybox1
spec:
  containers:
  - image: busybox
    command:
      - sleep
      - "3600"
    imagePullPolicy: IfNotPresent
    name: busybox
  restartPolicy: Always

```

### redis avec volumeMounts

```yml
apiVersion: v1
kind: Pod
metadata:
  name: redis-storage
spec:
  containers:
  - name: redis-storage
    image: redis:alpine
    volumeMounts:
    - name: redis-storage
      mountPath: /data/redis
  volumes:
  - name: redis-storage
    emptyDir: {}
``` 
    

### Deployment pods with replicas 
```yml
apiVersion: apps/v1 
kind: Deployment
metadata:
  name: hr-web-app
  labels:
    app: hr-web-app
spec:
  selector:
    matchLabels:
      app: hr-web-app
      tier: frontend
  replicas: 2
  template:
    metadata:
      labels:
        app: hr-web-app
        tier: frontend
    spec:
      containers:
      - name: hr-web-app
        image: kodekloud/webapp-color
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
```  

            
            
            
### Example :
            
Create a service messaging-service to expose the messaging application within the cluster on port 6379.

```yml
apiVersion: v1
kind: Service
metadata:
  name: messaging-service
  labels:
      app: messaging
      role: master
      tier: msg
spec:
  ports:
  - port: 6379
    targetPort: 6379
  selector:
      app: messaging
      role: master
      tier: msg
```



### for example 

Create a new pod called super-user-pod with image busybox:1.28. Allow the pod to be able to set system_time
The container should sleep for 4800 seconds

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: super-user-pod
spec:
  containers:
  - image: busybox:1.28
​    name: super-user-pod
​    command: ["sleep","4800"]
​    securityContext:
​      capabilities:
​        add: ["SYS_TIME"]
```



### static pods :

```
ssh my-node1

#Get the static pod's path
cat config.yaml | grep static

#Get the path is /etc/kubernetes/manifests
cd /etc/kubernetes/

#Create directory manifests
mkdir manifests


#create your yml file of pods on master :
kubectl run --generator=run-pod/v1 nginx-critical --image=nginx --dry-run -o yaml > nginx-critical.yaml
# or :

# Run this command on the node where kubelet is running
mkdir /etc/kubelet.d/
cat <<EOF >/etc/kubelet.d/static-web.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-web
  labels:
    role: myrole
spec:
  containers:
    - name: web
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
EOF

https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/#configuration-files

systemctl restart kubelet





```




