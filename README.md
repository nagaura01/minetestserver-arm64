**(Please use Translation Tools to translate into your language! :-)**

# minetestserver-arm64
ARM64環境で動くminetestサーバ
Raspberry Piなどでも手軽にminetestのサーバを動かしたかったので、Dockerコンテナ化して作ってみました。

** このリポジトリは現在改良中です。不具合等がある場合があります！ **

# 使い方
(少し手順が多く、面倒くさいです...。)

1. ``` git clone https://github.com/nagaura01/minetestserver-arm64.git ```
2. ``` cd minetestserver-arm64/``` 
3. ```mkdir conf mods worlds ```
4. ./conf/ の中に minetest.conf を作成する (```nano /conf/minetest.conf```)
5. minetest.conf の中に```name = [Adminのユーザ名]```を入力する (その他のconfigはお好みで)
6. ``` docker-compose up -d ```
7. できあがり

# modの入れ方
->現在改良中...

# 今後改良する予定のもの
- libpqを一緒にビルドしてあるので、ワールドなどのデータをPostgreSQLに入れられるようにする(速度、信頼性の向上)
