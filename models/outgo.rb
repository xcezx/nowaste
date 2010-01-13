class Outgo < Sequel::Model(:outgoes)
  many_to_one :outgo_category

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










