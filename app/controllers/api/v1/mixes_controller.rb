class Api::V1::MixesController < ApplicationController
  def index
    mixes = Mix.all

    render json: mixes, status: 200
  end

  def selection_of_taste(query)
    mix = Mix.where("keywords LIKE ?, '#{query}'")
    if mix
      render json: mix, status: 200
    else
      render json: {error: "Mix not found."}
    end
  end

  def show
    mix = Mix.find_by(id: params[:id])
    if mix
      render json: mix, status: 200
    else
      render json: {error: "Mix not found."}
    end
  end

  private

  def prod_params
    params.require(:mix).permit([
      :brend,
      :name,
      :composition,
      :description
      ])
  end
end
