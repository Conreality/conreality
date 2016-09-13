-- This is free and unencumbered software released into the public domain.

--- Conreality Software Development Kit (SDK)
-- @module conreality.sdk

return {
  _VERSION  = '0.0.0', -- TODO
  geometry  = require('conreality/sdk/geometry'),
  knowledge = require('conreality/sdk/knowledge'),
  machinery = require('conreality/sdk/machinery'),
  measures  = require('conreality/sdk/measures'),
  messaging = require('conreality/sdk/messaging'),
  model     = require('conreality/sdk/model'),
  physics   = require('conreality/sdk/physics'),
}
