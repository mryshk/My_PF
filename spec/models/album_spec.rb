# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:album)).to be_valid
    end
  end
  describe "バリデーションのテスト"do
    subject { album.valid? }

     let!(:listener) { create(:listener) }
     let!(:album) { build(:album, listener_id: listener.id) }

    context "nameカラムの確認" do
      it "空欄でないこと" do
        album.name = ""
        is_expected.to eq false
      end
    end
    context "captionカラムの確認" do
      it "140文字以下の場合：140文字以下はTrue" do
        album.caption = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it "140文字以上の場合：140文字以上の場合はfalse" do
        album.caption = Faker::Lorem.characters(number: 200)
        is_expected.to eq false
      end
    end
    context "album_urlの確認" do
      it "空欄でないこと" do
        album.album_url = ""
        is_expected.to eq false
      end
    end
  end
end
