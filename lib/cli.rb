USAGE = "Usage: ngxc [options] file [outfile]\n\nOptions:\n   --version  show version\n   --help     show help"

def usage!
  raise USAGE
end

def usage
  STDOUT.puts USAGE
end

case ARGV.first
when '--help'
  usage
when '--version'
  STDOUT.puts "ngxc, version #{Ngxc::VERSION}\n"
else
  case ARGV.size
  when 1
    STDOUT.puts Ngxc::Configuration.new(ARGV.first).to_conf
  when 2
    File.open(ARGV.last, 'w') { |file| file << Ngxc::Configuration.new(ARGV.first).to_conf }
  else
    usage!
  end
end
