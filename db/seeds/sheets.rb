puts "Create sheets"
Sheet.destroy_all

3.times do |n|
  screen_id = n + 1
Sheet.create([{ column: 1, row: 'a', screen_id: screen_id }, { column: 2, row: 'a', screen_id: screen_id  }, { column: 3, row: 'a', screen_id: screen_id  }, { column: 4, row: 'a', screen_id: screen_id  }, { column: 5, row: 'a', screen_id: screen_id  }])
Sheet.create([{ column: 1, row: 'b', screen_id: screen_id }, { column: 2, row: 'b', screen_id: screen_id }, { column: 3, row: 'b', screen_id: screen_id }, { column: 4, row: 'b', screen_id: screen_id }, { column: 5, row: 'b', screen_id: screen_id }])
Sheet.create([{ column: 1, row: 'c', screen_id: screen_id }, { column: 2, row: 'c', screen_id: screen_id }, { column: 3, row: 'c', screen_id: screen_id }, { column: 4, row: 'c', screen_id: screen_id }, { column: 5, row: 'c', screen_id: screen_id }])
end
  puts "Sheet created successfully"
