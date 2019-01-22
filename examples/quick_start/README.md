### Quick Start Creating NIS Servers & Clients
After running quick start, one NIS Server and several clients will be setup on new creating vms.

### Using this example
Prepare one variable file named "terraform.tfvars" with the required information. The content of "terraform.tfvars" should look something like the following:
```
tenancy_ocid="ocid1.tenancy.oc1..XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
user_ocid="ocid1.user.oc1..XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
fingerprint="xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
private_key_path="～/.oci/oci_api_key.pem"
region="us-ashburn-1"
compartment_ocid="ocid1.tenancy.oc1..XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
ssh_public_key="～/.ssh/id_rsa.pub"
ssh_private_key="～/.ssh/id_rsa"
client_count = 2
bastion_ssh_public_key="～/.ssh/id_rsa.pub"
bastion_ssh_private_key="～/.ssh/id_rsa"

```

Then apply the example using the following commands:
```
$ terraform init
$ terraform plan
$ terraform apply
```