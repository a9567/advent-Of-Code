class Task1
  def similarity_and_distance(file_path)
    return puts "File not found: #{file_path}" unless File.exist?(file_path)
    total_distance, similarity_score = 0, 0
    similarity_array, difference_array = [], []
    column_one, column_two  = [], []
    content = File.read(file_path)
    size = content.split("\n").count
    size.times do |index|
      row = content.split("\n")[index].split
      column_one.push(row[0].to_i)
      column_two.push(row[1].to_i)
    end
    counter = 0
    column_one.sort.each do |item1|
      begin
        item2 = column_two.sort[counter]
        difference = item1 - item2
        difference_array.push(difference.abs)
        counter+=1
        break
      end until counter > size
    end
    difference_array.each do |difference|
      total_distance+=difference
    end
    column_one.each do |item1|
      similarity = 0
      column_two.each do |item2|
        similarity+=1 if item1 == item2
      end
      similarity_array.push(item1*similarity)
    end
    similarity_array.each do |similarity|
      similarity_score+=similarity
    end
    return {total_distance: total_distance , similarity_score: similarity_score}
  end
end

task = Task1.new
result = task.similarity_and_distance('./advent_of_code/test_data/test_data1.csv')
puts "Result: #{result}"