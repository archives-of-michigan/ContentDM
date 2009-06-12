module ContentDM
  class Search
    class CollectionsRequired < StandardError; end
    
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
      if collections
        hash['alias'] = collections.map { |c| c !~ /^\// ? "/#{c}" : c }
      else
        raise CollectionsRequired, "You must specify at least one collection to search"
      end
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