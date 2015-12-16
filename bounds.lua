module(..., package.seeall)
--Be The Rock: Collision Bounds Module

bounds = function()
    leftBound = display.newRect( -100, -100, 1, _h + 100 );
	physics.addBody( leftBound, "static", { density = 0, friction = 0, bounce = 1 } );
	
    local onLocalCollision = function( self, event )
        if (event.phase == "began") then
			if debugText then print( "removing meteor" ); end
			event.other:removeSelf();
		end
	end
	leftBound.collision = onLocalCollision;
	leftBound:addEventListener( "collision", meteor );
end