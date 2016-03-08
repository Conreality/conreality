# This is free and unencumbered software released into the public domain.

import lupa

Error = lupa.LuaError

class Context(object):
  def __init__(self):
    self.runtime = lupa.LuaRuntime(unpack_returned_tuples=True)

  def load_code(self, code):
    self.eval_code(code)

  def load_file(self, filepath):
    self.eval_file(filepath)

  def eval_code(self, code):
    return self.runtime.eval(code)

  def eval_file(self, filepath):
    with open(filepath, 'r') as file:
      return self.runtime.eval(file.read())

  def define(self, name, function):
    self.runtime.globals()[name] = function

  def undefine(self, name):
    self.runtime.globals()[name] = None
