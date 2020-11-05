---
layout: post
title: Use function evaluate of document object get html element by using xpath
tags: ["javascript","browser","xpath"]
---
Write your code to query element by xpath selector

```javascript
    // $x() is not a JS standard -
    // this is only sugar syntax in chrome devtools
    // use document.evaluate()
    const featureArticle = document
        .evaluate(
            '//*[@id="mp-tfa"]',
            document,
            null,
            XPathResult.FIRST_ORDERED_NODE_TYPE,
            null
        )
        .singleNodeValue;

    console.log(featureArticle.textContent);
```

See more:
- [https://stackoverflow.com/questions/48448586/how-to-use-xpath-in-chrome-headlesspuppeteer-evaluate](https://stackoverflow.com/questions/48448586/how-to-use-xpath-in-chrome-headlesspuppeteer-evaluate)
- [https://gist.github.com/LeCoupa/8c305ec8c713aad07b14](https://gist.github.com/LeCoupa/8c305ec8c713aad07b14)
