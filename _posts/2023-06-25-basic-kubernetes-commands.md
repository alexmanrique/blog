---

layout: single
title: "Essential kubectl commands for managing Kubernetes deployments"
date: 2023-06-25 09:08:53 +0200
categories: development
comments: true
lang: en
tags: cloud
image: images/cloud.jpg

---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/cloud.jpg)
{: refdef}
{:refdef: style="text-align: center;font-size:9px"}
Foto de <a href="https://unsplash.com/@billy_huy?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Billy Huynh</a> en <a href="https://unsplash.com/es/fotos/v9bnfMCyKbg?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef}

Managing deployments in <a href="https://kubernetes.io/">Kubernetes</a> requires effective command-line tools. <a href="https://kubernetes.io/docs/tasks/tools/">Kubectl</a> is a powerful utility that enables users to interact with Kubernetes clusters. In this blog post, we will explore some essential kubectl commands that can help you monitor, troubleshoot, and gain insights into your deployments.


1 - Confirm kubectl functionality
----------------------------------
To ensure that kubectl is functioning correctly, you can use the following command:
```bash
kubectl get pods -n dummy-cloud
```
Executing this command will display the list of pods in the "dummy-cloud" namespace, confirming the functionality of kubectl.

2 - Obtaining detailed Pod Information
----------------------------------
Appending the `-o wide` suffix to the previous command provides more details about the pods, including the IP address of the pod and the node where it is running:
```bash
kubectl get pods -n dummy-cloud -o wide
```
This command offers a broader perspective of your deployment environment.

3 - Querying Pods by IP Address
--------------------------------
If you know the IP address of a client app and wish to determine the associated pod, you can use the following command:
```bash
kubectl get pods --all-namespaces -o wide | grep 10.64.148.101
```
By listing all pods and filtering them based on the desired IP address, you can identify the specific pod.

4 - Exploring ReplicaSets
---------------------------
Each version of a deployment generates a different ReplicaSet. To view existing ReplicaSets for an application, execute:
```bash
kubectl get rs -n <APP_NAME>
```
Replace `<APP_NAME>` with the name of your application's namespace. This command provides an overview of the available ReplicaSets.

5 - Obtaining Deployment Details
--------------------------------
To retrieve comprehensive information about a specific deployment, such as its YAML configuration, including the image version, use the following command:
```bash
kubectl get deployment <deployment_name> -n <APP_NAME> -o yaml
```
Substitute `<deployment_name>` with the name of your deployment and `<APP_NAME>` with the application's namespace. You can then filter the YAML output to find the desired image version.

6 - Checking Horizontal Pod Autoscaler (HPA) Status
-----------------------------------
To verify the status of Horizontal Pod Autoscalers for your application, execute:
```bash
kubectl get hpa -n <APP_NAME>
```
Replace `<APP_NAME>` with the namespace of your application. This command provides insights into the scaling behavior of your deployment.

7 - Retrieving Real-time Logs from a Pod
-------------------------------------
To access logs from an existing pod in real-time, use the following command:
```bash
kubectl logs -f <POD_NAME> -n <APP_NAME>
```
Replace `<POD_NAME>` with the name of the pod and `<APP_NAME>` with the namespace of your application. This command allows you to monitor live logs.

8 - Viewing Previous Pod Logs
-----------------------------
If you need to access logs from a pod before it restarted, use the `-p` flag with the `kubectl logs` command:
```bash
kubectl logs <POD_NAME> -n <APP_NAME> -p
```
Replace `<POD_NAME>` with the pod's name and `<APP_NAME>` with the application's namespace. This command is useful for debugging and troubleshooting purposes.

9 - Monitoring Pod Status
---------------------------
To continuously monitor the status of pods in an application, use the `watch` command along with the `kubectl get pods` command:
```bash
watch kubectl get pods -n <APP_NAME>
```
Replace `<APP_NAME>` with the namespace of your application. This command allows you to observe any changes in pod status at regular intervals.


10 - Accessing AKHQ (Kafka UI) Using Port Forwarding
-------------------------------------
To conveniently access AKHQ, the Kafka UI, you can leverage port forwarding by executing the following command:
```bash
kubectl port-forward --address 0.0.0.0 service/akhq -n kafka 8080:8080
```
By running this command, you enable port forwarding from your local machine to the AKHQ service in the "kafka" namespace. AKHQ will be accessible at `http://localhost:8080`, allowing you to conveniently interact with and manage your Kafka clusters through a user-friendly web interface.

Conclusion
------------------
Effective management of Kubernetes deployments requires familiarity with essential kubectl commands. In this blog post, we covered various commands that enable you to confirm kubectl functionality, retrieve detailed pod information, query pods by IP address, explore ReplicaSets, obtain deployment details, check Horizontal Pod Autoscaler status, retrieve real-time and previous pod logs, monitor pod status, and conveniently access AKHQ using port forwarding. By leveraging these commands, you can enhance your deployment management capabilities and streamline your Kubernetes operations.