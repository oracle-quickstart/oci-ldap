# Oracle Cloud Infrastructure NIS Terraform Module
The Network Information Service, or NIS (originally called Yellow Pages or YP),
is a client–server directory service protocol for distributing system configuration data such as user and host names between computers on a computer network.
For the convenience of customers to install NIS quickly, the Oracle Cloud Infrastructure NIS Terraform Module provides a Terraform-based NIS installation solution on Oracle Cloud Infrastructure (OCI).  
By setting simplest parameters, customer can build their own NIS in a short time.



## Prerequisites

Download and install Terraform (v0.10.3 or later)
Download and install the OCI Terraform Provider (v2.0.0 or later)
Export OCI credentials. (this refer to the https://github.com/oracle/terraform-provider-oci )


## What's a Module?

A Module is a canonical, reusable, best-practices definition for how to run a single piece of infrastructure, such as a database or server cluster. Each Module is created using Terraform, and includes automated tests, examples, and documentation. It is maintained both by the open source community and companies that provide commercial support. Instead of figuring out the details of how to run a piece of infrastructure from scratch, you can reuse existing code that has been proven in production. And instead of maintaining all that infrastructure code yourself, you can leverage the work of the Module community to pick up infrastructure improvements through a version number bump.


## How to use this module
There are two examples shown in this module:
1. [quick_start](./examples/quick_start) folder contains an example of how to use this module.
2. [existing_infra](./examples/existing_infra) folder contains an example of how to use this module.


## Contributing

This project is open source. Oracle appreciates any contributions that are made by the open source community.

## License

Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

Licensed under the Universal Permissive License 1.0 or Apache License 2.0.

See [LICENSE](LICENSE.txt) for more details.
