
def decompress(string)
  decompressed = ""
  while string
    # Find the first set of instructions
    if string.match(/(\w*)\((\d+)x(\d+)/)
      decompressed += $1
      capture_length = $2.to_i
      repeats = $3.to_i

      # The character after our repeat count marks the start of the capture
      start = $~.offset(3)[1] + 1
      # Capture a length of the string
      capture = string[start..(start - 1) + capture_length]
      repeats.times { decompressed += capture}

      # Now get rid of the stuff we've processed
      string = string[start + capture_length..-1]
    else
      decompressed += string
      string = nil
    end
  end

  decompressed
end


# require 'json'
# json = JSON.parse(File.read("day9/puzzle1test.json"))
# failures = json.collect do |input, expected|
#   actual = decompress(input)
#   if actual == expected
#     print "."
#     next
#   else
#     print "F"
#     "With '#{input}' expected '#{expected}' but got '#{actual}'"
#   end
# end.compact
# puts failures

f = File.read("day9/input.txt")
puts "was #{f.length}"
decompressed = decompress(f)
puts "now #{decompressed.length}"

# 138735 is right