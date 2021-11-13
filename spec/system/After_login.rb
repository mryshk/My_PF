# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン後のテスト' do
  let(:listener) { create(:listener, listener_type:0) }
  let!(:other_listener) { create(:listener, listener_type:0) }
  let!(:post) { create(:post, listener: listener) }
  let!(:other_post) { create(:post, listener: other_listener) }

  before do
    visit new_listener_session_path
    fill_in 'session_email', with: listener.email
    fill_in 'session_password', with: listener.password
    fill_in 'session_password_confirmation', with: listener.password
    click_button 'LogIn'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }
      it 'New Postを押すと、投稿フォーム画面に遷移する' do
        new_post_link = find_all('a')[3].native.inner_text
        new_post_link = new_post_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link new_post_link
        is_expected.to eq '/posts/new'
      end
      it 'Home Postを押すと、投稿タイムライン画面に遷移する' do
        home_post_link = find_all('a')[4].native.inner_text
        home_post_link = home_post_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_post_link
        is_expected.to eq '/home_post'
      end
      it 'Home Albumを押すと、アルバムタイムライン画面に遷移する' do
        home_album_link = find_all('a')[5].native.inner_text
        home_album_link = home_album_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_album_link
        is_expected.to eq '/home_album'
      end
      it 'Mypageを押すと、自分の詳細画面に遷移する' do
        listener_link = find_all('a')[6].native.inner_text
        listener_link = listener_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link listener_link
        is_expected.to eq '/listeners/' + listener.id.to_s
      end
      it 'Notificationsを押すと、通知一覧画面に遷移する' do
        notifiation_link = find_all('a')[7].native.inner_text
        notifiation_link = notifiation_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link notifiation_link
        is_expected.to eq '/notifications'
      end
    end
  end

  describe 'ホーム画面のテスト' do
    before do
      visit home_post_path
    end
    context 'タイムライン表示画面の確認' do
      it 'URLの表示の確認'do
        expect(current_path).to eq "/home_post"
      end
      it '自分と他人の投稿のリンク先が正しい' do
        expect(page).to have_link'', href: listener_path(post.listener)
        expect(page).to have_link'', href: listener_path(other_post.listener)
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい'do
        expect(page).to have_link '', href: post_path(post)
        expect(page).to have_link '', href: post_path(other_post)
      end
      it '自分の投稿が表示される'do
        expect(page).to have_content post.post_tweet
      end
    end

    context '左メニューバーの表示確認'do
      it '投稿ジャンル検索が表示されているか'do
        expect(page).to have_content 'Post Category'
      end
    end
  end

  describe '投稿一覧画面のテスト'do
    before do
      visit posts_path
    end
    context '表示画面の確認' do
      it 'URLの表示の確認'do
        expect(current_path).to eq '/posts'
      end
      it '自分と他人の投稿のリンク先が正しい' do
        expect(page).to have_link'', href: listener_path(post.listener)
        expect(page).to have_link'', href: listener_path(other_post.listener)
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい'do
        expect(page).to have_link '', href: post_path(post)
        expect(page).to have_link '', href: post_path(other_post)
      end
      it '自分の投稿が表示される'do
        expect(page).to have_content post.post_tweet
        expect(page).to have_content other_post.post_tweet
      end
    end
  end

  describe '投稿詳細画面のテスト'do
    before do
      visit post_path(post)
    end
    context '表示画面の確認' do
      it 'URLの表示の確認'do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
      it '「detail」と表示される' do
        expect(page).to have_content 'Post Detail'
      end
      it 'リスナー画像・名前のリンク先が正しい' do
        expect(page).to have_link '', href: listener_path(post.listener)
      end
      it '投稿のtitleが表示される' do
        expect(page).to have_content post.post_tweet
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link 'Edit', href: edit_post_path(post)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link 'Delete', href: post_path(post)
      end
    end
  end
  describe '投稿登録画面のテスト'do
    before do
      visit new_post_path
    end
    context '表示画面の確認' do
      it 'URLの表示の確認' do
        expect(current_path).to eq('/posts/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button 'Post'
      end
    end
    context '投稿処理のテスト'do
      it '投稿後の遷移先は正しいか' do
        fill_in 'post[post_tweet]', with: Faker::Lorem.characters(number: 30)
        fill_in 'post[post_url]', with: Faker::Lorem.characters(number: 20)
        click_button 'Post'
        expect(page).to have_current_path home_post_path
      end
    end
  end


  describe '投稿編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it '「Edit Post」と表示される' do
        expect(page).to have_content 'Edit Post'
      end
      it 'post_tweet編集フォームが表示される' do
        expect(page).to have_field 'post[post_tweet]', with: post.post_tweet
      end
      it 'post_url編集フォームが表示される' do
        expect(page).to have_field 'post[post_url]', with: post.post_url
      end
      it 'Updateボタンが表示される' do
        expect(page).to have_button 'Update'
      end
    end

    context '編集成功のテスト' do
      before do
        @post_old_post_tweet = post.post_tweet
        @post_old_post_url = post.post_url
        fill_in 'post[post_tweet]', with: Faker::Lorem.characters(number: 20)
        fill_in 'post[post_url]', with: Faker::Lorem.characters(number: 20)
        click_button 'Update'
      end

      it 'tweetが正しく更新される' do
        expect(post.reload.post_tweet).not_to eq @post_old_post_tweet
      end
      it 'urlが正しく更新される' do
        expect(post.reload.post_url).not_to eq @post_old_post_url
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/posts/' + post.id.to_s
        expect(page).to have_content 'Detail'
      end
    end
  end

  describe '自分のマイページのテスト' do
    before do
      visit listener_path(listener)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/listeners/' + listener.id.to_s
      end
      it 'マイページに自分の名前が表示される' do
        expect(page).to have_content listener.name
      end
      it 'マイページに自分の投稿一覧が表示される' do
        expect(page).to have_content post.post_tweet
      end
      it '他人の詳細は表示されない' do
        expect(page).not_to have_link '', href: listener_path(other_listener)
        expect(page).not_to have_content other_post.post_tweet
      end
    end
  end
end