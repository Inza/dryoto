require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class RuleTest < Test::Unit::TestCase
  
  def test_setting_and_getting_variable
    str = "task 'check' do; set :version, '2.1.0'; execute 'echo ' + get(:version); end"
    out = Dryoto.run(:string => str, :output => :bash)
    assert_equal out.strip, "# check\necho 2.1.0"
  end
end