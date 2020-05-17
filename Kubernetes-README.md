# Kubernetes Administration

#### Cluster Architecture :

A Kubernetes cluster is a set of node machines for running containerized 
applications. If you’re running Kubernetes, you’re running a cluster.

#### Pod :
A Kubernetes pod is a group of containers that are deployed together on 
the same host. 

Yaml Pod definition file :
has a 4 propriete level apiVersion,kind,metadata and spec .
```yaml
apiVersion: v1
kind: Pod
metadata:
 name : myapp-pod
 labesl:
   app: myapp
   # we can have many labels as we want like
   #costcenter: value
   #locatopn: name
   #type: frontend
spec:
  # is unique to eatch object created is have containers 
  containers: # containers is a list of different containers  
    - name: nginx-container # name of my container
      image: nginx # the name of the image itself
    # we can add another container to my pod
    #- name: backend-container
    #  image: redis
```
to create pod via terminal on kubernetes : 
```kubectl create -f pod-definition.yml --validate=false ```
to see pods states :``` kubectl get pods```
to delete deploiement : ```kubectl delete deployement nginx # if a 
previos deployement exist ```

#### replicaSets :

Replication controller : if for some resson an aplication crashes the 
pod feels and users have no long acceess to the application so we need a 
new pods and user still access to the app , with another created pod 
thats named hight availabilite , so the replication controller specifie 
the number of running pod to avoid those kind of problem

Load Balancing & Scaling : another reason for exemple if a single pod 
serve a specific number of users and in the cas of out of ressources on 
the first pod an additional pod created in another node on the cluster
Replica set and Replication controller : Replication controller is a 
older tecnologie replaced by Replica set

replication controller by yaml file named rc-definition.yml :
```apiVersion: v1
Kind: ReplicationController
metadata:
 name : myapp-rc
 labesl:
   app: myapp
   type: front-end
spec:
  template: # pod template we can re use the previos definition of nginx 
pod  
      metadata:
       name : myapp-pod
       labesl:
         app: myapp
      spec:
        containers: 
          - name: nginx-container 
            image: nginx
  replicas: 3 # to create a 3 instance of pod 
```

to cerate this replicat : ``` kubectl create -f rc-definition.yml ```
to see an existed replicat : ``` kubectl get replicationcontroller ```
to see running pods : ``` kubectl get pods ```

or can be defined by replicat set : replicatset-definition.yml
``` apiVersion: app/v1
kind: ReplicaSet
metadata:
 name : myapp-replicatset
 labesl:
   app: myapp
   type: front-end
spec:
  template: 
      metadata:
       name : myapp-pod
       labesl:
         app: myapp
      spec:
        containers: 
          - name: nginx-container 
            image: nginx 
  replicas: 3 
  selector:
    matchLabels:
      type: front-end # to apply the replication for a specific type of 
pods and not all like replicas controller
```
and then :
to cerate this replicat : ```kubectl create -f 
replicatset-definition.yml ```
to see an existed replicat : ```kubectl get replicaset ```
to see a description of a specific replicatset : ```kubectl describe 
replicaset```
to see running pods : ```kubectl get pods```

to update the scale from 3 to 6 instances, just by scale replace command 
:
  ```kubectl scale --replace=6 -f replicatset-definition.yml```



#### deployment and service in Kubernetes :

What's the difference between a Service and a Deployment in Kubernetes? 
A deployment is responsible for keeping a set of pods running. A service 
is responsible for enabling network access to a set of pods. We could 
use a deployment without a service to keep a set of identical pods 
running in the Kubernetes cluster.


