# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Listener, type: :system do
  let(:listener) { create(:listener) }
  context '新規登録が可能かどうか'do
    it "ユーザーの新規登録が無事されるかどうか"do
      visit new_listener_registration_path
      fill_in 'registration_name',with: 'あいうえお'
      fill_in 'registration_email',with: 'test@example.com'
      fill_in 'registration_password',with: 'password'
      fill_in 'registration_password_confirmation',with: 'password'
      click_button 'SignUp'
      expect(current_path).to eq home_path
    end
  end

  context 'ログインが可能かどうか'do
    before do
       visit new_listener_session_path
    end
    it "ユーザーのログインが無事されるかどうか"do
      fill_in 'session_email',with: 'test@example.com'
      fill_in 'session_password',with: 'password'
      fill_in 'session_password_confirmation',with: 'password'
      click_button 'LogIn'
      expect(current_path).to eq home_path
    end
  end
end