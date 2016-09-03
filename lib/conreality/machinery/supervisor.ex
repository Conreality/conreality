# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Supervisor do
  @moduledoc """
  Machinery supervisor for Conreality.

  This supervisor process detects and initializes any supported hardware
  devices present when the system is booted, as well as handles dynamic
  ("hotplug") device addition and removal at runtime.
  """
end
