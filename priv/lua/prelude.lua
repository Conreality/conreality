-- This is free and unencumbered software released into the public domain.

--- Conreality Software Development Kit (SDK) prelude

for module, module_table in pairs(require('conreality.sdk')) do
  if type(module_table) == 'table' then
    for variable, value in pairs(module_table) do
      _G[variable] = value
    end
  end
end

function on_camera_frame(camera)
end

function on_gamepad_input(gamepad)
end
