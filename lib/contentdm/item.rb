module ContentDM
  class Item
    attr_accessor :collection_alias, :id,
      :title, :filetype, :settings, :thumbnail
    
    class << self
      def from_hash(hsh)
        item = self.new
        item.collection_alias = hsh['alias']
        item.id = hsh['ptr']
        item.title = hsh['title']
        item.filetype = hsh['filetype']
        item.settings = hsh['settings']
        item.thumbnail = hsh['thumbnail']
        item
      end
    end
  end
end