#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <cstdio> /* for stderr, std::*printf() */

////////////////////////////////////////////////////////////////////////////////

extern "C" void
hello(void) {
  std::fprintf(stderr, "Greetings from C++ via libffi!\n");
}
