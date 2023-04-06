# PROJECT dhcp_scan

For years, looking at the *dhcpd.leases* file was my first and only
resource for debugging DHCP server issues.  The problem is that the
*dhcpd.leases* file does not include IP addresses where hosts are
assigned fixed addresses in the *dhcpd.conf* host declarations.

A more complete accounting of a server's inventory of IP addresses
can be found in a report from the *journalctl* tool.

This project compiles the information provided by *journalctl* to
make a list of addresses assigned by the server, including both the
dynamic and the static IP addresses.


## REFERENCES

The *Dynamic Host Configuration Protocol* (DHCP) interactions are
specified in [rfc2131][rfc2131].


[rfc2131]:   "https://www.ietf.org/rfc/rfc2131.txt"  "Dynamic Host Configuration Protocol"