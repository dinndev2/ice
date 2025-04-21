class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = Invoice.all
  end

  def show
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save 
      redirect_to invoice_path(@invoice), notice: "Invoice created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.assign_attributes(invoice_params)
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
    redirect_to invoices_path, notice: "Invoice destroyed"
  end

  def new_line_expence

  end

  private

  def invoice_params
    params.require(:invoice).permit(:name, :details, :from, :to, :date, :due_date, :total, line_expences_attributes: [:id, :quantity, :name, :rate, :_destroy] )
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
    @form = params[:form]
  end
end
