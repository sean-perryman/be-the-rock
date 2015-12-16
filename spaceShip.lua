module(..., package.seeall)
-- Be The Rock: Spaceship Creation Module

createShip = function( speedLimit )
    local moveMeX, moveMeY = 0;
    local hits = 0;

    math.randomseed( os.time() );
	local ship = display.newImage( "ship1.png", 128, 128 );
    ship:setReferencePoint( display.CenterReferencePoint );
	ship.name = "ship";
	ship.x = 40; ship.y = math.random( _h )
	physics.addBody( ship, { density = 1, friction = 0, bounce = 0, radius = 36 } )
    ship.isFixedRotation = true;
    ship.isSleepingAllowed = false;

    local shieldFunc = function( event )
        if shield then shield:removeSelf(); end
        if hits == 0 then 
            shieldSize = 36;
        elseif hits == 1 then
            shieldSize = 32;
            --physics.removeBody( ship );
            physics.addBody( ship, { density = 1, friction = 0, bounce = 0, radius = shieldSize } );
        elseif hits == 2 then 
            shieldSize = 28;
            --physics.removeBody( ship );
            physics.addBody( ship, { density = 1, friction = 0, bounce = 0, radius = shieldSize } );
        elseif hits == 3 then
            Runtime:removeEventListener( "enterFrame", shieldMove );
            shieldSize = 0; 
        end
        shield = display.newCircle( 0, 0, shieldSize );
        --physics.addBody( shield, { density = 0, friction = 0, bounce = 0, radius = shieldSize } )
        shield:setFillColor( 255, 255, 255, 50 );
        shield:setReferencePoint( display.CenterRferencePoint );
        shield.x = ship.x; shield.y = ship.y;
    end
    shieldFunc();

    local shieldMove = function()
        shield.x = ship.x; shield.y = ship.y;
    end

	local moveShip = function( event )
		ship:toFront();

        -- Ship debug outputs
        if debugMoveLV then print( ship:getLinearVelocity() ); end
        if debugMoveCoords then print( "ship.x: " .. ship.x ); end
        if debugMoveCoords then print( "ship.y: " .. ship.y ); end

        -- Move ship back into normal x-position
        if ship.x < 45 and ship.x > 35 and moveMeX == 1 then
            --if debugMove then print( "x centered" ); end
            moveMeX = 0;
            ship:setLinearVelocity( 0, 0 );
        elseif ship.x < 35 then
			if debugMove then print( "less than 40" ); end
            ship:applyLinearImpulse( .5, 0, ship.x, ship.y );
            moveMeX = 1;
		elseif ship.x > 45 then
            if debugMove then print( "greater than 40" ); end
            ship:applyLinearImpulse( -.5, 0, ship.x, ship.y );
            moveMeX = 1;
		end
        
        -- Move ship away from upper and lower bounds        
        if ship.y > _h - 60 then
            if debugMove then print( "lower bound" ); end
            ship:applyLinearImpulse( 0, -1, ship.x, ship.y );
            moveMeY = 1;
        elseif ship.y < 60 then
            if debugMove then print( "upper bound" ); end
            ship:applyLinearImpulse( 0, 1, ship.x, ship.y );
            moveMeY = 1;
        end
        
        -- Move ship up and down
		local randMove = math.random( 10 )
		if randMove == 3 and ship.y < _h - 10 then
			if debugMove then print( "move ship down" ); end
            ship:applyLinearImpulse( 0, 2, ship.x, ship.y );
            --ship:applyForce( 0, 25, ship.x, ship.y );
		elseif randMove == 7 and ship.y > 10 then
            if debugMove then print( "move ship up" ); end
			ship:applyLinearImpulse( 0, -2, ship.x, ship.y );
            --ship:applyForce( 0, -25, ship.x, ship.y );
		end

        --Limit ship velocity to 50
        local vx, vy = ship:getLinearVelocity()
        if vy > speedLimit then ship:setLinearVelocity( 0, speedLimit ); end
        if vy < -speedLimit then ship:setLinearVelocity( 0, -speedLimit ); end

	end

        local onLocalCollision = function( self, event )
        if event.phase == "began" then
            if debugText then print( "removing meteor" ); end
            moveMe = 0;
            hits = hits + 1
            timer.performWithDelay( 1, shieldFunc, 1 );
            collisionX = event.other.x; collisionY = event.other.y;
            event.other:removeSelf();
        end
        --timer.performWithDelay( 1, explodeMeteor, 1 );
    end
    ship.collision = onLocalCollision;

    ship:addEventListener( "collision", meteor );
    Runtime:addEventListener( "enterFrame", shieldMove );
	timer.performWithDelay( 100, moveShip, 0 );
end