module ContentDM
  class Collection
    attr_accessor :alias, :name
    
    def initialize(attrs = {})
      attrs.each do |attribute, value|
        self.send("#{attribute}=", value)
      end
    end
    
    class << self
      def from_rest_hash(hash)
        collection = self.new
        collection.name = hash['name']
        collection.alias = hash['alias']
        collection
      end
    end
    
    def alias=(val)
      @alias = val.nil? ? nil : val.strip
    end
  end
end