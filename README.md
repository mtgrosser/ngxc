# ngxc - Nginx configuration file compiler



## Building

In order to build ngxc, you need to build a customized version of mruby, which contains some additional mrbgems.

### mruby
```bash
export MRUBY_CONFIG=$PWD/build_config.rb
ruby-build mruby-1.1.0 ~/.rubies/mruby-1.1.0
```

### ngxc

The ngxc binary can be built using the included Rakefile:

```bash
rake
```
