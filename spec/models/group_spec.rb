# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, "モデルに関するテスト", type: :model do
  let(:group) { FactoryBot.build(:group) }

  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(group).to be_valid
    end
  end
end
