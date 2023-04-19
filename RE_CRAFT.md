# CRAFTING REGULAR EXPRESSIONS FOR BASH

In many cases, using Bash's builtin regular expression (__regex__)
tool is more efficient than trying to use *grep*, *awk*, or *sed*,
especially when performing line-by-line processing.

Besides possibly more efficient execution, the ability to annotate a
regex in a script is another reason to prefer Bash to the other tools
for parsing text.


## THE REGULAR EXPRESSION CHALLENGE

There is some truth to the assertion that regular expressions are
write-only code.  A regex is a dense string consisting of mostly
punctuation characters.  Many characters in an expression are
escaped because they have two or three meanings, exacerbating
potential confusion.

Here is a relatively simple regex that extracts parts of an email
address:

~~~
declare re_email=^\([^@]+\)@\(\(\(.*\)\\.\)?\([^.]+\\.[^.]+\)\)$
~~~

There are several challenging features of the above regex:

1. There are five groups enclosed by parentheses.
2. The `.` period character is sometimes a wildcard (matching anything)
   and sometimes a literal (only matching a `.`).
3. A literal `.` is escaped unless in a character class expression.
4. The meta characters `(` and `)` must be escaped to prevent
   Bash from thinking they introduce a subprocess.

## BREAKING DOWN A REGULAR EXPRESSION

I use Bash arrays to break down regular expressions.  While a regular
expression array is not directly useful (it must be compressed before
use), it has many benefits that make authoring a regular expression
much easier.

### Benefits of Regular Expression Arrays

1. I can add comments to the right of regex elements to explain
   my intention in including the element.

2. I can indent characters, which is especially useful for matching
   the parenthesis pairs surrounding  _subpatterns_.

3. I can temporarily exclude elements of an expression by commenting
   them out with a `#` in front of the element.  This helps with
   the frequent trial-and-error process of perfecting the regex.

### Example of a Regular Expression Array

The following code fragment shows how the email regex is
constructed.  It is generously commented to show a variety of
comment types and to include multi-line comments.

~~~sh
declare -a regex_arr=(
   ^
   \(               # subpattern 1
                    # escape '(' to prevent Bash subprocess
      [^@]+
   \)               # end of subpattern 1
   @                # terminates subpattern 1
   \(               # subpattern 2 (ignored)
      \(            # optional subpattern 3 (includes subdomain)
         \(         # subpattern 4 (IS subdomain)
            .\*     # escape '*' to prevent filename substitution
         \)         # end of subpattern 4

         \\.        # 1. terminates subpattern 3 without being included
                    #    subpattern 4, the capture we want to use
                    # 2. double-backslash to prevent regex engine
                    #    wildcard interpretation (we want the match
                    #    a literal '.')

      \)?           # end of subpattern 3
      \(            # subpattern 5 (domain)
         [^.]+
         \\.
         [^.]+
      \)            # end of subpattern 5
   \)               # end of subpattern 2
   $
)

# Concatenate array into a working regex string
declare OIFS="$IFS"
declare IFS=''
declare regex_str="${regex_arr[*]}"
IFS="$OIFS"
unset OIFS
~~~

### Notes on Example

- **No quotations** I find it easier to type and read the elements
  without quotations.

- **Escaping Details** for an unquoted string
  - **single `\`** for characters that will be misinterpreted by Bash:
    - `(` would introduce a subprocess, `\(` introduces a subpattern.
    - `*` would be substituted by files in the directory, `\*` is a
      regex wildcard.
  - **double `\\`** for special characters (`.?*+{}|()[]\^$`) to be
    interpreted literally.  The double `\\` escapes the `\` so a `\`
    remains to escape the special character after Bash interpretation.
  - **triple `\\\`** to match literal character of a special character
    that is also Bash significant.  It's a combination of the single
    and double escapes above, for the same reasons.
    - `\\\*` matches a literal asterisk
    - `\\\(` matches a literal parenthesis

- **Concatenate to Regex String**  I like to manipulate `IFS` to
  concatenate strings.  The concatenated string will look different
  from the array elements because Bash will have already processed
  the escaped characters.

### Exercise

After writing the regex, I noticed that subpattern 2 seems unnecessary
because it does not have a quantifier.  Notice the beginning and end
of subpattern 2, and put a `#` in front of those lines (just the ones
with the`\(` and `\)`) to remove them from the concatenated string.

If you remove the subpattern 2 parentheses, be sure to renumber the
other subpatterns in their comments: the subpattern numbers are used
to access the matched text in those subpatterns.