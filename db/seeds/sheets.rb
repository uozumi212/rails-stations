puts "Create sheets"
Sheet.destroy_all

# screen_id = 1
%w[1 2 3].each do |screen_id|
  %w[a b c].each do |row|
    (1..5).each do |column|
      Sheet.create(column: column, row: row, screen_id: screen_id)
    end
  end
end

 puts "Sheet created successfully"
