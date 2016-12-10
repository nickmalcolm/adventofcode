input = [
  "eedadn",
  "drvtee",
  "eandsr",
  "raavrd",
  "atevrs",
  "tsrnev",
  "sdttsa",
  "rasrtv",
  "nssdts",
  "ntnada",
  "svetve",
  "tesnvt",
  "vntsnd",
  "vrdear",
  "dvrsen",
  "enarar"
]

column_frequencies = Array.new(6) { Hash.new(0) }
input.each do |line|
# column_frequencies = Array.new(8) { Hash.new(0) }
# File.open("day6/input.txt").each do |line|
  line.strip.each_char.with_index do |char, i|
    column_frequencies[i][char] += 1
  end
end

# Changed min to max for puzzle 2
most_frequent = column_frequencies.collect do |freq|
  min = freq.values.min
  freq.select { |k, f| f == min }.first.first
end

puts most_frequent.join

# kjxfwkdh is right
# xrwcsnps is right for puzzle 2