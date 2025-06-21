class Api::BookletsController < ApplicationController
  def show
    invoices = Invoice.includes(subscription: [ :customer, :plan, :package, :adicional_services ])
                      .where(subscription_id: params[:id])
                      .order(:due_date)

    if invoices.empty?
      render json: { error: "No invoices found for this customer" }, status: :not_found
      return
    end

    pdf = Prawn::Document.new

    invoices.each_with_index do |invoice, index|
      pdf.text "Fatura ##{invoice.id}", size: 24, style: :bold
      pdf.move_down 10

      pdf.text "Cliente: #{invoice.subscription.customer.name}"
      pdf.text "Data de emissão: #{invoice.created_at.strftime('%d/%m/%Y')}"
      pdf.text "Data de vencimento: #{invoice.due_date.strftime('%d/%m/%Y')}"
      pdf.text "Valor total: R$ #{'%.2f' % invoice.amount}"
      pdf.move_down 10

      pdf.text "Itens da Assinatura", style: :bold
      plan = invoice.subscription.plan
      pdf.text "- Plano: #{plan.name} (R$ #{'%.2f' % plan.price})" if plan

      package = invoice.subscription.package
      pdf.text "- Pacote: #{package.name} (R$ #{'%.2f' % package.price})" if package

      invoice.subscription.adicional_services.each do |service|
        pdf.text "- Serviço adicional: #{service.name} (R$ #{'%.2f' % service.price})"
      end

      # Add a new page unless it's the last invoice
      pdf.start_new_page unless index == invoices.size - 1
    end

    send_data pdf.render,
              filename: "carnê-#{params[:id]}.pdf",
              type: "application/pdf",
              disposition: "inline"
  end
end
