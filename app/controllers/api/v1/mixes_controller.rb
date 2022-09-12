class Api::V1::MixesController < ApplicationController
  def index
    mixes = Mix.all

    render json: mixes, status: 200
  end

  def show
    mix = Mix.find_by(id: params[:id])
    if mix
      render json: mix, status: 200
    else
      render json: {error: "Mix not found."}
    end

=begin
    private

    def prod_params
      params.resquire(:mix).permit([
                                     :brend,
                                     :name,
                                     :composition,
                                     :description
                                   ])
    end
=end
  end
end
