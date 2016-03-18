include $(top_srcdir)/src/Makefile.flags
$(eval include $(top_srcdir)/src/Makefile.conf)

TESTS =        \
  camera.py    \
  driver.py    \
  geometry.py  \
  measures.py  \
  messaging.py \
  model.py     \
  scripting.py \
  video.py     \
  vision.py

TEST_EXTENSIONS = .py

AM_TESTS_ENVIRONMENT = PYTHONPATH="$(top_srcdir)/src/python"; export PYTHONPATH;
PY_LOG_COMPILER = $(PYTHON)
AM_PY_LOG_FLAGS = -m pytest
