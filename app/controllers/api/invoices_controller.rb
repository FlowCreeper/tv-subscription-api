class Api::InvoicesController < ApplicationController
  def show
    if numeric_id?(params[:id])
      invoice = Invoice.find(params[:id])
      send_data invoice.generate_pdf,
        filename: "fatura-#{invoice.id}.pdf",
        type: "application/pdf",
        disposition: "inline"
    else
      invoice = Invoice.joins(subscription: :customer)
                 .where(customers: { name: params[:id] }).first
      send_data invoice.generate_pdf,
        filename: "fatura-#{invoice.id}.pdf",
        type: "application/pdf",
        disposition: "inline"
    end
  end

  private

  def numeric_id?(value)
    # Checks if the value is composed only of digits
    value.to_s.match?(/\A\d+\z/)
  end
end
