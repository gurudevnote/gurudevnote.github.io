---
layout: post
title: Linux commands and bash script for developer
tags: ["linux","command","sed", "jq","grep","bash","curl","awk","xargs","developer","ubuntu"]
---

# Linux commands

## man

## ls

## sort

## less

## more

## tail

## egrep

## grep

## sed
- extract regex group data
```bash
echo "sonar.projectKey=adadfawefaowiejaowejo" | sed -nr "s/sonar.projectKey\s*=\s*(.+)$/\1/p"
```
## awk

## xargs

## jq

## vi

## curl

- post json data
```bash 
curl -sd -X POST '{
  "test": "event"
}'   -H "Content-Type: application/json"   https://eo72gtowgc1gvke.m.pipedream.net | jq
```

- get json data 
```bash
curl -s -X GET "https://httpbin.org/anything" -H "accept: application/json" | jq 
```

- spec user-agent
```bash
curl -s -X GET "https://httpbin.org/anything" -H "accept: application/json"  -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0" | jq
```
## git

## gnome-terminal

- Execute a command in new terminal tab

```bash
gnome-terminal --tab --command="bash -c 'ls ; $SHELL'"
gnome-terminal --tab --command="bash -c 'll ; $SHELL'"
```

# Create alias command

# Bash script

## variable

## loop

## condition

## How To Assign Output of a Linux Command to a Variable

```bash
variable_name=$(ls)
variable_name=$(ls -a)
#use backtick operator
FILES=`sudo find . -type f -print | wc -l`
```

## Out put to file (see more [https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file](https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file))
```
          | visible in terminal |   visible in file   | existing
          |---------------------|---------------------|-------------
  Syntax  |  StdOut  |  StdErr  |  StdOut  |  StdErr  |   file   
--------------------------------------------------------------------
    >     |    no    |   yes    |   yes    |    no    | overwrite
    >>    |    no    |   yes    |   yes    |    no    |  append
          |          |          |          |          |
   2>     |   yes    |    no    |    no    |   yes    | overwrite
   2>>    |   yes    |    no    |    no    |   yes    |  append
          |          |          |          |          |
   &>     |    no    |    no    |   yes    |   yes    | overwrite
   &>>    |    no    |    no    |   yes    |   yes    |  append
          |          |          |          |          |
 | tee    |   yes    |   yes    |   yes    |    no    | overwrite
 | tee -a |   yes    |   yes    |   yes    |    no    |  append
          |          |          |          |          |
 n.e. (*) |   yes    |   yes    |    no    |   yes    | overwrite
 n.e. (*) |   yes    |   yes    |    no    |   yes    |  append
          |          |          |          |          |
|& tee    |   yes    |   yes    |   yes    |   yes    | overwrite
|& tee -a |   yes    |   yes    |   yes    |   yes    |  append
```


# An example to build sonarqube server and use sonarqube scanner to analytic source code

# References

- Sed regex capturing: [https://code-examples.net/en/q/120477e](https://code-examples.net/en/q/120477e)
- Unix / Linux tutorial: [https://www.tutorialspoint.com/unix/index.htm](https://www.tutorialspoint.com/unix/index.htm)
- Unix / Linux - Regular Expressions with SED [https://www.tutorialspoint.com/unix/unix-regular-expressions.htm](https://www.tutorialspoint.com/unix/unix-regular-expressions.htm)
- Bash scripting: Moving from backtick operator to $ parentheses [https://www.redhat.com/sysadmin/backtick-operator-vs-parens](https://www.redhat.com/sysadmin/backtick-operator-vs-parens)
- How do I save terminal output to a file? [https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file](https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file)