# GitCall Helm Chart

DBCall k8s standalone chart

# Install DBCall
`kubectl create namespace gitcall`

`helm upgrade --install gitcall -n gitcall .`


#### Dependencies:
#####Testing on Kubernetes version 1.26 and helm v3
#####Supported stateful versions:
- Postgresql 13.3
- RabbitMQ 3.8/3.9

### SYSTEM REQUIREMENTS:

#### Recommended minimum system requirements for a cluster:
- 2 instances with 2 CPUs and 4GB RAM

#### Recommended system requirements for a PROD cluster:
- 3 instances with 2 CPUs and 4GB RAM

---

#### Brief description `values.yam`:

`Values.global.domain` - for example dev-devops.corezoid.com  
`Values.global.ingress.className` - yor ingress className in cluster  
`Values.global.db.secret.dbsuperuser` - your superuser in the database, you can use internal_user  
`Values.global.db.secret.dbsuperuserpwd` - your superuser password in the database  
`Values.global.db.secret.data.host` - address of your database (dns name or ip). You can use the same base as Corezoid  
`Values.global.db.secret.data.dbuser` - your user in the database, you can use internal_user  
`Values.global.db.secret.data.dbpwd` - your user password in the database  
`Values.global.mq.secret.data.host` - address of your RabbitMQ (dns name or ip). You can use the same base as Corezoid  
`Values.global.mq.secret.data.username` - your user in the RabbitMQ, you can use app-user  
`Values.global.mq.secret.data.password` -your user password in the RabbitMQ  
`Values.global.mq.secret.data.vhost` - default conveyor  
`Values.global.gitcall.registry.host` - specify a real domain for the registry. He must come to the ingres of the kube  
`Values.global.gitcall.secret.username` - for your registry  
`Values.global.gitcall.secret.password` - for your registry (you can generate your unique password)  
`Values.global.gitcall.mq_vhost` - default conveyor  
`Values.global.gitcall.dunder_mq_vhost` - default conveyor
`Values.global.registry.storage.provider` - for aws please set s3 (need to uncomment block s3), for local install please set filesystem

---

### Policy for aws s3:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:ListBucketMultipartUploads"
            ],
            "Resource": "arn:aws:s3:::gitcall-registry"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload"
            ],
            "Resource": "arn:aws:s3:::gitcall-registry/*"
        }
    ]
}
```