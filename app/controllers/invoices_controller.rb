class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :download_pdf, :send_and_save_modal_content]

  def index
    @invoices = Invoice.all
  end

  def show
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save 
      respond_to do |format|
        format.html { redirect_to invoice_path(@invoice), notice: "Invoice created" }
        format.turbo_stream
      end
       
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @invoice.line_expences.build unless @invoice.line_expences.present?
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.assign_attributes(invoice_params)
    # attach 
    if invoice_params[:company_logo].present? || !@invoice.company_logo.attached?
      @invoice.company_logo.attach(invoice_params[:company_logo])
    end

    if @invoice.save
      redirect_to invoice_path(@invoice), notice: "Invoice updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @invoice = Invoice.new
    @invoice.line_expences.build
  end

  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_path, notice: "Invoice destroyed!" }
      format.turbo_stream
    end
  end

  def send_and_save_modal_content
    
  end

  def download_pdf
    @expences = @invoice.line_expences
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@invoice.name}_invoice",
        template: "invoices/download_pdf",
        disposition: 'attachment'
      end
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:name, :details, :from, :to, :date, :due_date, :total, :company_logo,line_expences_attributes: [:id, :quantity, :name, :rate, :total, :_destroy] )
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end
end
