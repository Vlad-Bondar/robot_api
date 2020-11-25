class Robot < ApplicationRecord
    enum facing: {
        north: 'NORTH',
        south: 'SOUTH',
        east: 'EAST',
        west: 'WEST'
    }

    def set_facing(facing)
        case facing 
        when Robot.facings[:north]
          self.facing = Robot.facings[:north]
        when Robot.facings[:south]
          self.facing = Robot.facings[:south]
        when Robot.facings[:east]
          self.facing = Robot.facings[:east]
        when Robot.facings[:west]
          self.facing = Robot.facings[:west]
        else
          false
        end
    end

    def set_coordinate(params)
        if 0 <= params[1].to_i && params[1].to_i<= 5 && 0 <= params[2].to_i && params[2].to_i <= 5
          self.x = params[1].to_i
          self.y = params[2].to_i
        else
         false
        end
    end

    def set_place(params)
      return false unless self.set_coordinate(params)
      return false unless self.set_facing(params[3])
      true
    end

    def run_other_commands(params)
      params.each_with_index do |command,i|
          self.run(params[i],params[i+1],params[i+2])
          #status
          byebug
      end
    end

    def run(command,params_1=0,params_2=0)
        case command
        when 'MOVE'
          self.move
        when 'LEFT'
          self.turn_left()
        when 'RIGHT'
          self.turn_right()
        when 'PLACE'
          place_params=[]
          place_params << command << params_1 << params_2
          set_place(place_params)
        end
    end

    def move
        #direction = params()
        
        case self.facing.upcase
        when Robot.facings[:north]
            self.y+=1
        when Robot.facings[:west]
            self.x-=1
        when Robot.facings[:south]
            self.y-=1
        when Robot.facings[:east]
            self.x+=1
        end
        #byebug
    end
    
    def turn_right
        case self.facing.upcase
        when Robot.facings[:north]
            self.facing = Robot.facings[:east]
        when Toy.directions[:west]
            self.facing = Robot.facings[:north]
        when Robot.facings[:south]
            self.facing = Robot.facings[:west]
        when Robot.facings[:east]
            self.facing = Robot.facings[:south]
        end
    end

    def turn_left
        case self.facing.upcase
        when Robot.facings[:north]
            self.facing =  Robot.facings[:west]
        when Robot.facings[:west]
            self.facing = Robot.facings[:south]
        when Robot.facings[:south]
            self.facing = Robot.facings[:east]
        when Robot.facings[:east]
            self.facing = Robot.facings[:north]
        end
    end

    def valide_coordinates?
        if 0 <= self.x && self.x<= 5 && 0 <= self.y && self.y <= 5
            true
        else
            false
        end
    end
end
