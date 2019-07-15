class DisallowNullEffectiveAtOnPublishings < ActiveRecord::Migration[5.2]
  def change
    change_column_null :publishings, :effective_at, false
  end
end
