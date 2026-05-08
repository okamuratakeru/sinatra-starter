# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require_relative 'models/memo'

# # メモアプリのルーティングとリクエスト処理を担当する
class MemoApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :erb, escape_html: true
  set :method_override, true

  # セッションCookie設定
  use Rack::Session::Cookie,
      key: 'rack.session',
      secret: SecureRandom.hex(32), # 署名用シークレット
      httponly: true,    # JavaScriptからCookieを読めなくする
      same_site: :strict # 他サイトからのリクエストでCookieを送らない

  # 全リクエストにセキュリティヘッダーを付与
  before do
    headers['Content-Security-Policy'] = "default-src 'self'" # スクリプト等の読み込みを自サイトのみに制限
    headers['X-Content-Type-Options']  = 'nosniff'            # MIMEタイプの推測を禁止
    headers['X-Frame-Options']         = 'DENY'               # iframe埋め込みを禁止（クリックジャッキング対策）
  end

  get '/' do
    @memos = Memo.all
    erb :'memos/index'
  end

  # 追加画面
  get '/memos/new' do
    erb :'memos/new'
  end

  # 追加処理
  post '/memos' do
    if Memo.valid?(params[:title])
      Memo.create(params[:title], params[:description])
      redirect '/'
    else
      @error = 'タイトルを入力してください'
      erb :'memos/new'
    end
  end

  # 詳細画面
  get '/memos/:id' do
    @memo = Memo.find(params[:id])
    halt 404 unless @memo
    erb :'memos/show'
  end

  # 削除処理
  delete '/memos/:id' do
    halt 404 unless Memo.find(params[:id])
    Memo.destroy(params[:id])
    redirect '/'
  end

  # 編集画面
  get '/memos/:id/edit' do
    @memo = Memo.find(params[:id])
    halt 404 unless @memo
    erb :'memos/edit'
  end

  # 更新処理
  patch '/memos/:id' do
    @memo = Memo.find(params[:id])
    halt 404 unless @memo
    if Memo.valid?(params[:title])
      Memo.update(params[:id], params[:title], params[:description])
      redirect '/'
    else
      @error = 'タイトルを入力してください'
      erb :'memos/edit'
    end
  end

  # 存在しないURLへのアクセス
  not_found do
    erb :'404'
  end
end
