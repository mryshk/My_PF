#frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post_comment, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:post_comment)).to be_valid
    end
  end

end