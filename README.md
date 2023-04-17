# PROJECT dhcp_scan

A console-based utility for parsing **journalctl** output to make a
report of dhcp-server address leases.

Arguably the most useful part of this project does not belong on this
installation and usage page.  Writing and managing regular expressions can
be complicatedd and error-prone, but my [Crafting Regular Expression for Bash][re_craft]
make success much easier to achieve.

## Motivation

In an effort to limit my kid's screen time with **iptables** rules,
I needed to figure out why the dhcp-server was not honoring host
declarations that assigned specific IP addresses to known MAC addresses.

I had always referred to the *dhcpd.leases* file for this kind of
information. Unfortunately, it does not record addresses assigned
by a **fixed-address** declaration in a host declaration containing a
**hardware** declaration to identify the host.

I found that the **journalctl** utility provided a more complete
accounting of dhcp-server activity, but scanning the output was like
drinking from a firehose.  A perfect excuse to try some new Bash
ideas.

By-the-way, it turns out I'm being thwarted by randomized MAC
addresses that newer devices use to prevent tracking.  This utility
revealed that some devices get several different IP addresses
during a given day.

## EXECUTION

Effective use of this tool requires some access to and some familiarity
with **journalctl**.  The examples show one useful invocation that
may be enough for most users.

Either pipe **journalctl** output into the **dhcp_scan** utility,
or create a file from **journalctl** and direct **dhcp_scan** to
read it.

~~~
$ sudo journalctl -S today -u isc-dhcp-server | ./dhcp_scan
~~~

or

~~~
$ sudo journalctl -S today -u isc-dhcp-server > dhcpd.log
$ ./dhcp_scan -i dhcpd.log
~~~

There is a [manpage][manpage] for further explanation.  The **groff**
version of the manpage will be appropriately installed if you choose
to install this utility.

### Sample Log File

There is a short sample log file that was used for testing,
**dhcpd_demo.log**.  Use this file for input to see how the utility works:

~~~
$ ./dhcp_scan -i dhcpd_demo.log
~~~

## INSTALLATION

Despite not being a buildable project, this project includes a *Makefile*
that handles installing and uninstalling the project.  The *Makefile*
includes a *help* target that gives further instructions.  Simply enter:

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