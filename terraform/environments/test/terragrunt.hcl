# Terragrunt configuration for test environment

terraform {
  source = "../../..//modules//${path_relative_to_include()}/.."
}

include {
  path = find_in_parent_folders()
}

inputs = {
  # Add environment-specific variables here, or override in child terragrunt.hcl
}
