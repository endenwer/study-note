class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :url,

  def url
    object.file.url
  end

  def name
    object.file_identifier
  end
end
