class Subscription < ApplicationRecord
  # Link to one Customer
  belongs_to :customer

  # Link to a single Plan
  belongs_to :plan, optional: true

  # Link to a single Package
  belongs_to :package, optional: true

  # Link to AdittionalServices
  has_many :subscription_adicional_services
  has_many :adicional_services, through: :subscription_adicional_services

  # Link to multiple Invoice
  has_many :invoices

  # Validations
  validate :only_one_plan_or_package_present
  validate :no_duplicate_adicional_services_from_package

  # Invoice creation
  after_create :generate_invoices

  # Calculates the total price
  def total_amount
    total = 0
    total += plan.price if plan
    total += package.price if package
    total += adicional_services.sum(&:price)
    total
  end

  private

  # Ensure only one of plan or package is selected
  def only_one_plan_or_package_present
    if plan && package
      errors.add(:base, "Assinatura não pode conter plano e pacote ao mesmo tempo")
    elsif plan.nil? && package.nil?
      errors.add(:base, "Assinatura deve conter um plano ou um pacote")
    end
  end

  # Check for duplicate adicional services from the selected package
  def no_duplicate_adicional_services_from_package
    return unless package && adicional_services.any?

    package_service_ids = package.adicional_services.pluck(:id)
    duplicated = adicional_service_ids.map(&:to_i) & package_service_ids

    if duplicated.any?
      errors.add(:adicional_services, "não pode conter serviços já inclusos no pacote selecionado")
    end
  end

  # Crete the invoices for the subscription
  def generate_invoices
    amount = total_amount
    base_date = created_at || Time.current
    due_day = base_date.day

    12.times do |i|
      due_date = (base_date + (i + 1).month).change(day: due_day) rescue nil
      due_date ||= (base_date + (i + 1).month).end_of_month

      invoices.create!(
        due_date: due_date,
        amount: amount
      )
    end
  end
end
