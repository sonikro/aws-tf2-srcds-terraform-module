srcds-install
=========

This role downloads and install the corresponding srcds server, based on the provided GameID

Requirements
------------
This role depends on role *base* in order to work. Steamcmd is required

Role Variables
--------------

- srcds_gameid
  - The srcds gameid, this will define which game the srcds should download
  - Example: 232250 is TF2


Dependencies
------------

This depends on variables defined in *base* role

License
-------

BSD

Author Information
------------------

Sonikro