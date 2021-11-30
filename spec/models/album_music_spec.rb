# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlbumMusic, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:album_music)).to be_valid
    end
  end
  describe "バリデーションテスト"do
    subject { album_music.valid? }
    
    let!(:listener) { create(:listener) }
    let!(:album_music) { build(:album_music, listener_id: listener.id) }
    
    context "nameカラムの確認" do
      it "空白であるかどうかの確認" do
        album_music.name = ""
        is_expected.to eq false
      end
    end
    context "captionカラムの確認" do
      it "140文字以下の場合：140字以下であればTrue" do
        album_music.caption = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
    end
    context "music_urlカラムの確認" do
      it "140文字以上である場合：140文字以上であればFalse" do
        album_music.caption = Faker::Lorem.characters(number: 200)
        is_expected.to eq false
      end
    end
  end
end
