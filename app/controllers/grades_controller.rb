class GradesController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @grade = @movie.grades.create!(params[:grade, :movie_id, :user_id])
    redirect_to @movie, :notice => "Graded!"
  end

end
