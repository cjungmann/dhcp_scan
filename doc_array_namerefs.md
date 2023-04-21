# USE NAMEREFS ACCESS ARRAY ELEMENTS

Nameref variables are a very useful feature of Bash versions
4.3 and later.  I use them all the time for returning values from
functions in order to avoid creating subprocesses.  In my opinion,
this is the most powerful use of namerefs.

A close second, however, is using a nameref as an alias to array
elements, which are otherwise nameless.  It's much easier to write
code that refers to `"${email_name}"` than `"${BASH_REMATCH[2]}"`