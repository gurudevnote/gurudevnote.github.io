---
layout: post
title: Linux commands and bash script for developer
tags: ["linux","command","sed", "jq","grep","bash","curl","awk","xargs","developer","ubuntu"]
---

# Linux commands

## man

## bash
- ~/.bash_profile and ~/.bashrc

- shortcut command

```bash
alias c='clear'
alias d='git diff'
alias s='git status'
alias dd='git difftool -d'

```

## alias

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

```bash

awk '($3 == "Jonh") {print}' names.txt
awk '($5 < 1945) {print $2}' names.txt
#sum column 5
awk '{total += $5} END {print total/NR}' names.txt
#use field separator
awk -F ','  '{print $1}' test.csv
echo "1: " | awk -F  ":" '/1/ {print $1}'
echo "1: " | awk 'BEGIN { FS=":" } /1/ { print $1 }'
echo "1, " | awk -F ','  '{print $1}'
#use regular expression for field separator
echo "foo 10 bar 15 aaa 99 aaw 88 55" | awk -F'\\s*[0-9]+\\s*' '{print $2}'
```

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

- Specify ssh private key when clone git

```bash
git -c core.sshCommand="ssh -i ~/.ssh/your_private_key" clone git@github.com:your_account_name/your_repo.git
```

- Setup repo to use ssh-key

```bash
git config core.sshCommand 'ssh -i ~/.ssh/your_private_key'
```

- Git config global: git config --global -e

```bash
[user]
     name = Your name
     email = youremail@example.com
[alias]
    lga = log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%b%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d$' --all
    lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%b%C(re$'
    lg3 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)''          %C(white)%s%b%C(rese$'
    lg = !"git lga"
    lgo = log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%b%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d$'
[diff]
    tool = meld
[diff "word"]
  textconv = pandoc
  binary = true
[diff "odt"]
  textconv = pandoc
  binary = true
[push]
    default = simple
[difftool]
  prompt = false
[difftool.phpstorm]
	cmd = ~/tools/PhpStorm-222.3345.135/bin/phpstorm.sh diff $(cd $(dirname "$LOCAL") && pwd)/$(basename "$LOCAL") $(cd $(dirname "$REMOTE") && pwd)/$(basename "$REMOTE")
	trustExitCode = true
[mergetool.phpstorm]
	cmd = ~/tools/PhpStorm-222.3345.135/bin/phpstorm.sh merge $(cd $(dirname "$LOCAL") && pwd)/$(basename "$LOCAL") $(cd $(dirname "$REMOTE") && pwd)/$(basename "$REMOTE") $(cd $(dirname "$BASE") && pwd)/$(basename "$BASE") $(cd $(dirname "$MERGED") && pwd)/$(basename "$MERGED")
	trustExitCode = true

```

Then use git command like that:

```bash
git difftool HEAD HEAD~3 -d
git difftool -t meld -d master v2/master  -- *.vue --*.js -- *.ts
git lgo
git lgo --no-merges
git lgo --no-merges --author=Jonh
```

## gnome-terminal

- Execute a command in new terminal tab

```bash
gnome-terminal --tab --command="bash -c 'ls ; $SHELL'"
gnome-terminal --tab --command="bash -c 'll ; $SHELL'"
```

## pygmentize

- High light your code

```bash
pygmentize -g ./config/deploy.rb
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

- Grep cheat sheet: [https://quickref.me/grep](https://quickref.me/grep) 
- Sed cheat sheet: [https://quickref.me/sed](https://quickref.me/sed)
- Awk cheat sheet: [https://quickref.me/awk](https://quickref.me/awk)
- Linux Command Line Basic Commands: [https://snipcademy.com/linux-command-line-basic-commands](https://snipcademy.com/linux-command-line-basic-commands)
- Bash alias: [https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html](https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html)
- Sed regex capturing: [https://code-examples.net/en/q/120477e](https://code-examples.net/en/q/120477e)
- Unix / Linux tutorial: [https://www.tutorialspoint.com/unix/index.htm](https://www.tutorialspoint.com/unix/index.htm)
- Unix / Linux - Regular Expressions with SED [https://www.tutorialspoint.com/unix/unix-regular-expressions.htm](https://www.tutorialspoint.com/unix/unix-regular-expressions.htm)
- Bash scripting: Moving from backtick operator to $ parentheses [https://www.redhat.com/sysadmin/backtick-operator-vs-parens](https://www.redhat.com/sysadmin/backtick-operator-vs-parens)
- How do I save terminal output to a file? [https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file](https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file)