# gi2gian5-boo5hing-hun3lian7
語言模型訓練


### 三部份
A. 大文本-14个語料+車牌電話+陳先生200句+高老師文本
B. 台語詞、華語詞
C. 英語詞無含英語字母 (英語字母佇A的車牌內)

### 參數
主要的問題是`Line`kah`lai5`會相搶
A: 49%
B: 50％
C: 1%

這馬結果：
```
root@a74a09197806:/opt# cat bun1.arpa | grep '[0-9]\slai5\s\+-' | head
-2.378323       lai5    -0.03320438
-1.022014       ju2 lai5        -0.29603
-1.298097       lu2 lai5        -0.2726755
root@a74a09197806:/opt# cat bun1.arpa | grep Line
-3.255273       Line
```

