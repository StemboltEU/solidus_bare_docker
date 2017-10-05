# Solidus with docker, circleCI 2.0 and kubernetes

This is a sample setup for running Solidus on Kubernetes and using CircleCI 2.0 to deploy.

Uses:
- Google container engine to run kubernetes (https://cloud.google.com/container-engine/)
- Google container registry to store images (https://cloud.google.com/container-registry/)
- Google persistent disk for storage (https://cloud.google.com/persistent-disk/)

# Google cloud setup

Setup the following either using the gcloud sdk cli or on cloud.google.com in your console:

- Google container registry (https://cloud.google.com/container-registry/docs/quickstart)
- Google container engine (https://cloud.google.com/container-engine/docs/tutorials/hello-app)
- Google persistent disk (https://cloud.google.com/compute/docs/disks/add-persistent-disk)

### Install Kubernetes CLI

Install the kubectl command, which you will use to see your Kubernetes Dashboard:
https://kubernetes.io/docs/tasks/tools/install-kubectl/

```
kubectl proxy
```

As it says, visit http://localhost:8001/ui to view the Kubernetes Dashboard.

### Create secrets

Google Container Engine has its own secrets management (https://kubernetes.io/docs/concepts/configuration/secret/). We'll use the 'kubectl' to create the secrets manually from the command line. These commands then store them in the Google Container Engine.

We need:
- Secret Key Base to run Rails in production
- Postgres database password

Create a secret key base secret (for SECRET_KEY_BASE):
```
kubectl create secret generic production --from-literal=secretkeybase=<secret_key>
```

Postgres password secret (for POSTGRES_ROOT_PASSWORD and DB_PASSWORD):
```
kubectl create secret generic postgres --from-literal=password=<root-user-password>
```

The values are then specified in the kubernetes_config files using the 'valueFrom' key.

# Configure CircleCI

### Setup Service accounts

In order to give CircleCI proper permissions to do stuff to our google cloud services, we need the following Google Cloud Service accounts:
1. Allow CircleCI to pull/push from the Google Container Registry (e.g., "circleci-container-upload")
2. Allow CircleCI to apply a deployment to the Google Container Engine (e.g., "circleci-kubernetes-deploy")

Create the accounts:
https://developers.google.com/identity/protocols/OAuth2ServiceAccount#creatinganaccount

Grant correct permissions:
- For the Google Container Registry service account, grant 'Storage Admin' permissions
- For the Google Container Engine service account, grant 'Container Engine Developer' permissions

For each service account, we will use a JSON key file for authentification (https://cloud.google.com/container-registry/docs/advanced-authentication).

Create the JSON key: https://support.google.com/cloud/answer/6158849#serviceaccounts.


In your CircleCI Project Settings, add the following variables to 'Environment Variables':
- GOOGLE_CONTAINER_ENGINE_AUTH - encoded JSON key from above (use base64 to encode: https://circleci.com/docs/2.0/google-container-engine/)
- GOOGLE_CONTAINER_REGISTRY_AUTH - json (DO NOT ENCODE: we need the full json for auth/username&password: https://cloud.google.com/container-registry/docs/advanced-authentication and https://circleci.com/docs/2.0/private-images/)
- HOSTNAME - Google container regsitry (gcr.io) hostname. See available hostnames here: https://cloud.google.com/container-registry/docs/pushing-and-pulling)
- ZONE - zone chosen for compute engine (https://cloud.google.com/compute/docs/regions-zones/regions-zones). can see from this list: https://console.cloud.google.com/kubernetes/list
- CLUSTER_NAME - the name of your gke cluster, can be found here: https://console.cloud.google.com/kubernetes/list
- GOOGLE_PROJECT_ID - is your Google Cloud Platform Console [project ID](https://support.google.com/cloud/answer/6158840)
