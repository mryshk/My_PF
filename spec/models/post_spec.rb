# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end
  describe "バリデーションのテスト" do
    subject { post.valid? }

    let!(:listener) { create(:listener) }
    let!(:post) { build(:post,listener_id: listener.id) }

    context "post_tweetカラムの確認" do
      it "空欄でないこと" do
        post.post_tweet = ""
        is_expected.to eq false
      end
      it "140文字以下の場合：140文字以下はTrue" do
        post.post_tweet = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it "140文字以上の場合：140文字以上はFalse" do
        post.post_tweet = Faker::Lorem.characters(number: 200)
        is_expected.to eq false
      end
    end
    context "post_urlカラムの確認" do
      it "空欄でないこと" do
        post.post_url = ""
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Listenerモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:listener).macro).to eq :belongs_to
      end
    end
  end
end
