#!/usr/bin/env ruby

ON = '#'
OFF = '.'

require "curses"
include Curses

def onsig(sig)
  close_screen
  exit sig
end

for i in 1 .. 15  # SIGHUP .. SIGTERM
  begin
    if trap(i, "SIG_IGN") != 0  # 0 for SIG_IGN
      trap(i) {|sig| onsig(sig) }
    end
  rescue
  end
end

init_screen
nl
noecho

infile = ARGV[0]
steps = ARGV[1].to_i
@grid = File.readlines(infile).collect{|l|l.chomp.split('')}
resizeterm(@grid.size, @grid.first.size)

def set(line, col, val)
  @grid[line][col] = val
end

def get(line, col)
  @grid[line][col]
end

def on?(line, col)
  get(line, col) == ON
end

def calc_next(line, col)
  num_on = 0
  ((line - 1)..(line + 1)).each do |l|
    ((col - 1)..(col + 1)).each do |c|
      if l >= 0 && l < @ldim
        if c >= 0 && c < @cdim
          next if l == line && c == col
          num_on += 1 if on?(l, c)
        end
      end
    end
  end
  if on?(line, col)
    num_on == 2 || num_on == 3 ? ON : OFF
  else
    num_on == 3 ? ON : OFF
  end
end

@ldim = @grid.size
@cdim = @grid.first.size

steps.times do |i| 
  next_grid = []
  @ldim.times do |l|
    next_grid[l] = []
    @cdim.times do |c|
      setpos(l, c); addstr(get(l, c))
      next_grid[l][c] = calc_next(l, c)
    end
  end
  @grid = next_grid
  refresh
  sleep 0.1
  if i == steps-1
    on = 0
    @grid.each do |l|
      l.each do |light|
        on += 1 if light == ON
      end
    end
    setpos(@ldim+1, 0); puts "DONE: #{on} ON"
    refresh
    sleep 1000
  end
end

