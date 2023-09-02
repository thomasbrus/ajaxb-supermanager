class CreateWeeklyRanking < ActiveRecord::Migration[7.0][5.0]
  def change
    create_table :weekly_rankings do |t|
      t.date :date
    end
  end
end
