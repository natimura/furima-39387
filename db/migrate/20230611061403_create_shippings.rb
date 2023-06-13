class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.references :order,          null: false, foreign_key: true
      t.string     :post_code ,     null: false, default: ""
      t.integer    :prefecture_id,  null: false
      t.string     :municipalities, null: false, default: ""
      t.string     :address,        null: false, default: ""
      t.string     :building,                    default: ""
      t.string     :telephone,      null: false, default: ""
      t.timestamps
    end
  end
end
