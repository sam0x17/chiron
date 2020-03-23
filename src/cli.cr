require "./chiron"

class Chiron::CLI
  @@autorun : Bool = true

  def self.autorun?
    @@autorun
  end

  def self.autorun=(val)
    @@autorun = val
  end

  def initialize
    puts "hello world"
  end
end

Chiron::CLI.new if Chiron::CLI.autorun?
