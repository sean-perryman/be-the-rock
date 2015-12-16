module(..., package.seeall)
-- Be The Rock: Meteor Stage Section

meteorStage = function()
    local mStage = display.newRect( 0, 0, 75, _h );
    mStage:setFillColor( 100, 100, 100 );
    mStage.x = _w - 35
    
    meteorListeners = function( event )
       if event == 1 then
           print( "touched 1" )
            meteor2:removeEventListener( "touch", meteor2 );
            meteor3:removeEventListener( "touch", meteor3 );
        elseif event == 2 then
            print( "touched 2" )
            meteor1:removeEventListener( "touch", meteor1 );
            meteor3:removeEventListener( "touch", meteor3 );
        elseif event == 3 then
            print( "touched 3" )
            meteor1:removeEventListener( "touch", meteor1 );
            meteor2:removeEventListener( "touch", meteor2 );
        else
            print( "reset listeners" );
            meteor1:addEventListener( "touch", meteor1 );
            meteor2:addEventListener( "touch", meteor2 );
            meteor3:addEventListener( "touch", meteor3 );
        end
    end
    
    meteor1 = display.newCircle( 0, 0, 16 )
    meteor1:setFillColor( 255, 0, 0 )
    meteor1.x = _w * .94; meteor1.y = ( _h / 2 ) - 90;
    function meteor1:touch( event )
        if event.phase == "began" then
            meteorListeners( 1 );
            
            -- begin focus
            display.getCurrentStage():setFocus( self, event.id )
            self.isFocus = true
            
            self.markX = self.x    -- store x location of object
            self.markY = self.y    -- store y location of object
        elseif self.isFocus then
            if event.phase == "moved" then
                local x = (event.x - event.xStart) + self.markX
                local y = (event.y - event.yStart) + self.markY
                if x >= 385 then
                    self.x, self.y = x, y    -- move object based on calculations above
                else
                    self.y = y;
                end
                if event.x > _w - 75 then 
                    self.y = event.y;
                    lineStartY = event.y;
                end
                if movingLine and ( self.markX - self.x <= 150 ) then movingLine:removeSelf(); end
            
                if ( self.markX - self.x  <= 150 ) then
                    thrustX = self.markX - self.x; thrustY = lineStartY - self.y;
                    movingLine = display.newLine( self.markX, lineStartY, self.x, self.y )
                end
            elseif event.phase == "ended"  and movingLine then
                meteor1:removeEventListener( "touch", meteor3 );
                display.getCurrentStage():setFocus( self, nil );
                self.isFocus = false;
                movingLine.y = _h + 500; --move line off screen once meteor is launched.
                self.x = _w * .94; self.y = ( _h / 2 ) - 90;
                
                meteor = display.newImage( "meteor1.png", 64, 64 );
                meteor.xScale = .5; meteor.yScale = .5;
                physics.addBody( meteor, { density = 0, friction = .5, bounce = 0, radius = 32 } );
                meteor.x = _w - 45; meteor.y = lineStartY;
                --local xVelocity = ( event.xStart - event.x ) / 500;
                local xVelocity = thrustX / 500;
                if xVelocity < 0 then
                    xVelocity = -xVelocity;
                end
                --local yVelocity = ( meteor.y - event.y ) / 500;
                local yVelocity = thrustY / 500;
                meteor:applyLinearImpulse( -xVelocity, -yVelocity, meteor.x, meteor.y )
                meteorListeners();
            end
        end
        
        return true
    end
    
    meteor2 = display.newCircle( 0, 0, 16 )
    meteor2:setFillColor( 0, 255, 0 )
    meteor2.x = _w * .94; meteor2.y = _h / 2;
    function meteor2:touch( event )
        if event.phase == "began" then
            meteorListeners( 2 );
            
            -- begin focus
            display.getCurrentStage():setFocus( self, event.id )
            self.isFocus = true
            
            self.markX = self.x    -- store x location of object
            self.markY = self.y    -- store y location of object
        elseif self.isFocus then
            if event.phase == "moved" then
                local x = (event.x - event.xStart) + self.markX
                local y = (event.y - event.yStart) + self.markY
                 if x >= 385 then
                    self.x, self.y = x, y    -- move object based on calculations above
                else
                    self.y = y;
                end
                if event.x > _w - 75 then 
                    self.y = event.y;
                    lineStartY = event.y;
                end
                if movingLine and ( self.markX - self.x <= 150 ) then movingLine:removeSelf(); end
            
                if ( self.markX - self.x  <= 150 ) then
                    thrustX = self.markX - self.x; thrustY = lineStartY - self.y;
                    movingLine = display.newLine( self.markX, lineStartY, self.x, self.y )
                end
            elseif event.phase == "ended" and movingLine then
                meteor2:removeEventListener( "touch", meteor3 );
                display.getCurrentStage():setFocus( self, nil );
                self.isFocus = false;
                movingLine.y = _h + 500; --move line off screen once meteor is launched.
                self.x = _w * .94; self.y = _h / 2;
                
                meteor = display.newImage( "meteor1.png", 64, 64 );
                meteor.xScale = .75; meteor.yScale = .75;
                physics.addBody( meteor, { density = 0, friction = .5, bounce = 0, radius = 32 } );
                meteor.x = _w - 45; meteor.y = lineStartY;
                --local xVelocity = ( event.xStart - event.x ) / 500;
                local xVelocity = thrustX / 500;
                if xVelocity < 0 then
                    xVelocity = -xVelocity;
                end
                --local yVelocity = ( meteor.y - event.y ) / 500;
                local yVelocity = thrustY / 500;
                meteor:applyLinearImpulse( -xVelocity, -yVelocity, meteor.x, meteor.y )
                meteorListeners();
            end
        end
        
        return true
    end
    
    
    meteor3 = display.newCircle( 0, 0, 16 )
    meteor3:setFillColor( 0, 0, 255 )
    meteor3.x = _w * .94; meteor3.y = ( _h / 2 ) + 90;
    function meteor3:touch( event )
        print( "meteor 3 touch" );
        if event.phase == "began" then
            meteorListeners( 3 );
            -- begin focus
            display.getCurrentStage():setFocus( self, event.id )
            self.isFocus = true
            
            self.markX = self.x    -- store x location of object
            self.markY = self.y    -- store y location of object
        elseif self.isFocus then
            if event.phase == "moved" then
                local x = (event.x - event.xStart) + self.markX
                local y = (event.y - event.yStart) + self.markY
                if x >= 385 then
                    self.x, self.y = x, y    -- move object based on calculations above
                else
                    self.y = y;
                end
                if event.x > _w - 75 then 
                    self.y = event.y;
                    lineStartY = event.y;
                end
                if movingLine and ( self.markX - self.x <= 150 ) then movingLine:removeSelf(); end
            
                if ( self.markX - self.x  <= 150 ) then
                    thrustX = self.markX - self.x; thrustY = lineStartY - self.y;
                    movingLine = display.newLine( self.markX, lineStartY, self.x, self.y )
                end
            elseif event.phase == "ended"  and movingLine then
                meteor3:removeEventListener( "touch", meteor3 );
                display.getCurrentStage():setFocus( self, nil );
                self.isFocus = false;
                movingLine.y = _h + 500; --move line off screen once meteor is launched.
                self.x = _w * .94; self.y = ( _h / 2 ) + 90;
                
                meteor = display.newImage( "meteor1.png", 64, 64 );
                --meteor.xScale = .75; meteor.yScale = .75;
                physics.addBody( meteor, { density = 0, friction = .5, bounce = 0, radius = 32 } );
                meteor.x = _w - 45; meteor.y = lineStartY;
                --local xVelocity = ( event.xStart - event.x ) / 500;
                local xVelocity = thrustX / 500;
                if xVelocity < 0 then
                    xVelocity = -xVelocity;
                end
                --local yVelocity = ( meteor.y - event.y ) / 500;
                local yVelocity = thrustY / 500;
                meteor:applyLinearImpulse( -xVelocity, -yVelocity, meteor.x, meteor.y )
                meteorListeners();
            end
        end
        
        return true
    end
    
    meteorListeners();
end