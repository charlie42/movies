class Movie
  include Mongoid::Document
  field :name, type: String
  field :rating, type: Float

  validates :name, presence:true
  validates :rating, presence:true
  validates :rating, numericality: { only_integer: true, less_than: 11}
end
