module Rule
  
  # DSL example:
  #   package "ruby" do
  #     apt "ruby"
  #     gem "chronos"
  #     source :download_url => "http://...", :enable => "nls", :disable => "x"
  #   end
  def package(name, options = {}, &block)
    register_rule Package.new(name, options, &block)
  end
  
  class Package < Rule
    
    def initialize(name, options = {}, &block)
      raise 'No package name supplied' unless name
      super(name, options = {}, &block)
    end
    
    def apt(*packages)
      @commands << "DEBIAN_FRONTEND=noninteractive aptitude install -y #{packages.join(' ')}"
    end
    
    def gem(*packages)
      @commands << "gem install #{packages.join(' ')}"
    end
    
    
  end
end