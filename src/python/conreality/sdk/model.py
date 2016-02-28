# This is free and unencumbered software released into the public domain.

"""World model."""

class ObjectColor(object):
  pass

class ObjectShape(object):
  pass

class Object(object):
  """An object of interest."""

  def __init__(self, id=None, color=None):
    self.id = id
    self.label = None
    self.position = None
    self.orientation = None
    self.linear_velocity = None
    self.angular_velocity = None
    self.linear_acceleration = None
    self.mass = None
    self.shape = None
    self.color = color

  @property
  def inverse_mass(self):
    """Computes the inverse mass of this object."""
    return None # unknown

  def is_located(self):
    """Determines whether this object has a nonzero position."""
    return False

  def is_immovable(self):
    """Determines whether this is an immovable physical object."""
    return None # unknown

  def is_moving(self):
    """Determines whether this object has a nonzero linear velocity."""
    return None # unknown

  def is_rotating(self):
    """Determines whether this object has a nonzero angular velocity."""
    return None # unknown

  def is_accelerating(self):
    """Determines whether this object has a nonzero linear acceleration."""
    return None # unknown

  def is_active(self):
    """Determines whether this object is currently active."""
    return None # unknown

  def is_inactive(self):
    """Determines whether this object is currently inactive."""
    return None # unknown

  def __repr__(self):
    """Returns a human-readable string representation of this object."""
    return "object{{}}" # TODO

  def __str__(self):
    """Returns a human-readable string representation of this object."""
    return self.__repr__()
