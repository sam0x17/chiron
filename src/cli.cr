require "./chiron"

class Chiron::CLI
  @@autorun : Bool = true
  VERSION = "0.1.0"

  def self.autorun?
    @@autorun
  end

  def self.autorun=(val)
    @@autorun = val
  end

  def initialize
    print_usage
  end

  def print_usage
    puts ""
    puts "Chiron #{VERSION} | https://github.com/sam0x17/chiron"
    puts ""
    puts "usage: chiron [subcommand] (args..)"
    puts ""
    puts "subcommands:"
    puts ""
    puts "  - chiron init [name]"
    puts ""
    puts "    * if name is specified, creates a new project with"
    puts "      default directories (css/html/js) and the"
    puts "      specified project name"
    puts "    * otherwise simply creates chiron config file in"
    puts "      the current directory"
    puts ""
    puts "  - chiron watch [--port 3000]"
    puts ""
    puts "    * runs the local development server"
    puts "    * default port is 3000"
    puts "    * must be executed from a chiron project directory"
    puts ""
    puts "  - chiron deploy"
    puts ""
    puts "    * deploys the current project based on config"
    puts "    * must be executed from a chiron project directory"
    puts ""
  end
end

Chiron::CLI.new if Chiron::CLI.autorun?
