require 'digest'

# example
# door_id = "abc"

door_id = "ojvtpuvg"
i = 0
code = ""
loop do
  input = "#{door_id}#{i}"
  digest = Digest::MD5.hexdigest(input)
  if digest.start_with?("00000")
    code += digest[5]
    puts "#{input} gives us '#{code}'"
    break if code.length == 8
  end
  i += 1
end

puts "done"

# 4543c154 is right