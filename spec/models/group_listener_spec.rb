#frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupListener, "モデルに関するテスト", type: :model do
  let (:group_listener) { FactoryBot.create(:group_listener) }
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(group_listener).to be_valid
    end
  end

end