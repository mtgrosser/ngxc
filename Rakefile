MRUBY_VERSION = '3.1.0'
PREFIX = "build/mruby-#{MRUBY_VERSION}"

desc 'Build mruby with required mrbgems'
task :mruby do
  puts "\nChecking for mruby ..."
  mruby_installed = ["#{PREFIX}/bin/mrbc", "#{PREFIX}/src", "#{PREFIX}/include", "#{PREFIX}/build/host/lib/libmruby.a"].all? do |file|
    print "    #{file} ... "
    if File.exist?(file)
      puts "ok"
      true
    else
      puts "missing"
    end
  end
  if mruby_installed
    puts "Your mruby is looking good\n\n"
  else
    puts "Looks like we need to build a customized mruby\n\n"
    sh "mkdir -p build"
    sh "curl -L https://github.com/mruby/mruby/archive/#{MRUBY_VERSION}.tar.gz -o build/mruby.tar.gz"
    sh "tar -xzf build/mruby.tar.gz -C build"
    sh "cp build_config/default.rb build/mruby-#{MRUBY_VERSION}/build_config"
    sh "cd build/mruby-#{MRUBY_VERSION} && ./minirake"
  end
end

desc 'Build ngxc binary'
task :default => :mruby do
  sh "#{PREFIX}/bin/mrbc -B ngxc -o build/ngxc.mrbc lib/ngxc.rb"
  sh "#{PREFIX}/bin/mrbc -B cli -o build/cli.mrbc lib/cli.rb"
  sh "gcc -Isrc -I#{PREFIX}/src -I#{PREFIX}/include -Ibuild -c src/main.c -o build/main.o"
  sh "gcc -o build/ngxc build/main.o #{PREFIX}/build/host/lib/libmruby.a -lm"
end

desc 'Test the ngxc binary'
task :test => :default do
  sh "mkdir -p test/tmp"
  sh 'build/ngxc test/test.ngxc test/tmp/actual.conf'
  sh 'diff --ignore-matching-lines "^# Date:" test/expected.conf test/tmp/actual.conf'
end

desc 'Cleanup build directory'
task :clean do
  sh "rm -rf build/*"
end
