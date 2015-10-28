# ngxc - Nginx configuration file compiler



## Building

In order to build ngxc, you need to build a customized version of mruby,
which includes some extra mrbgems.

### mruby
```bash
rake mruby
```

### ngxc

The ngxc binary can be built using the included Rakefile:

```bash
rake
```
