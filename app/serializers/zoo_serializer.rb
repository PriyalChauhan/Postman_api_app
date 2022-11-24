class ZooSerializer < ActiveModel::Serializer
  attributes :id,:name,:location
  has_many :animals
end
