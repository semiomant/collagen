require "rest-client"
require "json"
require "open-uri"

# with more smaller objects (100 line rule)
# Collagen uses TagLists, PicComposer, PicFetcher
# so that functionalties can even be changed by providing other service objects
# pulggable, sort-of
# but refactor that later
class Collagen

    def init_vars
        @api_base = "https://api.flickr.com/services/rest/?format=json"
        @default_out_file = "output.jpg"
        @fallback_tags = []
        @max_no_of_tags = 3
    end
        

    def initialize  #(args)
        init_vars
        insert_api_key
        args = arguments
        tags = process_tags args['-k']
        download taglist_to_piclist tags
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

    #actually this tries to construct full list of tags so that
    #all pix can be loaded in one go, and providing a fallback as "object-global"
    #thats less than ideal
    # the "tag-stream" needs tobe passed around in a more useful manner
    # without reliance on pseudo-global vars  
    def process_tags(tag_str)
        tag_list = if tag_str
            tag_str.split(",")
        else
            fill_tags [], @max_no_of_tags
        end
        if tag_list.length < @max_no_of_tags
            fill_tags tag_list, @max_no_of_tags - tag_list.length
        end
        tag_list
    end

    # farm this out to a service object
    # then u canlater choose the source of the fill-words
    # other random word source than hottags 
    def fill_tags(tag_list,count)
        puts "u r missing #{count} of #{@max_no_of_tags} tags. filling..."
        pop_tags = get_popular_tags
        pop_tags.each {|tag_hash|
            if  count > 0
                tag_list.push tag_hash['_content']
                count -= 1
            else
                @fallback_tags.push tag_hash['_content']
            end
        }
        tag_list
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

    def taglist_to_piclist(tag_list)
        tag_list.map {|tag|
            tag_to_pic tag
        }
    end

    def tag_to_pic(tag)
        puts "gettin' pic for tag " + tag
        suppl = "flickr.photos.search&sort=interestingness-desc&per_page=5&tags="
        call = @api_base + suppl + tag
        res = RestClient.get call
        res = JSON.parse(trim_flickr_json res)
        res["photos"]["photo"][0]  
    end

    def download(pic_list)
        pic_list.each_with_index {|pdata,i|
            p pdata
            f   = pdata["farm"]
            sv  = pdata["server"]
            id  = pdata["id"]
            sec = pdata["secret"]
            img_adr ="http://farm#{f}.staticflickr.com/#{sv}/#{id}_#{sec}.jpg"
            puts "getting img #{i}"
            download = open(img_adr)
            IO.copy_stream(download, "./pics/image#{i}.png")
        }
    end

end

Collagen.new