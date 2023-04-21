# BASH NAMEREFS FOR RETURNING VALUES

Nameref variables are a very useful feature of Bash scripting.  A
nameref works like an  alias to another variable.  This ability opens
some interesting possiblities.

## DECLARING A NAMEREF VARIABLE

The `-n` option of the `declare` or `local` command makes a
nameref variable:

~~~sh
declare -i myint
declare -n myref="myint"

myref=1
echo "myint is $myint"
~~~

## RETRIEVING BASH RETURN VALUES

### TRADITIONAL BASH METHOD OF RETURNING VALUES

The traditional way to capture a return value is for the caller to
create a subprocess for the function to capture what the function
emits via `stdout`:

~~~
consider_evidence()
{
   local conclusion="none"

   # calculate conclusion from the evidence
   local exit_code="$?"
   if [ "$exit_code" -eq 0 ]; then
      @echo "$conclusion"
   fi
   return "$exit_code"
}

declare charges=$( consider_evidence "$who" "$what" "$where" "$when" )
if [ "$?" -eq 0 ]; then
   echo "Charges are '$charges'"
fi
~~~

### RETURN VALUES TO NAMEREF VARIABLES

The traditional method of 
When a function writes a value to a nameref variable, the calling
process does not need to create a subprocess to retrieve the
value.
Using a nameref variable, the called function can put the return
value directly into a variable in the caller's scope.  Besides being about
10 times faster than using a subprocess, using namerefs enables
returning complex and multiple values.

~~~
consider_evidence()
{
   local -n ce_conclusion="$1"
   ce_conclusion="none"

   # calculate conclusion from the evidence
   # allow exit code from calculation fall through as exit code
}

declare conclusion
if consider_evidence "conclusion" "$who" "$what" "$where" "$when"; then
   echo "Charges are '$charges'"
fi
~~~




