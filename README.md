# PROJECT dhcp_scan

A console-based utility for parsing **journalctl** output to make a
report of dhcp-server assigned IP addresses.

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

## USING dhcp_scan

Either pipe **journalctl** output into the **dhcp_scan** utility,
or create a file from **journalctl** and direct **dhcp_scan** to
read it.

~~~
$ sudo journalctl -S today -u isc-dhcp-server | dhcp_scan
~~~

or

~~~
$ sudo journalctl -S today -u isc-dhcp-server > dhcpd.log
$ dhcp_scan -i dhcpd.log
~~~


## REFERENCES

The *Dynamic Host Configuration Protocol* (DHCP) interactions are
specified in [rfc2131][rfc2131].


[rfc2131]:   "https://www.ietf.org/rfc/rfc2131.txt"  "Dynamic Host Configuration Protocol"