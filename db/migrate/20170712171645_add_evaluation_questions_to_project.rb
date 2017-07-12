class AddEvaluationQuestionsToProject < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.text :why_question
      t.text :market_question
      t.text :current_situation_question
      t.text :problems_question
      t.text :outcome_question
      t.text :customer_agreed_question
      t.text :requirements_question
      t.text :must_do_question
      t.text :must_not_do_question
    end
  end
end
