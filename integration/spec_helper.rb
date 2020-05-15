require 'awspec'

def value_string_parsed_to_ruby val
  begin
    eval(val) if val
  rescue SyntaxError => se
  end
end

TFVARS = open('testing.tfvars', 'r').readlines.inject({}) do |hash, line|
  kv_pair = line.split('=')
  key = kv_pair[0].strip
  hash[key] = value_string_parsed_to_ruby(kv_pair[1])
  hash
end
