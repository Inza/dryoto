module Rule
  
  def database(options = {}, &block)
    register_rule Database.new(options, &block)
  end
  
  class Database < Rule
    
    def initialize(options = {}, &block)
      super("database_rule", options = {}, &block)
    end
    
    def db(*dbnames)
      @commands << "createdb #{dbnames.join(' ')}"
    end
    
    def user(*users)
      @commands << "createuser #{users.join(' ')}"
    end

  end
end