#!/usr/bin/env lua
-- This is free and unencumbered software released into the public domain.
--
-- Prototype of the `conrepl` command-line interface.
--
-- Requires: https://luarocks.org/modules/gvvaughan/luaposix
-- $ sudo luarocks install luaposix

local signal = require('posix.signal')
local socket = require('posix.sys.socket')

signal.signal(signal.SIGINT, function(signum)
  io.write("\n")
  os.exit(128 + signum)
end)

local sock = assert(socket.socket(socket.AF_INET, socket.SOCK_DGRAM, 0))
assert(socket.bind(sock, {family = socket.AF_INET, addr = '127.0.0.1', port = 0}))
assert(socket.connect(sock, {family = socket.AF_INET, addr = '127.0.0.1', port = 1984}))

while true do
  io.write("> ")
  io.stdout:flush()
  local command = io.read()
  if not command then break end
  assert(socket.send(sock, command))
end
io.write("\n")
