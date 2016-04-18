require "RMagick"
include Magick

names = Dir.new('./pics').entries.slice(2,10).map{|n| "./pics/"+n}
p names
imgs = ImageList.new(*names)

imgs.each {|i| p i.class, i.columns, i.rows}

# so also i.crop kommt als nächstes: wieeinfach das alles ist ;)
