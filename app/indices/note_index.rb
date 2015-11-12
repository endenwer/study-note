ThinkingSphinx::Index.define :note, :with => :active_record do
  # fields
  indexes text

  # attributes
  has created_at, updated_at, category_id
end
