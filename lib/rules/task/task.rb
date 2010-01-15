module Rule
  
  # DSL example:
  #   task "initial" do
  #     execute "updatedb"
  #     rake "spec"
  #   end
  def task(name, options = {}, &block)
    register_rule Task.new(name, options, &block)
  end
  
  class Task < Rule
    
    def initialize(name, options = {}, &block)
      super(name, options = {}, &block)
    end
    
    # Calls rake task(s) in current directory
    def rake(*tasks)
      "rake #{tasks.join(' ')}"
    end
    
  end
end