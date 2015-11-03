#include <caml/memory.h>
#include <caml/mlvalues.h>

#include <stdio.h>

CAMLprim value
caml_hello(value v_unit) {
  CAMLparam1(v_unit);
  fprintf(stderr, "Hello, world!\n");
  CAMLreturn(Val_unit);
}
