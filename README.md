# sinatra-starter

Sinatra で作ったシンプルなメモアプリです。メモの追加・表示・編集・削除ができます。

## 必要な環境

- Ruby 3.x 以上
- Bundler
- PostgreSQL 14 以上

## セットアップ & 起動手順

### 1. リポジトリをクローン

```bash
git clone https://github.com/okamuratakeru/sinatra-starter.git
cd sinatra-starter
```

### 2. gem をインストール

```bash
bundle install
```

### 3. データベースを作成

```bash
createdb memo_app
```

### 4. マイグレーションを実行

```bash
psql -d memo_app -f db/migrations/20260520_001_create_memos.up.sql
```

### 5. サーバーを起動

```bash
bundle exec rackup
```

ブラウザで [http://localhost:9292](http://localhost:9292) を開く。

## 環境変数

デフォルト値のままで動作しますが、必要に応じて変更してください。

| 変数名    | デフォルト値 | 説明                   |
|-----------|-------------|------------------------|
| `DB_HOST` | `localhost` | PostgreSQL のホスト名  |
| `DB_NAME` | `memo_app`  | データベース名         |
| `DB_USER` | ログインユーザー | PostgreSQL のユーザー名 |

## 機能・URL 一覧

| メソッド | URL              | 処理           |
|----------|------------------|----------------|
| GET      | /                | メモ一覧       |
| GET      | /memos/new       | 新規作成フォーム |
| POST     | /memos           | メモ作成       |
| GET      | /memos/:id       | メモ詳細       |
| GET      | /memos/:id/edit  | 編集フォーム   |
| PATCH    | /memos/:id       | メモ更新       |
| DELETE   | /memos/:id       | メモ削除       |

## データベース構造

| カラム名    | 型           | 説明                   |
|-------------|--------------|------------------------|
| id          | UUID         | 主キー（自動生成）     |
| title       | VARCHAR(200) | タイトル（必須）       |
| description | TEXT         | 本文                   |
| created_at  | TIMESTAMPTZ  | 作成日時               |
| updated_at  | TIMESTAMPTZ  | 更新日時               |

## ディレクトリ構成

```
sinatra-starter/
├── app.rb                  # ルーティング
├── config/
│   └── database.rb         # DB 接続設定
├── db/
│   └── migrations/
│       ├── 20260520_001_create_memos.up.sql
│       └── 20260520_001_create_memos.down.sql
├── models/
│   └── memo.rb             # メモモデル
├── public/
│   └── css/
│       └── style.css
└── views/
    ├── layout.erb
    ├── 404.erb
    └── memos/
        ├── index.erb
        ├── new.erb
        ├── show.erb
        └── edit.erb
```
