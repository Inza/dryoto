module Rule
  
  def firewall(options = {}, &block)
    register_rule Firewall.new(options, &block)
  end
  
  class Firewall < Rule
    
    def initialize(options = {}, &block)      
      super("firewall_rule", options = {}, &block)
    end
    
    def allow(*ports)
      @commands << "iptables allow #{ports.join(' ')}"
    end
    
    def block(*ports)
      @commands << "iptables block #{ports.join(' ')}"
    end

  end
end