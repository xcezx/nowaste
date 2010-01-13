class IncomeCategory < Sequel::Model(:income_categories)
  one_to_many :incomes

  def before_create
    super
    self.created_at = Time.now
    self.updated_at = Time.now
  end

  def before_update
    super
    self.updated_at = Time.now
  end
end










