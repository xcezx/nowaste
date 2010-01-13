class CreateTables < Sequel::Migration
  def up
    create_table :outgo_categories do
      primary_key :id
      text :name, :null => false
      text :description
      integer :sort_order
      timestamp :created_at
      timestamp :updated_at
    end

    create_table :outgoes do
      primary_key :id
      foreign_key :outgo_category_id, :outgo_categories
      integer :price
      text :comment
      timestamp :created_at
      timestamp :updated_at
    end

    create_table :income_categories do
      primary_key :id
      text :name, :null => false
      text :description
      integer :sort_order
      timestamp :created_at
      timestamp :updated_at
    end

    create_table :incomes do
      primary_key :id
      foreign_key :income_category_id, :income_categories
      integer :price
      text :comment
      timestamp :created_at
      timestamp :updated_at
    end

    create_table :balance do
      primary_key :id
      foreign_key :income_id, :incomes
      foreign_key :outgo_id, :outgoes
      timestamp :created_at
      timestamp :updated_at
    end

  end

  def down
    drop_table :outgo_categories
    drop_table :outgoes
    drop_table :income_categories
    drop_table :incomes
    drop_table :balance
  end
end
