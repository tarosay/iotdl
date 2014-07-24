class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :userid
      t.string :filename
      t.string :datelog

      t.timestamps
    end
  end
end
