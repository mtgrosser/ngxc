MRUBY_VERSION = '1.1.0'

task :mruby do
  sh "curl -L https://github.com/mruby/mruby/archive/#{MRUBY_VERSION}.tar.gz -o build/mruby.tar.gz"
  sh "tar -xzf build/mruby.tar.gz -C build"
  sh "cp build_config.rb build/mruby-#{MRUBY_VERSION}"
  sh "cd build/mruby-#{MRUBY_VERSION} && ./minirake"
end

task :default do
  prefix = "build/mruby-#{MRUBY_VERSION}"
  sh "#{prefix}/bin/mrbc -B ngxc -o build/ngxc.mrbc lib/ngxc.rb"
  sh "#{prefix}/bin/mrbc -B cli -o build/cli.mrbc lib/cli.rb"
  sh "gcc -Isrc -I#{prefix}/mruby/src -I#{prefix}/include -Ibuild -c src/main.c -o build/main.o"
  sh "gcc -o build/ngxc build/main.o #{prefix}/build/host/lib/libmruby.a"
end

task :clean do
  sh "rm -rf build/*"
end
