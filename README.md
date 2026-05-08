# sinatra-starter

Sinatra で作ったシンプルなメモアプリです。メモの追加・表示・編集・削除ができます。

## 必要な環境

- Ruby 3.x 以上
- Bundler

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

### 3. データファイルを作成

```bash
echo "[]" > data/memos.json
```

### 4. サーバーを起動

```bash
bundle exec rackup
```

ブラウザで [http://localhost:9292](http://localhost:9292) を開く。

