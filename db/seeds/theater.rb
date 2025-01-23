puts "Create theaters"

Theater.destroy_all

2.times do |n|
  Theater.create!(
    name: "#{n + 1}",
  )
end

puts "Theater Create successfully"
