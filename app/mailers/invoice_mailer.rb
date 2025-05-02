class InvoiceMailer < ApplicationMailer
  default from: "dinndev@gmail.com"
  layout "mailer"
 
  def send_invoice
    @email_attempt = EmailAttempt.find(params[:email_attempt_id])
    @invoice = @email_attempt.invoice
    @expences = @invoice.line_expences

    pdf_html = ApplicationController.render(
      template: 'invoices/download_pdf',
      assigns: { invoice: @invoice, expences: @expences }
    )

    pdf = WickedPdf.new.pdf_from_string(pdf_html)

    attachments["#{@invoice.name}_invoice.pdf"] = {
      mime_type: 'application/pdf',
      content: pdf
    }
    
    to = @email_attempt.recipient
    subject = @email_attempt.subject
    @content = @email_attempt.content
    
    mail(to: to, subject: subject)
  end
end
