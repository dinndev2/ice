# Preview all emails at http://localhost:3000/rails/mailers/invoice_mailer
class InvoiceMailerPreview < ActionMailer::Preview
  def send_invoice
    @invoice = Invoice.find(params[:invoice_id])
    @to = "dinndev2@gmail.com"
    mail(to: @to)
  end
end 
