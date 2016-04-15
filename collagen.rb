require "rest-client"
require "json"

class Collagen

    def init_vars
        @api_base = "https://api.flickr.com/services/rest/?format=json"
        @default_out_file = "output.jpg"
        @fallback_tags = []
    end
        

    def initialize  #(args)
       init_vars
       insert_api_key
       args = arguments
       tags = process_tags args['-k']
    end
    
    def arguments
        allowed_options = ['-k','-f']
        begin
            args = Hash[*ARGV]
            unless args.keys.all? { |e| allowed_options.include? e } 
                 raise "bzzt"
            end
        rescue Exception => e
            puts 'bad command line options'
            puts 'Usage:'
            puts '-k "string" => string containing a list of up to ten words separated by commas'
            puts '-f "string" => name of file you want the result written to'
            exit
        end
        args
    end

    def insert_api_key
        f = File.open("mysecret.txt", "r:UTF-8")
        api_key = f.readline.chomp
        f.close
        @api_base += "&api_key=" + api_key + "&method="
    end

    def process_tags(tag_str)
        fill_tags tag_str,10 unless tag_str
        tag_list = 
    end

    # farm this out to a service object
    # then u canlater choose the source of the fill-words
    # other random word source than hottags 
    def fill_tags(tag_str,count)
        puts "u r missing #{count} of 10 tags. Collagen always runs with 10 tags. filling..."
        tag_str ="" unless tag_str
        pop_tags = get_popular_tags
        tag_list = []   
        pop_tags.each_with_index {|tag_hash, i|
            if  
                tag_list.push tag_hash['_content']
        }
        p tag_list
    end

    def get_popular_tags
        call = @api_base + "flickr.tags.getHotList"
        res = RestClient.get call
        res = JSON.parse(trim_flickr_json res)
        res["hottags"]["tag"] 
    end

    def trim_flickr_json str
        str[str.length-1] = ""
        str.gsub "jsonFlickrApi(",""
    end
end

Collagen.new