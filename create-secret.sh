# Create encrypted password via kubeseal
# Be sure sealed-secrets is enabled on your cluster (i.e. install operator)

# Usage:
#  1. argument == namespace
#  2. argument == password to ACS ... should be changed to token later


NS=$1
PASS=$2

kubectl create --dry-run=client -oyaml -n $1 \
    secret generic acs-auth-sealedsecret \
        --from-literal stackrox_url=`oc get route central -n stackrox -o json | jq -r '.spec.host'` \
        --from-literal stackrox_pass=$2 \
            | kubeseal --controller-name=sealed-secret-controller-sealed-secrets --controller-namespace=sealed-secrets --format yaml \
                > ./templates/acs-auth-secret.yaml
