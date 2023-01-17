
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Init. physics engine
local physics = require("physics")
physics.start()
physics.setGravity(0, 40)

-- Init. Variables 
local plane
local score = 0
local scoreText
local gameLoopTimer

local backGroup -- display group for bg 
local mainGroup -- group for ship, asteroids, lasers etc
local uiGroup -- group for UI objects i.e the score

local died = false 
local tubeTable = {}

local vertSpeed = 0
local jumpSpeed = -900

local function applyRotation()
	plane:rotate(-15)
	timer.performWithDelay(150,function() plane:rotate(15) end,1);
end

-- Ability to move the plane

local function movePlane(event)
    local plane = event.target
    local phase = event.phase
	local vx, vy = plane:getLinearVelocity()
    if ("began" == phase) then
        -- Sets touch focus on the ship
		plane:setLinearVelocity(0, 0.5*vy+jumpSpeed)
		applyRotation()
    elseif ("ended "== phase or "cancelled" == phase) then 
        -- Release touch focus 
        -- display.currentStage:setFocus(nil)
    end
    return true -- prevents touch propogation to underlying objects
end


local function gameLoop()
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	physics.pause()
	-- Set up display groups
	backGroup = display.newGroup() -- display group for background image
	sceneGroup:insert(backGroup)

	mainGroup = display.newGroup() -- display group for ship, asteroids, lasers etc
	sceneGroup:insert(mainGroup)

	uiGroup = display.newGroup() -- display group for UI objects like score
	sceneGroup:insert(uiGroup)

	-- Add background to scene
	local background = display.newImageRect(backGroup, "Assets/background-day.png", 1080, 1920)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- Load plane
	plane = display.newImageRect(mainGroup, "Assets/plane.png", 255, 165)
	plane.x = display.contentCenterX - 250
	plane.y = display.contentCenterY
	physics.addBody(plane, {radius=125, isSensor=false}) -- Do want bouncing off tubes
	plane.myName = "plane"
	plane.linearDamping = 1.65

	plane:addEventListener("touch", movePlane)
	display.currentStage:setFocus(plane)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		gameLoopTimer = timer.performWithDelay(0, gameLoop, 0)
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
