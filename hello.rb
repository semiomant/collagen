

p ARGV

def test
    cities  = %w[ London
              Oslo
              Paris
              Amsterdam
              Berlin ]
    visited = %w[Berlin Oslo]

    puts "Ich muss noch " +
         "die folgenden " +
         "Orte besuchen:",
         cities - visited
end

test