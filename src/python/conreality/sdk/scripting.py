# This is free and unencumbered software released into the public domain.

from time import time
import lupa

Error = lupa.LuaError

class Context:
  def __init__(self, package_path=None):
    self.runtime = lupa.LuaRuntime(unpack_returned_tuples=True)
    if package_path:
      self.prepend_package_path(package_path)

  @property
  def globals(self):
    return self.runtime.globals()

  @property
  def package_path(self):
    return self.globals.package.path.split(';')

  @package_path.setter
  def package_path(self, value):
    if type(value) is list:
      value = ';'.join(value)
    self.globals.package.path = value

  @property
  def package_cpath(self):
    return self.globals.package.cpath.split(';')

  @package_cpath.setter
  def package_cpath(self, value):
    if type(value) is list:
      value = ';'.join(value)
    self.globals.package.cpath = value

  def prepend_package_path(self, path):
    package_path = self.package_path
    package_path.insert(0, str(path))
    self.package_path = package_path
    return self

  def require(self, module):
    return self.runtime.require(module)

  def load_sdk(self):
    self.require('conreality.sdk')
    for module in ('geometry', 'knowledge', 'measures', 'messaging', 'model', 'physics'):
      self.define(module, self.require('conreality.sdk.' + module))
    kb = self.globals['knowledge']
    kb.scenario.is_simulation = lambda: True
    kb.time.now = time

  def load_code(self, code):
    return self.runtime.execute(code)

  def load_file(self, filepath):
    with open(filepath, 'r') as file:
      return self.load_code(file.read())

  def eval_code(self, code):
    return self.runtime.eval(code)

  def eval_file(self, filepath):
    with open(filepath, 'r') as file:
      return self.eval_code(file.read())

  def define(self, name, function):
    self.globals[name] = function

  def undefine(self, name):
    self.globals[name] = None
