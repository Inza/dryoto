module Rule
  
  # DSL example:
  #   user "fakturoid" do
  #     group "ruby"
  #     ssh true
  #   end
  def user(name, options = {}, &block)
    register_rule User.new(name, options, &block)
  end
  
  class User < Rule
    
    def initialize(name, options = {}, &block)
      raise 'No user name supplied' unless name
      super(name, options = {}, &block)
    end
    
    def group(*packages)
      @commands << "DEBIAN_FRONTEND=noninteractive aptitude install -y #{packages.join(' ')}"
    end
    
    def gem(*packages)
      @commands << "gem install #{packages.join(' ')}"
    end
    
    
  end
end