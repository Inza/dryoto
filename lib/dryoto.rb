# Dryoto libraries
require "../lib/rule"
Dir[File.dirname(__FILE__) + '/rules/*/*.rb'].each { |r| require r }
require "../lib/processor"
require "../lib/verify"

# DSL modules reside in Rule namespace
class Object
  include Rule
end

class Dryoto
  NORMALIZED_RULES = []
  
  # Load and process rules
  # @returns executable bash script 
  def self.run(options)
    load(options)
    Processor.new(RULES).generate_output(options)
  end
  
protected
  
  # Interpret rules from string or from file
  def self.load(options)
    raise "Usuported options" unless options.respond_to? :[]
    
    config_string = if options[:string]
                      options[:string]
                    elsif options[:file]
                      File.read(options[:file])
                    end
    eval(config_string)
  end

end