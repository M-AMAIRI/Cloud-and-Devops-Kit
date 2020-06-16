#### Get a list of pods to json file 

```sh
kubectl get pods -o=jsonpath="{.items[*]['metadata.name', 'status.capacity']}" > /opt/outputs/nodes-z3444kd9.json
kubectl get pods -o json
kubectl get pods -o=jsonpath='{@}'
kubectl get pods -o=jsonpath='{.items[0]}'
kubectl get pods -o=jsonpath='{.items[0].metadata.name}'
kubectl get pods -o=jsonpath="{.items[*]['metadata.name', 'status.capacity']}"
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.startTime}{"\n"}{end}'
```



#### Create a namespace named apx-x9984574
```sh
kubectl create namespace apx-x9984574
```


#### Deploy a Pod named nginx-pod using nginx alpine image :

```sh
kubectl run --generator=run-pod/v1 nginx-pod --image=nginx:alpine

kubectl run --generator=run-pod/v1 messaging-pod --image=redis:alpine -l tier=msg #--namespace=finance 
```

#### expose the hr-web-app as hr-web-app-service application on port 30082 on the node on the cluster 

```sh
kubectl expose deployment hr-web-app --type=NodePort --port=8080 --name=hr-we-app-service --dry-run -o yaml > hr-web-app-service.yml
``` 


#### retrieve all osImages Of all nodes and store them in a file 

```sh
kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.osImage}' > test.txt
```




ref : 

https://github.com/mmumshad/kubernetes-the-hard-way/blob/master/practice-questions-answers/cluster-maintenance/backup-etcd/etcd-backup-and-restore.md

#### back-up ETCD 

```sh
ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
     snapshot save /tmp/etcd-backup.db
```

#### Restore ETCD 

```
ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --name=master \
     --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
     --data-dir /var/lib/etcd-from-backup \
     --initial-cluster=master=https://127.0.0.1:2380 \
     --initial-cluster-token=etcd-cluster-1 \
     --initial-advertise-peer-urls=https://127.0.0.1:2380 \
     snapshot restore /tmp/snapshot-pre-boot.db
```



Troolble shooting errors in kubernetes : https://learnk8s.io/a/troubleshooting-kubernetes.pdf



CKA practice Link : https://marsforever.com/2020/01/22/CKA-with-Practice-Tests/
 

