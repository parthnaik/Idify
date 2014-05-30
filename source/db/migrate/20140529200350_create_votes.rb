class CreateVotes < ActiveRecord::Migration
  def change
  	create_table :votes do |t|
	  	t.integer :idea_id
	  	t.integer :voter_id
	  end
  end
end
