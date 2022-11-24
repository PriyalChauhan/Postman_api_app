class Api::V1::ZoosController < ApplicationController
  def index
    @zoos = Zoo.all
    render json: @zoos
  end

  def show
    @zoo = Zoo.find(params[:id])
    render json: @zoo
  end

  def create
    @zoo = Zoo.new(zoo_params)
    if @zoo.save
      render json: @zoo
    else
      render json: { error: "Zoo can not be created" }, status: 400 
    end
  end

  def update
    @zoo = Zoo.find(params[:id])
    if @zoo
      @zoo.update(zoo_params)
      render json: { message: "Zoo updated" }, status: 200
    else
      render json: { error: "Zoo can not be updated" }, status: 400
    end
  end

  def destroy
    @zoo = Zoo.find(params[:id])
    if @zoo
      @zoo.destroy
      render json: { message: "Zoo got deleted" }, status: 200
    else
      render json: { error: "Zoo can not be deleted" }, status: 400
    end
  end

  private
  def zoo_params
    params.require(:zoo).permit(:name,:location)
  end
end
