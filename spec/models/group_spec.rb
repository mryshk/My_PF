# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, "モデルに関するテスト", type: :model do
  let(:group) { FactoryBot.build(:group) }

  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(group).to be_valid
    end
  end
  describe "バリデーション確認" do
    subject { group.valid? }

    let!(:listener) { create(:listener) }
    let!(:group) { build(:group, owner_id: listener.id) }

    context "namaカラムの確認" do
      it "空白であるかの確認" do
        group.name = ""
        is_expected.to eq false
      end
    end
    context "introductionカラムの確認" do
      it "140文字以下の場合：140文字以下であればTrue" do
        group.introduction = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it "140文字以上の場合：140文字以上であればFalse" do
        group.introduction = Faker::Lorem.characters(number: 200)
        is_expected.to eq false
      end
    end
  end
end
