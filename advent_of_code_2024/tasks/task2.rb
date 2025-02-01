class Task2
  def safe_reports(file_path)
    return puts "File not found: #{file_path}" unless File.exist?(file_path)
    contents_array = []
    safe_array = []
    content_with_difference = []
    safe_array_with_damper = []
    content = File.read(file_path)
    size = content.split("\n").count
    content.split("\n").each do |row|
      contents_array.push(row.split)
    end
    record_count = 0
    contents_array.each do |record|
      tmp_array = []
      value = record[0].to_i - record[1].to_i
      decider = value.positive? ? "positive?" : "negative?" 
      (record.count-1).times do |index|
        difference = record[index].to_i - record[index+1].to_i
        next if difference.abs >= 4
        next unless difference.send(decider)
        tmp_array.push(difference)
      end
      safe_array.push({record_id: record_count, record: tmp_array}) if tmp_array.include?(0) == false && tmp_array.length == (record.length-1)
      record_count+=1
    end
    # problem_damper
    # need to count the records if only one value is greater than 3 present in the record
    # [1 2 7 8 9] -> test1(unsafe)
    # [1 3 2 4 5] -> test2(safe)
    record_count = 0
    safe_array_with_damper = []
    contents_array.each do |record|
      skiped_record = []
      damper_tmp_array = []
      value = record[0].to_i - record[1].to_i
      decider = value.positive? ? "positive?" : "negative?" 
      (record.count-1).times do |index|
        difference = record[index].to_i - record[index+1].to_i
        puts "decider -> #{decider}"
        if difference.abs >= 4 || difference.send(decider) == false
          skiped_record.push(record[index+1])
          damper_check = record[index].to_i - record[index+2].to_i
          if damper_check.abs >= 4 || difference.send(decider) == false
            puts "decider -> #{decider}"
            skiped_record.push(record[index+2])
          end
        end
        damper_tmp_array.push(difference)
      end
      safe_array_with_damper.push({record_id: record_count, record: record, difference_array: skiped_record})
      record_count+=1
    end
    return {safe: safe_array.count, contents_array: contents_array, safe_array_with_damper: safe_array_with_damper}
  end
end

task = Task2.new
result = task.safe_reports('./advent_of_code_2024/test_data/test_data.csv')
puts "Result: #{result}"
