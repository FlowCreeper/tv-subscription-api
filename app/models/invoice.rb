class Invoice < ApplicationRecord
  belongs_to :subscription

  validates :due_date, :amount, presence: true

  def generate_pdf
    pdf = Prawn::Document.new do |pdf|
      pdf.text "Fatura ##{id}", size: 24, style: :bold
      pdf.move_down 20

      pdf.text "Cliente: #{subscription.customer.name}"
      pdf.text "Data de emissão: #{created_at.strftime('%d/%m/%Y')}"
      pdf.text "Data de vencimento: #{due_date.strftime('%d/%m/%Y')}"
      pdf.text "Valor total: R$ #{'%.2f' % amount}"
      pdf.move_down 20

      pdf.text "Itens da Assinatura", style: :bold

      # Add plans
      subscription.plans.each do |plan|
        pdf.text "- Plano: #{plan.name} (R$ #{'%.2f' % plan.price})"
      end

      # Add packages
      subscription.packages.each do |package|
        pdf.text "- Pacote: #{package.name} (R$ #{'%.2f' % package.price})"
      end

      # Add adittional services
      subscription.adicional_services.each do |service|
        pdf.text "- Serviço adicional: #{service.name} (R$ #{'%.2f' % service.price})"
      end
    end
    pdf.render
  end
end
