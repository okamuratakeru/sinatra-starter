# frozen_string_literal: true

# メモデータのCRUD操作を担当するモデル
class Memo
  class << self
    attr_accessor :db
  end

  # 全メモを配列で返す
  def self.all
    db.exec_params('SELECT id, title FROM memos ORDER BY created_at DESC').to_a
  end

  # IDで1件取得
  def self.find(id)
    db.exec_params('SELECT * FROM memos WHERE id = $1 LIMIT 1', [id]).first
  end

  # メモを追加
  def self.create(title, description)
    db.exec_params(
      'INSERT INTO memos (title, description) VALUES ($1, $2) RETURNING id',
      [title, description]
    ).first
  end

  # IDのメモを削除
  def self.destroy(id)
    db.exec_params('DELETE FROM memos WHERE id = $1', [id])
  end

  # IDのメモを更新
  def self.update(id, title, description)
    db.exec_params(
      'UPDATE memos SET title = $1, description = $2, updated_at = NOW() WHERE id = $3',
      [title, description, id]
    )
  end

  # タイトルが空でないか検証
  def self.valid?(title)
    !title.nil? && !title.strip.empty?
  end
end
