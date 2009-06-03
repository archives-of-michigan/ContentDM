require 'json'

module ContentDM
  module Test
    class RestServer
      def call(env)
        response = Rack::Response.new
    
        status, body = [404, "No route matches #{env['PATH_INFO']}"]
        if env['PATH_INFO'] =~ /collections.php$/
          status, body = [200, collections]
        end
    
        response.status = status
        response.body << body
    
        response.finish
      end
  
      def all_collections
        [
          {
            "alias" => "/p4006coll2",
            "name" => "Governors of Michigan",
            "path" => "D:\\Sites\\129401\\Data\\p4006coll2"
          },
          {
            "alias" => "/p4006coll3",
            "name" => "Civil War Photographs",
            "path" => "D:\\Sites\\129401\\Data\\p4006coll3"
          },
          {
            "alias" => "/p4006coll7",
            "name" => "Lighthouses and Life-Saving Stations",
            "path" => "D:\\Sites\\129401\\Data\\p4006coll7"
          },
          {
            "alias" => "/p4006coll4",
            "name" => "Early Photography",
            "path" => "D:\\Sites\\129401\\Data\\p4006coll4"
          },
          {
            "alias" => "/p4006coll5",
            "name" => "Sheet Music",
            "path" => "D:\\Sites\\129401\\Data\\p4006coll5"
          },
          {
            "alias" => "/p4006coll8",
            "name" => "Main Streets",
            "path" => "D:\\Sites\\129401\\Data\\p4006coll8"
          },
          {
            "alias" => "/p4006coll10",
            "name" => "Architecture",
            "path" => "D:\\Sites\\129401\\Data\\p4006coll10"
          },
          {
            "alias" => "/p4006coll15",
            "name" => "Civil War Service Records",
            "path" => "D:\\Sites\\129401\\Data\\p4006coll15"
          },
          {
            "alias" => "/p4006coll17",
            "name" => "Oral Histories",
            "path" => "D:\\Sites\\129401\\Data\\p4006coll17"
          },
          {
            "alias" => "/p129401coll0",
            "name" => "WPA Property Inventories",
            "path" => "D:\\Sites\\129401\\data\\p129401coll0"
          },
          {
            "alias" => "/p129401coll3",
            "name" => "Maps",
            "path" => "D:\\Sites\\129401\\data\\p129401coll3"
          },
          {
            "alias" => "/p129401coll7",
            "name" => "Death Records, 1897-1920",
            "path" => "D:\\Sites\\129401\\data\\p129401coll7_1"
          },
          {
            "alias" => "/p129401coll10",
            "name" => "Michigan Polish Americans",
            "path" => "D:\\Sites\\129401\\data\\p129401coll10"
          }
        ]
      end
  
      def collections
        all_collections.to_json
      end
  
      def collection(collection_alias)
        all_collections[collection_alias].to_json
      end
    end
  end
end