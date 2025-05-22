# Terraform Root Module

This directory contains the root Terraform configuration for deploying Azure resources.

- `terragrunt.hcl`: contains the main terraform config inherited by each module inside of `environments`.
- `environments`: contains each of the environments to deploy.
  - `test` / `prod`: every individual environment.
    - An `env.hcl` file contains the shared variables for all stacks in the environment.
    - `network` / `compute`: each stack containing groups of resources.
        - `terragrunt.hcl`: stack configuration, goes all the way up to the root `terragrunt.hcl` to get the stack's config.
- `modules`: contains shared modules across the stacks.
