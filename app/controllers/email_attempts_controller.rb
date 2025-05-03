class EmailAttemptsController < ApplicationController
  def create
    @email_attempt = EmailAttempt.new(email_attempt_params)
    @invoice = Invoice.find(email_attempt_params[:invoice_id])

    if @email_attempt.save
      sleep 1.seconds
      InvoiceMailer.with(email_attempt_id: @email_attempt.id).send_invoice.deliver_later
    else
      render :send_and_save_modal_content, status: :unprocessable_entity
    end
  end

  def send_and_save_modal_content
    @invoice = Invoice.find(params[:invoice_id]) 
    @email_attempt = @invoice.email_attempts.build
  end

  private
  def email_attempt_params
    params.require(:email_attempt).permit(:subject, :content, :recipient, :invoice_id)
  end
end