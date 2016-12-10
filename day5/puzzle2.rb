require 'digest'

# example
# door_id = "abc"
# i = 3231920

door_id = "ojvtpuvg"
i = 0
code = Array.new(8, "_") # Fill blanks as underscores so it looks cool
loop do
  input = "#{door_id}#{i}"
  i += 1

  digest = Digest::MD5.hexdigest(input)
  if digest.start_with?("00000")

    # The fifth character has the position of the code to fill
    pos = digest[5]
    next unless !!pos.match(/\d+/) # pos must be an int
    pos = pos.to_i
    next unless pos.between?(0, 7) # and within the size of the array
    next unless code[pos] == "_"   # don't overwrite existing code

    code[pos] = digest[6]
    puts "#{code.join} found at #{input}"
    break if code.join.gsub("_", "").length == 8

  end
end

puts "done"

# 1050cbbd was right