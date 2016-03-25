class CreateKnowledges < ActiveRecord::Migration
  def change
    create_table :knowledges do |t|
      t.string :keyword
      t.string :response

      t.timestamps null: false
    end
  end
end
