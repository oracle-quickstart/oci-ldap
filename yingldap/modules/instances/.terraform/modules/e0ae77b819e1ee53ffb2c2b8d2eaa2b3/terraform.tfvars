### Authentication details
tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaawgbzspd6cjovpmic7dahwbalg4opcbixgguo6z2s7t335m6lalbq"
user_ocid="ocid1.user.oc1..aaaaaaaa6xzspqtw326g2ulmiqk7spizbbxb5sidjbw44h4wi5zpllmrvidq"
fingerprint=$(cat ~/.oci/oci_api_key_fingerprint)
private_key_path=~/.oci/oci_api_key.pem
region="us-ashburn-1"
compartment_ocid="ocid1.compartment.oc1..aaaaaaaawzlfllc7kkf62dzkes75urrxfxppz5fjphx27a7k5fk5jnzvyhiq"
ssh_public_key=$(cat ~/.ssh/id_rsa.pub)
ssh_private_key=$(cat ~/.ssh/id_rsa)


client_count = 2

bastion_ssh_public_key=$(cat ~/.ssh/id_rsa.pub)
bastion_ssh_private_key=$(cat ~/.ssh/id_rsa)
