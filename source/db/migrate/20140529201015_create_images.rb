class CreateImages < ActiveRecord::Migration
  def change
  	create_table :images do |t|
	  	t.string :url
	  	t.integer :idea_id
	  end
  end
end
