class Processor
  attr_accessor :rules
  
  def initialize(rules)
    @rules   = rules
  end
  
  def generate_output(options = {:output  => :bash})
    case options[:output]
      when :tree then to_tree
      when :bash then to_shell
      else raise "Unknown output type."
    end    
  end
  
  def to_tree
    out = ""
    @rules.each_value { |r| out << ":#{r.name} [#{r.dependencies.join(' ')}]\n  #{r.commands.join("\n  ")}\n" }    
    out
  end
  
  def to_shell
    out = ""
    @rules.each_value { |r| out << "\# #{r.name}\n" + r.commands.join("\n") + "\n"*2 }
    out
  end
end