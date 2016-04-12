Your mission, should you choose to accept it
============================================

Write a Ruby command line application that

* accepts a list of search keywords as arguments
* queries the Flickr API for the top-rated image for each keyword
* downloads the results
* crops them rectangularly
* assembles a collage grid from ten images and
* writes the result to a user-supplied filename

If given less than ten keywords, or if any keyword fails to
result in a match, retrieve random words from a dictionary
source such as `/usr/share/dict/words`. Repeat as necessary
until you have gathered ten images.

Be careful and conservative in your handling of files and
other IO. Bonus points for wrapping the application in a
Gem. Please include a README with instructions on how to
install and run your application.

Hint: You're free to use any existing Gem which helps you to
get the challenge done.