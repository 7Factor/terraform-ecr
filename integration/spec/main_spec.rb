require './spec_helper'

describe ecr_repository(TFVARS['repository_list'][0]) do
  it { should exist }
end

describe ecr_repository(TFVARS['repository_list'][1]) do
  it { should exist }
end
