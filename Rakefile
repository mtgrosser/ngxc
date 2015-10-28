MRUBY_VERSION = '1.1.0'
PREFIX = "build/mruby-#{MRUBY_VERSION}"


task :mruby do
  STDOUT.puts "\nChecking for mruby ..."
  mruby_installed = ["#{PREFIX}/bin/mrbc", "#{PREFIX}/src", "#{PREFIX}/include", "#{PREFIX}/build/host/lib/libmruby.a"].all? do |file|
    STDOUT.print "    #{file} ... "
    if File.exist?(file)
      STDOUT.puts "ok"
      true
    else
      STDOUT.puts "missing"
    end
  end
  if mruby_installed
    STDOUT.puts "Your mruby is looking good\n\n"
  else
    STDOUT.puts "Looks like we need to build a customized mruby\n\n"
    sh "curl -L https://github.com/mruby/mruby/archive/#{MRUBY_VERSION}.tar.gz -o build/mruby.tar.gz"
    sh "tar -xzf build/mruby.tar.gz -C build"
    sh "cp build_config.rb build/mruby-#{MRUBY_VERSION}"
    sh "cd build/mruby-#{MRUBY_VERSION} && ./minirake"
  end
end

task :default => :mruby do
  sh "#{PREFIX}/bin/mrbc -B ngxc -o build/ngxc.mrbc lib/ngxc.rb"
  sh "#{PREFIX}/bin/mrbc -B cli -o build/cli.mrbc lib/cli.rb"
  sh "gcc -Isrc -I#{PREFIX}/src -I#{PREFIX}/include -Ibuild -c src/main.c -o build/main.o"
  sh "gcc -o build/ngxc build/main.o #{PREFIX}/build/host/lib/libmruby.a"
end

task :clean do
  sh "rm -rf build/*"
end
