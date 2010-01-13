# -*- coding: utf-8 -*-
class AddIncomeCategories < Sequel::Migration
  def up
    DB[:income_categories].insert_multiple([
        {:name => "給与所得", :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "特別収入", :sort_order => 2, :created_at => Time.now, :updated_at => Time.now},
      ])
  end

  def down
  end
end
