# Demo AWS IAM Role Assumption, with restrictions
Deploys a demo environment for testing role assumption, with some restrictions in place.

*WARNING* - Base users access keys are created and stored in terraform outputs - Do _NOT_ use in production workloads

## Base User
User is created with limited permissions, other than the ability assume other (allowed) Roles for performing other duties. [base_user](base_user.tf)

## Assumed Role
Role is created to all the base_user (and only the base_user) to assume it's permissions (IAM:ListRoles, for the purposes of testing)