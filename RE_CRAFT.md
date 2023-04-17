# CRAFTING REGULAR EXPRESSIONS FOR BASH

I use some Bash coding techniques that I haven't seen used
elsewhere, so some might find value in considering them.

The ideas revolve around the use of *regular expressions*, but the
handling of the **BASH_REMATCH** array can be applied to array
handling in other domains.

## Creating Regular Expressions

There is some truth to the assertion that regular expressions are
write-only code.  With character classes, quantifiers, wildcards,
and nexted parentheses, further complicated by having to

### Many Characters with Several Meanings

All characters can match the same character in text,
its literal meaning, many have other meanings as well.  For example,
the '(' character may also introduce an expression group, and may
also introduce subshell in Bash.
while some may also 

with characters that can have three meanings (literal, regex, or
Bash), and add wildcard, class, group, and quantifier characters, an
expression can be pretty dense.

Here is a relatively simple regular expression that identifies parts
of an email address:

~~~
declare re_email=^\([^@]+\)@\(\(\(.*\)\\.\)?\([^.]+\.[^.]+\)\)$
~~~

The Bash test, `[[ string =~ regex ]]` applies a regular expression,
*regex* to value *string*.  If the match is successful, parentheses-enclosed
matches can be accessed through the **BASH_REMATCH** array.

It may not be obvious that the *email name* is at ${BASH_REMATCH[1]},
the *subdomain*, if present, is at ${BASH_REMATCH[4]}, and the
*domain* is at ${BASH_REMATCH[5]}.


