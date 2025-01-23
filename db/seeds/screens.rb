puts "Create theaters and screens"

theater = Theater.create!(name: 'Sample Theater')

# theater.screens.create!(screen_number: 1)

puts "Theaters and Screens Create Success"

puts "Create Screens"

Screen.destroy_all

3.times do |n|
  theater.screens.create!(screen_number: n + 1)
end
puts "Screen created successfully"
