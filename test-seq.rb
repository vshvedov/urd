require 'rubygems'
require './lib/grrr'

a=Grrr::Monome.new
b=Grrr::StepView.new(a, Grrr::Point.new(0, 7), a.num_cols, 1)
c=Grrr::MultiToggleView.new(a, Grrr::Point.new(0, 0), a.num_cols, 7)
c.values_are_inverted=true

Thread.new do
  i = 0
  while true
    b.playhead = i
    if b.step_value(i)
      puts "note: #{c.toggle_value(b.playhead)}"
    end

    sleep 0.15
    i = (i + 1) % a.num_cols
  end
end

b.num_cols.times do |index|
  c.set_toggle_value(index, rand(c.num_rows))
  b.set_step_value(index, [true, false].sample)
end

gets
