class Subscription < ApplicationRecord
  # Link to one Customer
  belongs_to :customer

  # Link to Plans
  has_many :subscription_plans
  has_many :plans, through: :subscription_plans

  # Link to Packages
  has_many :subscription_packages
  has_many :packages, through: :subscription_packages

  # Link to AdittionalServices
  has_many :subscription_adicional_services
  has_many :adicional_services, through: :subscription_adicional_services

  # Link to multiple Invoice
  has_many :invoices

  # Validations
  validate :only_plans_or_packages_present
  validate :no_duplicate_adicional_services_from_packages

  # Invoice creation
  after_create :generate_invoices

  # Calculates the total price
  def total_amount
    total = 0
    total += plans.sum(&:price)
    total += packages.sum(&:price)
    total += adicional_services.sum(&:price)
    total
  end

  private

  # Verifies if there is only packages or only plans
  def only_plans_or_packages_present
    if plans.any? && packages.any?
      errors.add(:base, "Assinatura não pode conter planos e pacotes ao mesmo tempo")
    elsif plans.empty? && packages.empty?
      errors.add(:base, "Assinatura deve conter pelo menos um plano ou um pacote")
    end
  end

  # Verifies if there is no AdicionalServices duplicate
  def no_duplicate_adicional_services_from_packages
    return if packages.empty? || adicional_services.empty?

    # All packages services
    package_service_ids = packages.includes(:adicional_services).flat_map do |package|
      package.adicional_services.pluck(:id)
    end

    # Intersection between chosen additionals and package ones
    duplicated = adicional_services.pluck(:id) & package_service_ids

    if duplicated.any?
      errors.add(:adicional_services, "não pode conter serviços já inclusos nos pacotes selecionados")
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
