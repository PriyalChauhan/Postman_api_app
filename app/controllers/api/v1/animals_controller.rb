class Api::V1::AnimalsController < ApplicationController
  def index
    @animals = Animal.all
    render json: @animals
  end

  def show
    @animal = Animal.find(params[:id])
    render json: @animal
  end

  def create
    @animal = Animal.new(animal_params)
    if @animal.save
      render json: @animal
    else
      render json: { error: "Animal can not be created" }, status: 400 
    end
  end

  def update
    @animal = Animal.find(params[:id])
    if @animal
      @animal.update(animal_params)
      render json: { message: "Animal updated" }, status: 200
    else
      render json: { error: "Animal can not be updated" }, status: 400
    end
  end

  def destroy
    @animal = Animal.find(params[:id])
    if @animal
      @animal.destroy
      render json: { message: "Animal got deleted" }, status: 200
    else
      render json: { error: "Animal can not be deleted" }, status: 400
    end
  end

  private
  def animal_params
    params.require(:animal).permit(:name,:breed,:zoo_id)
  end
end
