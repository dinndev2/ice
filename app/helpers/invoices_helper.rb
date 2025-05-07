module InvoicesHelper
  def current_invoice?(invoice)
    if params[:invoice_id].present?
      params[:invoice_id] == invoice.to_s
    end
  end
end
