# nosleep
Linux bash script suspend timing

This is a simple script that you can put into your Linux startup script.
It works with ACPI enabled, suspend time configured, measures CPU usage
and simulates a human input to prevent system suspend during high CPU load
(e.g. watching a video, downloading etc.).

Some PCs have broken ACPI implementation and suspend (if configured) 
occurs under Linux when no user input is detected after a set time.

USAGE: ./nosleep.sh >/dev/null & disown

NO LICENCE: Feel free to modify and distribute this script

REQUIREMENTS: bash, xautomation
