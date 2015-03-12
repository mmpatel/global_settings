class CreateGlobalSetting < ActiveRecord::Migration
  def change
    create_table :global_settings do |t|
      t.string :key_name
      t.string :key_type
      t.string :key_value
      
      t.timestamps
    end
  end
end
