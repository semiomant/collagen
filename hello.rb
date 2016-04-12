


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
        puts '-k "string" => string containing a list of up to ten words separated by spaces'
        puts '-f "string" => name of file you want the result written to'
        exit
    end
end

arguments