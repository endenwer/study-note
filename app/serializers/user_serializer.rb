class UserSerializer < ActiveModel::Serializer
  attributes :name, :image

  def group
    object.group.name
  end
end
