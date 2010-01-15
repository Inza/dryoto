module Rule
  RULES = {} # should be ordered hash
  
protected 

  def register_rule(rule)
    name = rule.name
    raise "Double Rule definition error" if RULES.has_key? name
    RULES[name] = rule
    rule
  end
  
  class Rule
    
    attr_accessor :name, :dependencies, :commands
    
    def initialize(name, options = {}, &block)
      raise 'No rule name supplied' unless name

      @name = name
      @variables     = {}
      @commands      = []
      @dependencies  = []
      @verifications = []
      
      self.instance_eval &block
    end
    
    # Execute task
    def execute(*commands)
      after(commands)
    end
    
    # Set variable
    def set(name, value)
      @variables[name] = value
    end
    alias :[]= :set
        
    # Get variable
    def get(name)
      @variables[name]
    end
    alias :[] :get
    
    # Add dependency
    #   (alter execution order, moves rules with deps behind in execution que)
    def depends(*rules)
      @dependencies += rules
    end
    
    # Add verify block with conditions for current rule
    def verify(options = {}, &block)
      @verifications << Verify.new(self, options, &block)
    end

  protected
    
    def before(*cmds)
      @commands.insert(0, cmds)
    end
    alias :pre :before
    
    def after(*cmds)
      @commands << cmds
    end
    alias :post :after

  end
  
end