
class Joins
  
  def initialize
    @ta = %w'1 2 3 7 8 9'
    @tb = %w'0 2 3 4 5 8 10'
    @joins = %w'inner_join left_outer_join full_outer_join'
    @joins += %w'left_join_only_left full_join_no_intersect'
  end

  def show_me
    puts 'ta: ' + @ta.to_s
    puts 'tb: ' + @tb.to_s
    @joins.each do |j|
      puts "\n" + j + ':'
      p_row 'ta', 'tb'
      p_table send(j)
    end
  end

private

  def p_row(*args)
    puts args.map {|i|
      i.nil? ? 'NULL' : i.to_s
    }.join("\t").prepend "\t"
  end

  def p_table(rows)
    rows.each do |i|
      a = @ta.include?(i) ? i : nil
      b = @tb.include?(i) ? i : nil
      p_row a, b
    end
  end

  def inner_join
    @ta & @tb
  end

  def left_outer_join
    @ta
  end

  def full_outer_join
    @ta | @tb
  end

  def left_join_only_left
    @ta.select do |i|
      not @tb.include? i
    end
  end
 
  def full_join_no_intersect
    (@ta | @tb) - (@ta & @tb)
  end

end

Joins.new.show_me
