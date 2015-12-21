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

local function sockaddr(addr, port)
  return {family = socket.AF_INET, addr = addr, port = port}
end

local sock = assert(socket.socket(socket.AF_INET, socket.SOCK_DGRAM, 0))
assert(socket.bind(sock, sockaddr('127.0.0.1', 0)))
assert(socket.connect(sock, sockaddr('127.0.0.1', 1984)))

while true do
  io.write("> ")
  io.stdout:flush()

  local command = io.read()

  if not command then break end -- EOF

  if not (command == "") then
    local _, err = loadstring(command, 'stdin') -- TODO: load() in Lua 5.2+
    if err then
      io.stderr:write(err .. "\n") -- parse error
    else
      assert(socket.send(sock, command))
    end
  end
end

io.write("\n")
os.exit()
