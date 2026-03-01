#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==================================="
echo "  dotfiles セットアップスクリプト"
echo "==================================="
echo ""
echo "dotfiles ディレクトリ: $DOTFILES_DIR"
echo ""

# バックアップディレクトリの作成
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# ファイルまたはディレクトリのバックアップ
backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        if [ ! -d "$BACKUP_DIR" ]; then
            mkdir -p "$BACKUP_DIR"
            echo "バックアップディレクトリを作成: $BACKUP_DIR"
        fi
        echo "  バックアップ: $target → $BACKUP_DIR/"
        mv "$target" "$BACKUP_DIR/"
    elif [ -L "$target" ]; then
        echo "  既存のシンボリックリンクを削除: $target"
        rm "$target"
    fi
}

# シンボリックリンクを作成
create_symlink() {
    local source="$1"
    local target="$2"

    backup_if_exists "$target"

    # ターゲットのディレクトリが存在しない場合は作成
    local target_dir="$(dirname "$target")"
    if [ ! -d "$target_dir" ]; then
        echo "  ディレクトリを作成: $target_dir"
        mkdir -p "$target_dir"
    fi

    echo "  シンボリックリンク作成: $target → $source"
    ln -sf "$source" "$target"
}

echo "[1/5] 旧 tmux 設定のクリーンアップ"
if [ -e "$HOME/.tmux.conf" ] || [ -L "$HOME/.tmux.conf" ]; then
    echo "  旧 ~/.tmux.conf を削除（XDG パスより優先されるため）"
    rm -f "$HOME/.tmux.conf"
fi
echo ""

echo "[2/5] tmux 設定のセットアップ"
create_symlink "$DOTFILES_DIR/tmux" "$HOME/.config/tmux"
echo ""

echo "[3/5] Neovim 設定のセットアップ"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
echo ""

echo "[4/5] bin/work スクリプトのセットアップ"
create_symlink "$DOTFILES_DIR/bin/work" "$HOME/bin/work"
chmod +x "$DOTFILES_DIR/bin/work"
echo "  実行権限を付与: bin/work"
echo ""

echo "[5/5] bin/wt スクリプトのセットアップ"
create_symlink "$DOTFILES_DIR/bin/wt" "$HOME/bin/wt"
chmod +x "$DOTFILES_DIR/bin/wt"
echo "  実行権限を付与: bin/wt"
echo ""

echo "==================================="
echo "  セットアップ完了！"
echo "==================================="
echo ""

# PATHの確認
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo "⚠️  注意: ~/bin が PATH に含まれていません"
    echo ""
    echo "以下のコマンドを実行して PATH に追加してください："
    echo ""
    if [ -n "$ZSH_VERSION" ]; then
        echo "  echo 'export PATH=\"\$HOME/bin:\$PATH\"' >> ~/.zshrc"
        echo "  source ~/.zshrc"
    else
        echo "  echo 'export PATH=\"\$HOME/bin:\$PATH\"' >> ~/.bashrc"
        echo "  source ~/.bashrc"
    fi
    echo ""
fi

if [ -d "$BACKUP_DIR" ]; then
    echo "既存ファイルのバックアップ: $BACKUP_DIR"
    echo ""
fi

echo "次のステップ："
echo "  1. tmux を再起動または 'tmux source ~/.config/tmux/tmux.conf' を実行"
echo "  2. tmux 内で prefix + I を押して TPM プラグインをインストール"
echo "  3. Neovim を起動してプラグインをインストール"
echo "  4. 'work' コマンドで開発環境を起動"
echo ""
