Get a list of pods to json file 

kubectl get pods -o=jsonpath="{.items[*]['metadata.name', 'status.capacity']}" > /opt/outputs/nodes-z3444kd9.json
kubectl get pods -o json
kubectl get pods -o=jsonpath='{@}'
kubectl get pods -o=jsonpath='{.items[0]}'
kubectl get pods -o=jsonpath='{.items[0].metadata.name}'
kubectl get pods -o=jsonpath="{.items[*]['metadata.name', 'status.capacity']}"
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.startTime}{"\n"}{end}'


Create a namespace named apx-x9984574
kubectl create namespace apx-x9984574



Deploy a Pod named nginx-pod using nginx alpine image :

kubectl run --generator=run-pod/v1 nginx-pod --image=nginx:alpine


kubectl run --generator=run-pod/v1 messaging-pod --image=redis:alpine -l tier=msg #--namespace=finance 


expose the hr-web-app as hr-web-app-service application on port 30082 on the node on the cluster 
kubectl expose deployment hr-web-app --type=NodePort --port=8080 --name=hr-we-app-service --dry-run -o yaml > hr-web-app-service.yml 
and then edit file



retrieve all osImages Of all nodes and store them in a file 
kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.osImage}' > test.txt













