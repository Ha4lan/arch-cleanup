#!/bin/bash

# Sudo権限を取得
echo "Sudo権限を取得しています..."
sudo -v

# 使用するAURヘルパーのリスト
AUR_HELPERS=("paru" "yay")

# 不要なパッケージを削除（pacman）
echo "pacmanの不要なパッケージを削除しています..."
if sudo pacman -Rns $(pacman -Qdtq) --noconfirm >/dev/null 2>&1; then
    echo "pacmanの不要なパッケージ削除に成功しました"
else
    echo "pacmanの不要なパッケージ削除に失敗しました"
fi

# AURヘルパーで不要なパッケージを削除
for helper in "${AUR_HELPERS[@]}"; do
    echo "$helperで不要なパッケージを削除しています..."
    if sudo $helper -Rns $(pacman -Qdtq) --noconfirm >/dev/null 2>&1; then
        echo "$helperの不要なパッケージ削除に成功しました"
    else
        echo "$helperの不要なパッケージ削除に失敗しました"
    fi
done

# キャッシュのクリーンアップ
echo "pacmanのキャッシュをクリーンアップしています..."
if sudo pacman -Sc --noconfirm >/dev/null 2>&1; then
    echo "pacmanのキャッシュ削除に成功しました"
else
    echo "pacmanのキャッシュ削除に失敗しました"
fi

for helper in "${AUR_HELPERS[@]}"; do
    echo "$helperのキャッシュをクリーンアップしています..."
    if sudo $helper -Sc --noconfirm >/dev/null 2>&1; then
        echo "$helperのキャッシュ削除に成功しました"
    else
        echo "$helperのキャッシュ削除に失敗しました"
    fi
done

# ユーザーレベルのキャッシュを削除
echo "ユーザーレベルのキャッシュを削除しています..."
if rm -rf ~/.cache/*; then
    echo "ユーザーレベルのキャッシュ削除に成功しました"
else
    echo "ユーザーレベルのキャッシュ削除に失敗しました"
fi

echo "クリーンアップ完了"

