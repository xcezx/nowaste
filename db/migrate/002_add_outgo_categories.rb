# -*- coding: utf-8 -*-
class AddOutgoCategories < Sequel::Migration
  def up
    DB[:outgo_categories].insert_multiple([
        {:name => "食費"     , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "雑費"     , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "交際費"   , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "交通費"   , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "服飾費"   , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "医療費"   , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "その他"   , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "家賃"     , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "水光熱費" , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
        {:name => "通信費"   , :sort_order => 1, :created_at => Time.now, :updated_at => Time.now},
      ])
  end

  def down
  end
end
