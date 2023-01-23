--[[ 

PauseState should store all of the PlayState information, freeze the page and
be able to return to PlayState. 


]]
PauseState = Class{__includes = PlayState}

function PauseState:init(PlayState)
    self.savedState = PlayState

end

function PauseState:update(dt)

    -- Check for unpause:
    if love.keyboard.wasPressed('p') then 
        gStateMachine:change('play')
    end 
end

function PauseState:render()

    for k, pair in pairs(self.savedState.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Congratulations! You earned a golden medal!', 0, 32, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.savedState.score), 0, 100, VIRTUAL_WIDTH, 'center')

    self.savedState.bird:render()
end
