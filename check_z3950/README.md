# Nagios Plugin - z39.50 checker

This is a Koha-centric z39.50 checker.

## How to use

Run command with `-i $instance:$port` where instance is simply a label, and port is the z39.50 port to connect to.

The `-i` is repeatable for as many instance:port tuples you need.

In `/etc/nagios/nrpe_local.cfg`:
```bash
command[nagios_check_z3950]=/usr/local/bin/nagios_check_z3950 -i helm:9998
```
