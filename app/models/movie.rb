class Movie
  include Mongoid::Document
  field :name, type: String
  field :rating, type: Float
end
