# frozen_string_literal: true

require 'json'

# メモデータのCRUD操作を担当するモデル
class Memo
  DATA_PATH = './data/memos.json'

  # 全メモを配列で返す
  def self.all
    JSON.parse(File.read(DATA_PATH))
  end

  # IDで1件取得
  def self.find(id)
    all.find { |memo| memo['id'] == id.to_i }
  end

  # メモを追加
  def self.create(title, description)
    memos = all
    new_id = memos.empty? ? 1 : memos.last['id'] + 1
    memos << { 'id' => new_id, 'title' => title, 'description' => description }
    save(memos)
  end

  # IDのメモを削除
  def self.destroy(id)
    memos = all.reject { |memo| memo['id'] == id.to_i }
    save(memos)
  end

  # IDのメモを更新
  def self.update(id, title, description)
    memos = all
    memo = memos.find { |m| m['id'] == id.to_i }
    memo['title'] = title
    memo['description'] = description
    save(memos)
  end

  # タイトルが空でないか検証
  def self.valid?(title)
    !title.nil? && !title.strip.empty?
  end

  # JSONファイルに書き込む
  def self.save(memos)
    File.write(DATA_PATH, JSON.pretty_generate(memos))
  end
  private_class_method :save
end
