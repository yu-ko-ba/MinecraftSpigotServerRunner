#!/bin/bash

# 引数を解析する
version="1.16.5"
xms="-Xms2G"
xmx="-Xmx2G"
nogui=""

version_flag=false
for i in $*; do
    # バージョンが指定されていたら取得する
    if ${version_flag}; then
        version_flag=false

        version=${i}
        continue
    fi
    if [ ${i} = "-version" ]; then
        version_flag=true
        continue
    fi

    # メモリサイズの最小値が指定されていたら取得する
    if [ ${i:0:4} = "-Xms" ]; then
        xms=${i}
        continue
    fi

    # メモリサイズの最大値が指定されていたら取得する
    if [ ${i:0:4} = "-Xmx" ]; then
        xmx=${i}
        continue
    fi

    # noguiが指定されていたら取得する
    if [ ${i} = "nogui" ]; then
        nogui="nogui"
        continue
    fi
done

# このシェルスクリプトが置いてあるディレクトリに移動する
if [ ${0:0:1} = "/" ]; then
    # 絶対パスで実行されている場合
    cd $(dirname "${0}")
else
    # 相対パスで実行されている場合
    cd $(dirname "$(pwd)/${0}")
fi

# サーバーを起動する
java -Xms2G -Xmx2G -jar "spigot-${version}.jar" ${nogui}