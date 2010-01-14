class Balance < Sequel::Model(:balance)
  many_to_one :outgo
  many_to_one :income

  def before_create
    super
    self.created_at = Time.now
    self.updated_at = Time.now
  end

  def before_update
    super
    self.updated_at = Time.now
  end

  def category_name
    if !self.outgo.nil? then
      self.outgo.outgo_category.name
    elsif !self.income.nil? then
      self.income.income_category.name
    end
  end

  def comment
    if !self.outgo.nil? then
      self.outgo.comment
    elsif !self.income.nil? then
      self.income.comment
    end
  end

  def income_price
    if !self.income.nil? then
      self.income.price
    end
  end

  def outgo_price
    if !self.outgo.nil? then
      self.outgo.price
    end
  end

end
