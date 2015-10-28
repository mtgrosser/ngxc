MRuby::Build.new do |conf|
  toolchain :gcc

  conf.gem core: 'mruby-bin-mruby'
  conf.gem core: 'mruby-bin-mirb'
  
  conf.gem core: 'mruby-eval'
  conf.gem core: 'mruby-object-ext'
  conf.gem core: 'mruby-string-ext'
  conf.gem core: 'mruby-symbol-ext'
  conf.gem core: 'mruby-array-ext'
  conf.gem core: 'mruby-hash-ext'
  conf.gem core: 'mruby-time'
  conf.gem github: 'iij/mruby-io'
  conf.gem github: 'iij/mruby-errno'
  conf.gem github: 'iij/mruby-dir'
  conf.gem github: 'iij/mruby-process'
  conf.gem github: 'iij/mruby-pack'
  conf.gem github: 'ksss/mruby-file-stat'
  conf.gem github: 'gromnitsky/mruby-dir-glob'

  # conf.gem 'examples/mrbgems/c_extension_example' do |g|
  #   g.cc.flags << '-g' # append cflags in this gem
  # end
  # conf.gem 'examples/mrbgems/c_and_ruby_extension_example'
  # conf.gem :github => 'masuidrive/mrbgems-example', :checksum_hash => '76518e8aecd131d047378448ac8055fa29d974a9'
  # conf.gem :git => 'git@github.com:masuidrive/mrbgems-example.git', :branch => 'master', :options => '-v'

  # include the default GEMs
  #conf.gembox 'default'
end
