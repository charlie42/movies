class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit

  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(name:params[:movie][:name], rating:params[:movie][:rating], grade_count:1, grade_accumulator:params[:movie][:rating])
    @user = User.find(current_user.id)
    if @user.graded_movies.nil?
      @user.graded_movies = Hash.new
    end
    @user.graded_movies[params[:movie][:name]] = params[:movie][:rating].to_i
puts params[:movie][:name]
puts @user.graded_movies
@user.save
    #@movie.grade_count = 0
    #puts @movie.grade_count
    #@movie.grade_accumulator = params[:rating]

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update

    @movie = Movie.find(params[:id])
    @movie.grade_count += 1
    @movie.grade_accumulator += params[:movie][:rating].to_i
    @movie.name = params[:movie][:name]

    @user = User.find(current_user.id)
    if @user.graded_movies.nil?
      @user.graded_movies = Hash.new
    end
#puts @user.graded_movies
    if @user.graded_movies.key? params[:movie][:name]
      old_grade = @user.graded_movies[params[:movie][:name]]
#puts old_grade
      @movie.grade_accumulator -= old_grade
#puts @movie.grade_accumulator
      @movie.grade_count -= 1
#puts @movie.grade_count
    end

    @user.graded_movies[params[:movie][:name]] = params[:movie][:rating].to_i
#puts "wwwwwwwwwwwww" + @user.graded_movies[params[:movie][:name]].to_s
    @user.save
    @movie.rating = @movie.grade_accumulator/@movie.grade_count

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:name, :rating)
    end
end
