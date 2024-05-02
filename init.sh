# Install kubectl
# curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
# chmod +x ./kubectl
# mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

# Install minikube
# curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

docker run -d -p 5000:5000 --restart=always --name local-registry registry:2

eval $(minikube docker-env)

sudo docker build -t my-flask-app:0.0.2 .
docker run -d -p 5000:5000 --restart=always --name local-registry registry:2
docker tag my-flask-app localhost:5000/my-flask-app
docker push localhost:5000/my-flask-app

minikube start --disk-size=2g
kubectl apply -f app-deployment.yaml
kubectl apply -f app-service.yaml
minikube service my-flask-app-service

kubectl get pods

read -p "Press enter to end"
kubectl delete deployment my-flask-app-deployment
minikube delete
echo "bye bye"