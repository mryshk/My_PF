# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:post) { create(:post, post_tweet:'hoge',post_url:'hoge',listener_id: FactoryBot.create(:listener).id ,picture_id: "hoge",impressions_count: 5,post_genre: 4 ) }

  describe 'トップ画面(top_path)のテスト' do
    before do
      visit home_path
    end
    context '表示の確認' do
      it 'ホーム画面(home_path)に「HOME」が表示されているか' do
        expect(page).to have_content 'HOME'
      end
      it 'top_pathが"/top"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe "投稿画面(new_post_path)のテスト" do
    before do
      visit new_post_path
    end
    context '表示の確認' do
      it 'new_post_pathが"/posts/new"であるか' do
        expect(current_path).to eq('/posts/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button 'Post'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post[post_tweet]', with: Faker::Lorem.characters(number:30)
        fill_in 'post[picture_id]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[post_url]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[listener_id]', with: FactoryBot.build(:listener).id
        fill_in 'post[post_genre]', with: Faker::Number.number
        fill_in 'post[impressions_count]', with: Faker::Number.number
        click_button 'Post'
        expect(page).to have_current_path home_path
      end
    end
  end




end