class Api::V1::MixesController < ApplicationController
  def index
    mixes = Mix.all

    render json: mixes, status: 200
  end

  def selection_of_taste
    query = params[:query].downcase
    mix = Mix.where('lower(brend) LIKE :query OR lower(name) LIKE :query OR ' +
                    'lower(composition) LIKE :query OR lower(description) LIKE :query',
                    query: "%#{query}%")
    if mix.empty?
      render json: { error: 'Mix not found.' }
    else
      render json: mix, status: 200
    end
  end

  def random_mix
    mix = Mix.order('RANDOM()').first
    if mix
      render json: mix, status: 200
    else
      render json: { error: 'No mixes available.' }, status: 404
    end
  end

  def show
    mix = Mix.find_by(id: params[:id])
    if mix
      render json: mix, status: 200
    else
      render json: { error: 'Mix not found.' }
    end
  end

  private

  def prod_params
    params.require(:mix).permit(%i[
      brend
      name
      composition
      description
    ])
  end
end
