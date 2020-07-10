require 'awspec'
require 'hcl/checker'
require 'json'

require_relative 'util'

TFVARS = HCL::Checker.parse(File.open('testing.tfvars').read())

describe ecr_repository(TFVARS['repository_list'][0]) do
  it { should exist }
  test_policy_text('stub/repo-1-policy.json')
end

describe ecr_repository(TFVARS['repository_list'][1]) do
  it { should exist }
  test_policy_text('stub/repo-2-policy.json')
end