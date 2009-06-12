module ContentDM
  class Search
    attr_accessor :collections, :sortby, :fields, 
      :search_strings, :maxrecs, :start
    
    class << self
      def browse_collection(collection_alias, page = 1)
        self.new(:collections => [collection_alias], :start => start_for_page(page))
      end
      
      def start_for_page(page)
        (page - 1) * 20 + 1
      end
    end
    
    def initialize(options = {})
      options.each do |name, value|
        meth = "#{name}="
        self.send(meth, value)
      end
    end
    
    def hash_for_remote
      hash = {}
      hash['alias'] = collections
      hash['searchstring'] = search_strings unless search_strings.nil?
      hash['field'] = fields
      hash['sortby'] = sortby
      hash['field'] = fields
      hash['maxrecs'] = maxrecs
      hash['start'] = start
      hash
    end
    
    def results(connection)
      connection.search(hash_for_remote)
    end
    
    def maxrecs
      @maxrecs ||= 20
    end
    def sortby
      @sortby ||= 'title'
    end
    def fields
      @fields ||= ['title','subjec','descri','creato','date','type','format']
    end
  end
end