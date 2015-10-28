MRUBY_VERSION = '1.1.0'

task :mruby do
  
end

task :default do
  rbfu = "rbfu @mruby-#{MRUBY_VERSION}"
  sh "#{rbfu} mrbc -B ngxc -o build/ngxc.mrbc lib/ngxc.rb"
  sh "#{rbfu} mrbc -B cli -o build/cli.mrbc lib/cli.rb"
  mruby_prefix = `brew --prefix mruby`.strip
  mruby_dir = File.join(File.dirname(`#{rbfu} which mruby`.strip), '..')
  sh "gcc -Isrc -I#{mruby_prefix}/mruby/src -I#{mruby_prefix}/include -Ibuild -c src/main.c -o build/main.o"
  sh "gcc -o build/ngxc build/main.o #{mruby_dir}/lib/libmruby.a"
end

task :clean do
  sh "rm build/*"
end
