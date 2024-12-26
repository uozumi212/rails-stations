puts "Create screens"
Screen.destroy_all

3.times do |n|
  Screen.create(screen_number: n+1)
end
  puts "Screen created successfully"
