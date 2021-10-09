#frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, "モデルに関するテスト", type: :model do
  let (:relationship) { FactoryBot.build(:relationship) }
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(relationship).to be_valid
    end
  end

end