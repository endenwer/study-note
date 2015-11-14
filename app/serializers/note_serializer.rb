class NoteSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at
  has_many :attachments
end
