class Grade
  include Mongoid::Document
  field :grade, type: Integer

  belongs_to :movie
  belongs_to :user
end
