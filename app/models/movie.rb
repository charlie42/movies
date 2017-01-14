class Movie
  include Mongoid::Document
  field :name, type: String
  field :rating, type: Float
  field :grade_count, type: Integer
  field :grade_accumulator, type: Integer

  has_many :grades

  validates :name, presence:true
  validates :rating, presence:true
  validates :rating, numericality: { less_than: 11}
  validates_uniqueness_of :name, :case_sensitive => false
end
