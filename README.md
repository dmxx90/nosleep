# nosleep
Linux bash script suspend timing

This is a simple script that you can put into your Linux startup script.
It works with ACPI enabled, suspend time configured, measures CPU usage
and simulates a human input to prevent system suspend during high CPU load.

USAGE: ./nosleep.sh >/dev/null & disown

NO LICENCE: Feel free to modify and distribute this script

REQUIREMENTS: bash, xautomation
