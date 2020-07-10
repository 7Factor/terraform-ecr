def test_policy_text(file_path)
  context 'has the correct policy text' do
    file = File.read(file_path)
    json = JSON.parse(["#{file}"].to_json).first
    its(:policy_text) { should eq json }
  end
end