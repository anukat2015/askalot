class AddDeletorAndDeletedAtToDeletables < ActiveRecord::Migration
  def change
    models = [
      :answers,
      :answer_revisions,
      :comments,
      :comment_revisions,
      :evaluations,
      :favorites,
      :labelings,
      :questions,
      :question_revisions,
      :taggings,
      :views,
      :votes
    ]

    models.each do |model|
      add_reference model, :deletor, null: true, index: true
      add_column model, :deleted_at, :timestamp
    end
  end
end
