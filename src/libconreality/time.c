/* This is free and unencumbered software released into the public domain. */

#include <caml/mlvalues.h>
#include <caml/memory.h> // for CAMLparam1 etc
#include <caml/alloc.h>
#include <caml/custom.h>

#include <sys/time.h>

//#define DEBUG
#ifdef DEBUG
#include <stdio.h>
#include <stdlib.h>
#endif


void delayMicrosecondsHard (unsigned int howLong) {
#ifdef DEBUG
  printf("entering delay_microsecondsHard returning: %d\n", howLong);
#endif
  struct timeval tNow, tLong, tEnd ;
  gettimeofday (&tNow, NULL) ;
  tLong.tv_sec  = howLong / 1000000 ;
  tLong.tv_usec = howLong % 1000000 ;
  timeradd (&tNow, &tLong, &tEnd) ;
  while (timercmp (&tNow, &tEnd, <))
    gettimeofday (&tNow, NULL) ;
#ifdef DEBUG
  printf("delay_microsecondsHard returning: %d\n", howLong);
#endif
}

value caml_time_delay_microseconds(value ms)
{
  CAMLparam1 (ms);
  unsigned int delay = Int_val(ms);
#ifdef DEBUG
  printf("entering delay_microseconds returning: %d\n", delay);
#endif
  struct timespec sleeper ;
  struct timespec remainder ;
  if (delay == 0) return ;
  else if (delay < 100)
    delayMicrosecondsHard (delay) ;
  else {
    sleeper.tv_sec  = (long)(delay/1000000);
    sleeper.tv_nsec = (long)((delay%1000000) * 1000);
    while (-1 == nanosleep (&sleeper, &remainder)) {
      sleeper.tv_sec  = remainder.tv_sec;
      sleeper.tv_nsec = remainder.tv_nsec;
    }
  }
#ifdef DEBUG
  printf("delay_microseconds returning: %d\n", delay);
#endif
  CAMLreturn (Val_unit);
}
