class CreateMixes < ActiveRecord::Migration[7.0]
  def change
    create_table :mixes do |t|
      t.string :brend
      t.string :name
      t.string :composition
      t.string :description

      t.timestamps
    end
  end
end
