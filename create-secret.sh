# Create encrypted password via kubeseal
# Be sure sealed-secrets is enabled on your cluster (i.e. install operator)

# Usage:
#  1. argument == namespace
#  2. argument == token to ACS ... must have read permissions at least


NS=$1
TOKEN=$2

kubectl create --dry-run=client -oyaml -n $1 \
    secret generic acs-auth-sealedsecret \
        --from-literal stackrox_url=`oc get route central -n stackrox -o json | jq -r '.spec.host'` \
        --from-literal stackrox_token=$2 \
            | kubeseal --controller-name=sealed-secrets-controller --controller-namespace=sealed-secrets --format yaml \
                > ./templates/acs-auth-secret.yaml
