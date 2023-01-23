--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

GoldenTrophy = love.graphics.newImage('Golden.png')
SilverTrophy = love.graphics.newImage('Silver.png')


local GOLDEN_POINTS = 5
local SILVER_POINTS = 2
local TROPHY_DISPLAY_OFFSET = 0

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score

    -- Check score for trophy
    if self.score >= GOLDEN_POINTS then 
        self.golden = true
    elseif self.score >= SILVER_POINTS then
        self.silver = true
    else
        self.golden = false
        self.silver = false
    end

end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    if self.golden then
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Congratulations! You earned a golden medal!', 0, 32, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

        love.graphics.draw(GoldenTrophy, 
            VIRTUAL_WIDTH/2 - GoldenTrophy:getWidth()/10/2, 
            100 + GoldenTrophy:getHeight()/10/2,
             0, 0.1, 0.1) -- 0 is for rotation, see the wiki
    elseif self.silver then
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Congratulations! You earned a silver medal!', 0, 32, VIRTUAL_WIDTH, 'center')
        
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

        love.graphics.draw(SilverTrophy,
            VIRTUAL_WIDTH/2 - SilverTrophy:getWidth()/10/2, 
            100 + SilverTrophy:getHeight()/10/2 - TROPHY_DISPLAY_OFFSET,
            0, 0.1, 0.1) -- 0 is for rotation, see the wiki
    else
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Oof! You have lost :(', 0, 64, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 200, VIRTUAL_WIDTH, 'center')
end