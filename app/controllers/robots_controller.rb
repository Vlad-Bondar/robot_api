class RobotsController < ApplicationController
   
  def create
    @robot = Robot.new
    @params = params[:commands].gsub( /\W/ , ' ').split
    right_first_command?(@params)
    byebug
    render json: @robot , status: :unprocessable_entity unless @robot.set_place(@params)
    
    delete_first_params(@params)
    @robot.run_other_commands(@params)
    render json: @robot , status: :unprocessable_entity unless @robot.valide_coordinates?
    
    if status != 422
      render json: @robot, status: :ok
    end
  end

  private 

  def right_first_command?(params)
    unless params[0] == 'PLACE' && !params[1].scan(/\d/).empty? && !params[2].scan(/\d/).empty? 
      render json: params, status: :unprocessable_entity 
    end   
    true
  end

  def delete_first_params(params)
    4.times{params.delete_at(0)}
  end

end