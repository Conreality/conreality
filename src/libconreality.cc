#include <cstdio> /* for stderr, std::fprintf() */

extern "C" void
hello(void) {
  std::fprintf(stderr, "Greetings from C++ via libffi!\n");
}
