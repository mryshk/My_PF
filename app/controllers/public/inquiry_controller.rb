class Public::InquiryController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render 'confirm'
    else
      render 'new'
    end
  end

  def finish
    @inquiry = Inquiry.new(inquiry_params)
    InquiryMailer.received_email(@inquiry).deliver
    render 'finish'
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
end
