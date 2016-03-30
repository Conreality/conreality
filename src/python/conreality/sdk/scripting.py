# This is free and unencumbered software released into the public domain.

import lupa

Error = lupa.LuaError

class Context:
  def __init__(self):
    self.runtime = lupa.LuaRuntime(unpack_returned_tuples=True)

  @property
  def package_path(self):
    return self.runtime.globals().package.path.split(';')

  @package_path.setter
  def package_path(self, value):
    if type(value) is list:
      value = ';'.join(value)
    self.runtime.globals().package.path = value

  @property
  def package_cpath(self):
    return self.runtime.globals().package.cpath.split(';')

  @package_cpath.setter
  def package_cpath(self, value):
    if type(value) is list:
      value = ';'.join(value)
    self.runtime.globals().package.cpath = value

  def prepend_package_path(self, path):
    package_path = self.package_path
    package_path.insert(0, str(path))
    self.package_path = package_path
    return self

  def load_code(self, code):
    self.eval_code(code)

  def load_file(self, filepath):
    self.eval_file(filepath)

  def eval_code(self, code):
    return self.runtime.eval(code)

  def eval_file(self, filepath):
    with open(filepath, 'r') as file:
      code = file.read()
      return self.eval_code(code)

  def define(self, name, function):
    self.runtime.globals()[name] = function

  def undefine(self, name):
    self.runtime.globals()[name] = None
