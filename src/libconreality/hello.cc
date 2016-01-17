#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <cstdio>          /* for stderr, std::*printf() */

#include <caml/memory.h>   /* for CAMLlocal1(), CAMLparam?(), CAMLreturn() */
#include <caml/mlvalues.h> /* for value */

////////////////////////////////////////////////////////////////////////////////

extern "C" CAMLprim value
caml_hello(value v_unit) {
  CAMLparam1(v_unit);
  std::fprintf(stderr, "Greetings from %s() in C++!\n", __func__);
  CAMLreturn(Val_unit);
}
