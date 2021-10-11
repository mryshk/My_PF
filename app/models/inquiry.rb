class Inquiry
  include ActiveModel::Model

  attr_accessor :name, :email, :message

  validates :name, :presense => { :message => "名前を入力してください。" }
  validates :email, :presense => { :message => "メールアドレスを入力してください。" }

end