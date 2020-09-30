---
layout: post
title: Find all lines in a file but the lines are not in another file
tags: ["bash","python"]
---
Thank [HelloGoodbye](https://stackoverflow.com/users/1070480/hellogoodbye) about your solution to find all line in a file that are not exist on another file

```bash
python -c '
import sys

lines_to_remove = set()
with open(sys.argv[2], "r") as f:
    for line in f.readlines():
        lines_to_remove.add(line.strip())

with open(sys.argv[1], "r") as f:
    for line in f.readlines():
        if line.strip() not in lines_to_remove:
            print(line.strip())
' in_the_file not_in_another_file
```

See more other solutions on the [stackoverflow](https://stackoverflow.com/questions/18204904/fast-way-of-finding-lines-in-one-file-that-are-not-in-another) 