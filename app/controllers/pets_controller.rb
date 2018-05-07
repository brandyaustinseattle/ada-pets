class PetsController < ApplicationController
  def index
    pets = Pet.all
    render(json: pets.as_json(only: [:age, :human, :id, :name]), status: :ok)
  end

  def show
    pet = Pet.find_by(id: params[:id])
    if pet.nil?
      render json: {
        errors: {
          id: ["No pet with ID #{params[:id]}"]
        }
      }, status: :not_found
    else
      render json: pet.as_json(only: [:age, :human, :id, :name], status: :ok)
    end
  end

  def create
    pet = Pet.new(pet_params)
    if pet.save
      render json: {id: pet.id}, status: :created
    else
      # this is using validations errors so it's format will automatically match the format seen in show; we use the same format in show so that it has the same format as what we get
      render json: {errors: pet.errors.messages}, status: :bad_request
    end
  end

  private
  def pet_params
    return params.require(:pet).permit(:age, :human, :name)
  end
end
