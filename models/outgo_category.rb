class OutgoCategory < Sequel::Model(:outgo_categories)
  one_to_many :outgoes

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
