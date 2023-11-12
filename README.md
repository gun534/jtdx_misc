# はじめに
このリポジトリはRaspberry Pi4にUbuntu Server 20.04を入れた後、JDTXを動かすようにするための環境構築のための補助ファイル群です。

# 使い方
RaspberryPi ImagerでmicroSDにUbuntu Sever 20.04を書き込んで起動。
コマンドラインでログインを行った後にネットワークに繋がる状態にしてからこのリポジトリをcloneします。

# 有線LAN設定例
有線LANを固定IPアドレスで設定する場合は、99_config.yamlの中に記述しているIPアドレスを割り当てたいアドレスに書き換えて/etc/netplan/に配置します。
配置した後、以下で設定を反映します。

```
sudo netplan apply
```

# JTDXインストール
jtdx_install.shに実行権限を付与します。

```
chown 705 jtdx_install.sh
```

その後、jtdx_install.shを実行します。

sudoも全部やるので、

```
./jtdx_install.sh [ユーザー名] [root パスワード]
```

とします。
