#!/bin/bash
set -e

# DB作成＋マイグレーション
bundle exec rails db:prepare 

# 最後にCMDで指定されたコマンドを実行
exec "$@"