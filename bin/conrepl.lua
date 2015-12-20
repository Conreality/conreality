#!/usr/bin/env lua
-- This is free and unencumbered software released into the public domain.
--
-- Prototype of the `conrepl` command-line interface.
--
-- Requires: https://luarocks.org/modules/gvvaughan/luaposix
-- $ sudo luarocks install luaposix
--
-- Requires: https://luarocks.org/modules/luarocks/luasocket
-- $ sudo luarocks install luasocket

local signal = require("posix.signal")
local socket = require("socket")

signal.signal(signal.SIGINT, function(signum)
  io.write("\n")
  os.exit(128 + signum)
end)

local sock = socket.udp()
sock:setsockname('*', 0)
sock:setpeername("127.0.0.1", 1984)
sock:settimeout(nil)

while true do
  io.write('> ')
  io.stdout:flush()
  local command = io.read()
  if not command then break end
  sock:send(command)
end
io.write("\n")
