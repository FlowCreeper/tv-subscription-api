class Api::InvoicesController < ApplicationController
  def show
    invoice = Invoice.find(params[:id])
    send_data invoice.generate_pdf,
      filename: "fatura-#{invoice.id}.pdf",
      type: "application/pdf",
      disposition: "inline"
  end
end
