module ContentDM
  class Collection
    attr_accessor :alias
    
    def initialize(attrs)
      attrs.each do |attribute, value|
        self.send("#{attribute}=", value)
      end
    end
    
    def alias=(val)
      @alias = val.strip
    end
  end
end