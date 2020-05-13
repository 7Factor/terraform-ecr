require 'awspec'

describe ecr_repository('integration-test-repo-1') do
  it { should exist }
end

describe ecr_repository('integration-test-repo-2') do
  it { should exist }
end
