include $(top_srcdir)/src/Makefile.flags
$(eval include $(top_srcdir)/src/Makefile.conf)

check_SCRIPTS = \
  camera.py     \
  driver.py     \
  geometry.py   \
  measures.py   \
  messaging.py  \
  model.py      \
  scripting.py  \
  storage.py    \
  video.py      \
  vision.py

TESTS = $(check_SCRIPTS)

TEST_EXTENSIONS = .py

AM_TESTS_ENVIRONMENT = PYTHONPATH="$(top_srcdir)/src/python"; export PYTHONPATH;
PY_LOG_COMPILER = $(PYTHON)
AM_PY_LOG_FLAGS = -m pytest

EXTRA_DIST = $(check_SCRIPTS)
