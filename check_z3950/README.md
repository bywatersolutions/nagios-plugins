# Nagios Plugin - z39.50 checker

This is a Koha-centric z39.50 checker.

## How to use

This plugin requires that the KOHA_CONF environment variable be set as part of the run.

```bash
define command{
	command_name check_z39.50
	command_line KOHA_CONF=/etc/koha/sites/instance/koha-conf.xml /path/to/check_z3950.sh
}
```

### Future development

This plugin could be extended to work in non-Koha environments pretty easily.
