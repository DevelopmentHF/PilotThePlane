
local composer = require( "composer" )
local widget = require("widget")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local bgGroup
local uiGroup
local playButton
local plane

-- Switches to game scene
local function gotoGame()

	--transition details
    transition.to(plane, {x=1300, time=1000,
        onComplete = function() display.remove(plane) end})

	composer.gotoScene("game", {time=1300, effect="crossFade"});
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	bgGroup = display.newGroup() -- display group for background
	sceneGroup:insert(bgGroup)
	uiGroup = display.newGroup() -- display group for UI objects like title and play button
	sceneGroup:insert(uiGroup)

	-- Add background to scene
	local background = display.newImageRect(bgGroup, "Assets/background-day.png", 1080, 1920)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- Load title text to use
	local titleTextTop = display.newText(uiGroup, "Pilot", display.contentCenterX, 150, "Assets/PressStart2P-Regular.ttf", 120)
	local titleTextBot = display.newText(uiGroup, "The", display.contentCenterX, 250, "Assets/PressStart2P-Regular.ttf", 80)
	local titleTextBot = display.newText(uiGroup, "Plane", display.contentCenterX, 350, "Assets/PressStart2P-Regular.ttf", 120)

	-- Adds big play button 
	playButton = widget.newButton(
		{
			textOnly = true,
			onEvent = gotoGame,
			label = "PLAY",
			font = "Assets/PressStart2P-Regular.ttf",
			fontSize = 200,
			labelColor = {default={0,0,0}, over={1,1,1,0.5}}
		}
	)

	uiGroup:insert(playButton)		-- Allows for removal when clicked

	playButton.x = display.contentCenterX
	playButton.y = display.contentCenterY + 50

	-- Load in plane asset for fun animation
	plane = display.newImageRect(bgGroup, "Assets/plane.png", 255, 165)
    plane.x = -150
    plane.y = display.contentCenterY - 200

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
