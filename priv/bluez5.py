#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

import pydbus

################################################################################

class NoSuchPeripheral(Exception):
    pass

class NoSuchService(Exception):
    pass

class NoSuchCharacteristic(Exception):
    pass

################################################################################

class Proxy(object):
    """D-Bus proxy object."""

    def __init__(self, parent=None):
        self.parent = parent

    def get_path(self, subpath=None):
        if subpath:
            assert type(subpath) is str
            return '{}/{}'.format(self.path, subpath)
        else:
            return self.path

    def get_child(self, subpath):
        return self.get_proxy(self.get_path(subpath))

    def get_proxy(self, path):
        assert not self.parent is None
        return self.parent.get_proxy(path)

################################################################################

class Adapter(Proxy):
    """Bluetooth LE adapter."""

    def __init__(self, name='hci0'):
        assert type(name) is str
        super(Adapter, self).__init__()
        self.name = name
        self.path = '/org/bluez/{}'.format(name)
        self.bus = pydbus.SystemBus()

    def get_proxy(self, path):
        return self.bus.get('org.bluez', path)

    def get_peripheral(self, address):
        return Peripheral(self, address)

    def peripherals(self):
        device_base_path = '{}/{}'.format(self.path, 'dev_')
        object_manager = self.bus.get('org.bluez', '/')
        for object_path in object_manager.GetManagedObjects():
            if object_path.startswith(device_base_path):
                device_subpath = object_path[len(device_base_path):]
                device_address = device_subpath.replace('_', ':')
                yield device_address
        return []

################################################################################

class Peripheral(Proxy):
    """Bluetooth LE peripheral."""

    def __init__(self, adapter, address):
        assert type(address) is str
        super(Peripheral, self).__init__(adapter)
        self.subpath = 'dev_{}'.format(address.upper().replace(':', '_'))
        self.path = adapter.get_path(self.subpath)
        try:
            self.proxy = self.get_proxy(self.path)
        except KeyError: # KeyError("no such object")
            raise NoSuchPeripheral(address) from None
        self.proxy.PropertiesChanged.connect(print) # TODO
        self.connect()

    def on_properties_changed(self, callback):
        self.proxy.PropertiesChanged.connect(callback)

    def get_service(self, id):
        return Service(self, id)

    def connect(self):
        assert not self.proxy is None
        self.proxy.Connect()
        if not self.proxy.Paired:
            self.proxy.Pair()
        return self

    def disconnect(self):
        assert not self.proxy is None
        self.proxy.Disconnect()
        return self

################################################################################

class Service(Proxy):
    """Bluetooth LE service."""

    def __init__(self, peripheral, id):
        assert type(id) is int
        super(Service, self).__init__(peripheral)
        self.subpath = 'service{:04x}'.format(id)
        self.path = peripheral.get_path(self.subpath)
        try:
            self.proxy = peripheral.get_child(self.subpath)
        except KeyError: # KeyError("no such object")
            raise NoSuchService('{:04x}'.format(id)) from None

    def get_characteristic_by_uuid(self, uuid):
        assert not self.proxy is None
        for characteristic_path in self.proxy.Characteristics:
            characteristic = self.get_proxy(characteristic_path)
            if characteristic.UUID == uuid:
                return Characteristic(self, characteristic, characteristic_path)
        raise NoSuchCharacteristic(uuid)

################################################################################

class Characteristic(Proxy):
    """Bluetooth LE characteristic."""

    def __init__(self, service, id, path=None):
        super(Characteristic, self).__init__(service)
        if type(id) is int:
            self.subpath = 'char{:04x}'.format(id)
            self.path = service.get_path(self.subpath)
            try:
                self.proxy = service.get_child(self.subpath)
            except KeyError: # KeyError("no such object")
                raise NoSuchCharacteristic('{:04x}'.format(id)) from None
        else:
            self.subpath = None # TODO
            self.path = path
            self.proxy = id
        self.counter = 0

    def notify(self, callback):
        self.proxy.PropertiesChanged.connect(callback)
        self.proxy.StartNotify()
        return self

    def write(self, data):
        self.counter = (self.counter + 1) % 0xFF
        data[1] = self.counter
        #print(('write', self.path, data)) # DEBUG
        self.proxy.WriteValue(data)
        return self
