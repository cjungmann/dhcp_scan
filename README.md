# PROJECT dhcp_scan

A console-based utility for parsing `journalctl` output to make a
report of dhcp-server address leases.

Arguably the most useful part of this project does not belong on this
installation and usage page.  Writing and managing regular expressions can
be complicatedd and error-prone, but my [Crafting Regular Expression for Bash][re_craft]
make success much easier to achieve.

## PREREQUISITES

Besides requiring **Bash** for its `array`, `associative array`, and
`nameref variable` features, this utility also uses **journalctl** to
generate the raw data that `dhcp_scan` parses to create the report.

## DOWNLOADING

~~~
git clone https://www.github.com/cjungmann/dhcp_scan.git
~~~

## USAGE

This utility parses `journalctl` output.  The `journalctl` in the
following examples selects a range of messages with the `-S today`
option, meaning _since today_, and `-u isc-dhcp-server` to set a filter
to include only dhcp-server messages.

`dhcp_scan` can read the dhcp-server log entries piped from
`journalctl` through `stdin` or from a file created from `journalctl`
with the `-i filename` option.  The following examples demonstrate
these two methods:

~~~
# through stdin
sudo journalctl -S today -u isc-dhcp-server | ./dhcp_scan

# two-step process using -i
sudo journalctl -S today -u isc-dhcp-server > dhcpd.log
./dhcp_scan -i dhcpd.log
~~~

There is a [`man page`][manpage] for further explanation.  The `groff`
version of the manpage will be appropriately installed if you choose
to install this utility.

## INSTALLATION

This utility can be installed using `sudo make install`.  Installation
will put a symlink of the main script, `dhcp_scan` in a `bin` directory,
and will install the man page in the appropriate directory.

Calling `sudo make uninstall` will remove both the symlink and the
installed man page.


## Motivation

In an effort to limit my kid's screen time with `iptables` rules,
I needed to figure out why the dhcp-server was not honoring host
declarations that assigned specific IP addresses to known MAC addresses.

I had always referred to the `dhcpd.leases` file for this kind of
information. Unfortunately, it does not record addresses assigned
by a `fixed-address` declaration in a host declaration containing a
`hardware` declaration to identify the host.

I found that the `journalctl` utility provided a more complete
accounting of dhcp-server activity, but scanning the output was like
drinking from a firehose.  A perfect excuse to try some new Bash
ideas.

By-the-way, it turns out I'm being thwarted by randomized MAC
addresses that newer devices use to prevent tracking.  This utility
revealed that some devices get several different IP addresses
during a given day.

## EXECUTION

### Sample Log File

There is a short sample log file that was used for testing,
`dhcpd_demo.log`.  Use this file for input to see how the utility works:

~~~
$ ./dhcp_scan -i dhcpd_demo.log
~~~

## INSTALLATION

Despite not being a buildable project, this project includes a `Makefile`
that handles installing and uninstalling the project.  The `Makefile`
includes a `help` target that gives further instructions.  Simply enter:

~~~
make help
~~~

The installation installs a link to rather than a copy of the script.
This is so the Bash can find the absolute path to the script in order to
find the additional script modules installed in the same directory.




## REFERENCES

The *Dynamic Host Configuration Protocol* (DHCP) interactions are
specified in [rfc2131][rfc2131].


[rfc2131]:     "https://www.ietf.org/rfc/rfc2131.txt"  "Dynamic Host Configuration Protocol"
[manpage]:     dhcp_scan.html
[re_craft]:    RE_CRAFT.md