$unsorted_index = []
$reversed = false
gets.to_i
$arr_numbers = gets
$arr_numbers = $arr_numbers.split(' ').map(&:to_i)

def swap(index1, index2)
  arr = $arr_numbers.dup
  temp = arr[index1]
  arr[index1] = arr[index2]
  arr[index2] = temp
  arr
end

def reverse(reversed_index)
  arr = $arr_numbers.dup
  i = reversed_index.first
  itr = 0
  return arr if reversed_index.size < 3
  while i <= reversed_index.last
    arr[i] = $arr_numbers[reversed_index.last - itr]
    itr += 1
    i += 1
  end
  arr
end

def do_swap(range)
  if $reversed == true
    do_reverse
    return
  end
  $arr_numbers.each_with_index do |v,i|
    if range.cover? v
      if sorted? swap(i, $unsorted_index.first)
        puts 'yes'
        puts "swap #{$unsorted_index.first + 1} #{i+1}"
        return
      end
    end
  end
  do_reverse
end

def do_reverse
  reversed_index = []
  reversed_streak = 0
  streak = false
  $arr_numbers.each_with_index do |val, index|
    unless index == 0
      if $arr_numbers[index - 1] > val
        if streak == true
          reversed_streak += 1
          reversed_index.push index - 1
        end
        if reversed_streak == 0
          reversed_streak += 1
          reversed_index.push index - 1
          streak = true
        end
      end
      if $arr_numbers[index-1] < val && streak
        reversed_index.push index - 1
        streak = false
      end
    end
  end

  if sorted? reverse(reversed_index)
    puts 'yes'
    puts "reverse #{reversed_index.first + 1} #{reversed_index.last + 1}"
  else
    puts 'no'
  end
end

def sorted?(arr)
  arr.each_with_index do |val, index|
    unless index == 0
      return false if arr[index - 1] > val
    end
  end
  true
end

@reversed_streak = 0
@streak = false

def reversed?(val, index)
  unless index == $arr_numbers.size - 1
    # start reversed
    if val > $arr_numbers[index + 1] && val > $arr_numbers[index -1] && @reversed_streak == 0
      @reversed_streak += 1
      @streak = true
    end
    # check streak is currently running
    if val < $arr_numbers[index - 1] && val > $arr_numbers[index + 1] && @streak == true
      @reversed_streak += 1
    end
    # check end streak
    if val < $arr_numbers[index - 1] && val < $arr_numbers[index + 1] && @streak == true
      @reversed_streak += 1
      @streak = false
      $reversed = true if @reversed_streak >= 3
    end
  end
end

$arr_numbers.each_with_index do |val, index|
  reversed?(val, index)
end

$arr_numbers.each_with_index do |val, index|
  if val > $arr_numbers[index - 1] && val > $arr_numbers[index + 1]
    $unsorted_index.push index
    min = $arr_numbers[index - 1]
    max = $arr_numbers[index + 1]
    do_swap min..max
    break
  end
end



if $unsorted_index.empty?
  puts 'yes'
end
