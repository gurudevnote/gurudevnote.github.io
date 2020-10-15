---
layout: post
title: Php m5d test performance
tags: ["bash","linux","php","md5"]
---
Run command to test

```bash
time php -r 'for($i = 0; $i < 20; $i ++) { $hash[] = md5("estetetetetetetetetetetewtawetaweaweawefrrythth123123123123123123123". $i);}; print_r($hash);'
```

The result like that
```text
Array
(
    [0] => 26ad05ee357f4692d1c3c0676b49a7a1
    [1] => 2c9745e385851465a70f5c9679519af5
    [2] => 1bfe85e70d15091b5167b7447fc25947
    [3] => 281d52695ebdb2cf82b30d216c587ff8
    [4] => e2abd968e127e6a262de97a04ee3f8ef
    [5] => 437409561e4aca31c1ce201081306fe3
    [6] => 754d03d4ad82e4860f0b92040926a761
    [7] => 447ad2054361e5534a1ca94d6a8393ec
    [8] => a3bd0c7ca83070e9b8cbd317a23a698a
    [9] => 31c04a9b341a84cb5664c5fc21771ee2
    [10] => 6246899448e8f5ea23a08d9a32362354
    [11] => 7581b58d56237195318f30ed679096d8
    [12] => e5f60cfaa5aef7d20bbe2278803e180e
    [13] => deaa20a146a88bcce62dbb791831eee8
    [14] => 11c04b601adf421ecbaea25140b498ac
    [15] => ede9117b08cd3d0458ba8944bd5eee0f
    [16] => 67bcc596e8d02e539d9b555dc5a0cbcc
    [17] => 79b4950633c3fab3cf76ad395cb685a5
    [18] => 95afc01b50c5621e39a4808ff72a0d99
    [19] => 8432b40229633e1192ff96f1a4d58fb6
)

real	0m0.023s
user	0m0.018s
sys	0m0.005s
```
