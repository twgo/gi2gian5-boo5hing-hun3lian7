from sys import argv, stdin
from 臺灣言語工具.辭典.型音辭典 import 型音辭典
from 臺灣言語工具.解析整理.拆文分析器 import 拆文分析器
from 臺灣言語工具.解析整理.座標揀集內組 import 座標揀集內組
from 臺灣言語工具.斷詞.拄好長度辭典揣詞 import 拄好長度辭典揣詞


def _main():
    辭典 = 型音辭典(6)
    with open(argv[1]) as sutian:
        for tsua in sutian.readlines():
            if not tsua.startswith('<'):
                辭典.加詞(拆文分析器.建立詞物件(tsua.rstrip()))
    for tsua in stdin.readlines():
        句物件 = (
            拆文分析器.建立句物件(tsua.rstrip())
            .揣詞(拄好長度辭典揣詞, 辭典)
            .揀(座標揀集內組)
        )
        print(句物件.看型('-', ' '))


if __name__ == '__main__':
    _main()
