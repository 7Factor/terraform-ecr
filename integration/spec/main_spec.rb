require 'awspec'
require 'hcl/checker'
require 'json'

TFVARS = HCL::Checker.parse(File.open('testing.tfvars').read())

describe ecr_repository(TFVARS['repository_list'][0]) do
  it { should exist }

  context 'has the correct policy text' do
    its(:policy_text) { should eq File.read('stub/repo-1-policy.json') }
  end
end

describe ecr_repository(TFVARS['repository_list'][1]) do
  it { should exist }

  context 'has the correct policy text' do
    its(:policy_text) { should eq File.read('stub/repo-2-policy.json') }
  end
end