class InvoiceMailer < ApplicationMailer
  default from: "dinndev@gmail.com"
  layout "mailer"

  def send_invoice
    @invoice = Invoice.find(params[:invoice_id])
    to = "dinndev2@gmail.com"
    
    if @invoice.company_logo.attached?
      attachments['invoice'] = {
        content: @invoice.company_logo.download
      }
    end
    
    mail(to: to)
  end
end
