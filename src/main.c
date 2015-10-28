#include <stdio.h>

#include <mruby.h>
#include <mruby/array.h>
#include <mruby/string.h>
#include <mruby/irep.h>
#include <mruby/proc.h>

#include <ngxc.mrbc>
#include <cli.mrbc>

void print_error(mrb_state *mrb)
{
  mrb_value message;

  message = mrb_funcall(mrb, mrb_obj_value(mrb->exc), "message", 0);
  if (mrb_string_p(message)) {
    fwrite(RSTRING_PTR(message), RSTRING_LEN(message), 1, stderr);
    putc('\n', stderr);
  }
}

int main(int argc, const char *argv[])
{
    mrb_state *mrb;
    mrb_value ret;

    if (!(mrb = mrb_open())) {
        fprintf(stderr, "%s: could not initialize mruby\n", argv[0]);
        return -1;
    }

    mrb_value args = mrb_ary_new(mrb);
    int i;

    // convert argv into mruby strings
    for (i=1; i<argc; i++) {
        mrb_ary_push(mrb, args, mrb_str_new_cstr(mrb,argv[i]));
    }

    mrb_define_global_const(mrb, "ARGV", args);
     
    // load ngxc
    ret = mrb_load_irep(mrb, ngxc);
     
    // check and print exception
    if (mrb->exc) {
        print_error(mrb);
        return 1;
    }
    
    // load cli
    ret = mrb_load_irep(mrb, cli);
    
    // check and print exception
    if (mrb->exc) {
        print_error(mrb);
        return 1;
    }

     // cleanup
     mrb_close(mrb);
     return 0;
}
