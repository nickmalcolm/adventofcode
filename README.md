# Advent Of Code 2016

Nick's Advent of Code solutions for 2016.

Puzzles are solved in Ruby and can be run like

```
  ruby day1/puzzle1.rb
```

## Guesses & Solutions

|Day|Puzzle|Guess|Correct?|Notes|
|---|------|-----|--------|-----|
|1|1|273|Yes|
|1|2|257|No|I thought it was first revist of distinct direction destinations,when it's actually wanting the first time you cross your path|
|1|2|115|Yes
|2|1|26562|No|Too low - typo in the `Key#key` (`[x][y]` instead of `[y][x]`)
|2|1|48584|yes
|2|1|563B6|yes
|2|1|48584|no
|3|1|1034|no|Used `max <= sum of other two smaller sides`
|3|1|1032|yes|Used array permutations
|3|2|1838|yes