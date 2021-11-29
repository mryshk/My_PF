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

    context "post_tweetカラム" do
      it "空欄でないこと" do
        post.post_tweet = ""
        is_expected.to eq false
      end
    end
    context "post_urlカラム" do
      it "空欄でないこと" do
        post.post_url = ""
        is_expected.to eq false
      end
    end
  end
end


# RSpec.describe 'Bookモデルのテスト', type: :model do
#   describe 'バリデーションのテスト' do
#     subject { book.valid? }

#     let(:user) { create(:user) }
#     let!(:book) { build(:book, user_id: user.id) }

#     context 'titleカラム' do
#       it '空欄でないこと' do
#         book.title = ''
#         is_expected.to eq false
#       end
#     end

#     context 'bodyカラム' do
#       it '空欄でないこと' do
#         book.body = ''
#         is_expected.to eq false
#       end
#       it '200文字以下であること: 200文字は〇' do
#         book.body = Faker::Lorem.characters(number: 200)
#         is_expected.to eq true
#       end
#       it '200文字以下であること: 201文字は×' do
#         book.body = Faker::Lorem.characters(number: 201)
#         is_expected.to eq false
#       end
#     end
#   end

#   describe 'アソシエーションのテスト' do
#     context 'Userモデルとの関係' do
#       it 'N:1となっている' do
#         expect(Book.reflect_on_association(:user).macro).to eq :belongs_to
#       end
#     end
#   end
# end