include $(top_srcdir)/src/Makefile.flags
$(eval include $(top_srcdir)/src/Makefile.conf)

check_SCRIPTS =   \
  opencv-camera.t \
  sysfs-gpio.t    \
  v4l2-camera.t

TESTS = $(check_SCRIPTS)

TEST_EXTENSIONS = .t

#AM_TESTS_ENVIRONMENT = PYTHONPATH="$(top_srcdir)/src/python"; export PYTHONPATH;
T_LOG_COMPILER = $(CRAM)
AM_T_LOG_FLAGS =

EXTRA_DIST = $(check_SCRIPTS) .cramrc
