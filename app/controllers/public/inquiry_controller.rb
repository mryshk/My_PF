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

  def back
    @inquiry = Inquiry.new(inquiry_params)
     render 'new'
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to finish_inquiry_index_path
    else
      render 'new'
    end
  end

  def finish

  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
end
