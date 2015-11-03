#include <caml/memory.h>
#include <caml/mlvalues.h>

#include <cstdio>

extern "C" CAMLprim value
caml_hello(value v_unit) {
  CAMLparam1(v_unit);
  std::fprintf(stderr, "Greetings from C++!\n");
  CAMLreturn(Val_unit);
}
