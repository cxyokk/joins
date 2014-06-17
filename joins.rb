
class Joins
  
  def initialize
    @ta = %w'1 2 3 7 8 9'
    @tb = %w'0 2 3 4 5 8 10'
    @joins = %w'inner_join left_outer_join full_outer_join'
    @joins += %w'left_join_only_left full_join_no_intersect'
  end

  def gogogo
    puts 'ta: ' + @ta.to_s
    puts 'tb: ' + @tb.to_s
    @joins.each do |j|
      puts "\n" + j + ':'
      pp 'ta', 'tb'
      send(j)
    end
  end

  def pp(*args)
    puts "\t" + args.map {|i|
      i.nil? ? 'NULL' : i.to_s
    }.join("\t")
  end

  def ppppp(rows)
    rows.each do |i|
      a = @ta.include?(i) ? i : nil
      b = @tb.include?(i) ? i : nil
      pp a, b
    end
  end

  def inner_join
    ppppp @ta & @tb
  end

  def left_outer_join
    ppppp @ta
  end

  def full_outer_join
    ppppp @ta | @tb
  end

  def left_join_only_left
    ppppp(@ta.select do |i|
      not @tb.include? i
    end)
  end
 
  def full_join_no_intersect
    ppppp (@ta | @tb) - (@ta & @tb)
  end

end

Joins.new.gogogo
