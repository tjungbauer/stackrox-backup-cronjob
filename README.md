# Helm Chart for simply Stackrox/Advanced Cluster Security Backup Cronjob

This chart will create a very simple Cronjob which perform a "roxctl cluster backup" and stores it on a PV.
It is meant as a starting point ... any feedback is welcomed.

## Setup

Before you start you need to pass some information into a secret.

The provided `create-secret.sh` creates such secret for you, leveraging Sealed Secrets.

For example execute:
`create-secret.sh <namespace-name> <ACS-password>`

--> TODO: Using Token would be better.

Alternatively, you can manually create the following secret, i.e. if Sealed Secret is not available:

```yml
kind: Secret
apiVersion: v1
metadata:
  name: acs-auth-sealedsecret
  namespace: cluster-ops
data:
  stackrox_pass: <ACS PASSWORD>
  stackrox_url: <ACS CENTRAL URL>
type: Opaque
```

## Install Helm

`helm install . --generate-name`

This will create the Cronjob, the PVC and so on

## Fetch Backup Files

`oc apply -f POD-extract-backup.yml` will create a pod with the mounted PV. You can download the GZ files from there.