class Income < Sequel::Model(:incomes)
  many_to_one :income_category

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
