module Rule
  
  class Verify
    attr_accessor :rule, :commands
    
    def initialize(rule, options, &block)
      @rule = rule
      @commands = []
      self.instance_eval &block
    end
    
    def has_file(path)
      @commands << "test -f #{path}"
    end
    
    def has_directory(directory)
      @commands << "test -d #{directory}"
    end
    
    def has_gem(name)
      @commands << "sudo gem list | grep -e '^#{name}'"
    end
  end
end