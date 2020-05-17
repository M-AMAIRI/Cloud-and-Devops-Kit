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
```yaml
apiVersion: app/v1
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



#### deployment in Kubernetes :

##### Creating a Deployment
creates a ReplicaSet to bring up three nginx Pods:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment #A Deployment named nginx-deployment is created
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx #field defines how the Deployment finds which Pods to manage
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```
1. Create the Deployment by running the following command: ``` kubectl apply -f controllers/nginx-deployment.yaml  ``` 

2. check if the Deployment ``` kubectl get deployments  ```

3. To see the ReplicaSet (rs) created by the Deployment, run ```kubectl get rs```

##### Updating a Deployment :

1. update the nginx Pods to use the nginx:1.16.1 image instead of the nginx:1.14.2 image : ``` kubectl --record deployment.apps/nginx-deployment set image deployment.v1.apps/nginx-deployment nginx=nginx:1.16.1 ```
or ``` kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1 --record ```



2. run ``` kubectl get deployments ``` to check pods deployement 

3. at edit a deployement a new replicat set will be created run this command to check the new one : ``` kubectl get rs ```

4. ```kubectl get pods ``` 


##### Rolling Back a Deployment :

when the Deployment is not stable, such as crash looping. By default, all of the Deployment’s rollout history is kept in the system so that you can rollback anytime you want

scenario :

1. update image : ```kubectl set image deployment.v1.apps/nginx-deployment nginx=nginx:1.161 --record=true```

2. check the revisions of this Deployment: ```kubectl rollout history deployment.v1.apps/nginx-deployment```

3. To see the details of each revision : ```kubectl rollout history deployment.v1.apps/nginx-deployment --revision=2```

4. Rolling Back to a Previous Revision : ``` kubectl rollout undo deployment.v1.apps/nginx-deployment --to-revision=2```

5. to check if roll back is sucessfully done :

```bash
$ kubectl get deployment nginx-deployment
$ kubectl describe deployment nginx-deployment
```

