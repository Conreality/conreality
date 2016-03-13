/* This is free and unencumbered software released into the public domain. */

#include <stdio.h>
#include <stdlib.h>

#include <caml/mlvalues.h>
#include <caml/memory.h> // for CAMLparam1 etc
#include <caml/alloc.h>
#include <caml/custom.h>

// for open
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

// for mmap
#include <sys/mman.h>
 
// for sysconf
//#include <unistd.h>

// #define DEBUG 1

// fixme     int munmap(void *addr, size_t length);

#define handle_error(msg) do { perror(msg); exit(EXIT_FAILURE); } while (0)

value caml_mmap32_mmap(value addr, value len)
{
  CAMLparam2 (addr, len);

  int fd = open("/dev/mem", O_RDWR, O_NONBLOCK | O_SYNC);
  // O_DIRECT | O_LARGEFILE don't seem to be implemented on Raspberry Linux
  if (fd == -1)
    handle_error("open");

//  void *real_ptr = (void*)(Int32_val(addr)); // raspberry cc does not like void*
  off_t real_ptr = (off_t)(Int32_val(addr));
  size_t l = (Int_val(len));

// fixme cant get pagesize with sysconf on Raspberry Pi 2
//  off_t pa_ptr = real_ptr & ~(sysconf(PAGESIZE) - 1); // put on page boundary
  off_t pa_ptr = real_ptr;

// MAP_UNINITIALIZED is named in the mmap man page, but does not exist on R Pi
// MAP_NORESERVE causes coredump
//  void *virt_ptr = mmap(NULL, l + real_ptr - pa_ptr, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE | MAP_UNINITIALIZED, fd, pa_ptr);
//  void *virt_ptr = mmap(NULL, l + real_ptr - pa_ptr, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE, fd, pa_ptr);
  void *virt_ptr = mmap(NULL, l + real_ptr - pa_ptr, PROT_READ | PROT_WRITE, MAP_SHARED, fd, pa_ptr);
  if (virt_ptr == MAP_FAILED)
    handle_error("mmap");
  virt_ptr += (real_ptr - pa_ptr);
#ifdef DEBUG
  printf("mmap returning: %X\n", virt_ptr);
#endif

  CAMLreturn (caml_copy_int32((int32)virt_ptr));
}


value caml_mmap32_read(value mptr, value offset)
{
  CAMLparam2 (mptr, offset);
  int32 *ptr = (int32*)(Int32_val(mptr));
#ifdef DEBUG
  printf("read mptr: %X\n", ptr);
#endif
  int off = (Int_val(offset));
#ifdef DEBUG
  printf("read offset: %d\n", off);
#endif
  int32 ret = ptr[off];
#ifdef DEBUG
  printf("read return val: %X\n", ret);
#endif
  CAMLreturn (caml_copy_int32(ret));
}

value caml_mmap32_write(value mptr, value offset, value data)
{
  CAMLparam3 (mptr, offset, data);
  int32 *ptr = (int32*)(Int32_val(mptr));
#ifdef DEBUG
  printf("write mptr: %X\n", ptr);
#endif
  int off = (Int_val(offset));
#ifdef DEBUG
  printf("write offset: %d\n", off);
#endif
  int32 dat = (Int32_val(data));
#ifdef DEBUG
  printf("write val: %X\n", dat);
#endif
  ptr[off] = dat;
  CAMLreturn (Val_unit);
}

