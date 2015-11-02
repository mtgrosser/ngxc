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
end
