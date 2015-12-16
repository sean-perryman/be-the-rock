module(..., package.seeall)
-- Be The Rock: Stars Module

genStars = function()
	local makeStar = function()
		local star = display.newCircle( _w - 75, math.random(display.contentHeight), 1 );
		star:setFillColor( math.random(200) + 55 );
		star:setReferencePoint( display.CenterReferencePoint );
		local moveStar = function()
			if star.x ~= nil then
				if star.x <= 0 then
					--print( "removing" );
					star:removeSelf();
				elseif star.x > 0 then
					star.x = star.x - 5;
				end
			end
		end
		timer.performWithDelay( 1, moveStar, display.contentWidth + 50 );
	end

	timer.performWithDelay( 75, makeStar, 0 );
end

initialStars = function()
	for i = 1, 20 do
		local star = display.newCircle( math.random( display.contentWidth - 50 ), math.random(display.contentHeight), 1 );
		star:setFillColor( math.random(200) + 55 );
		star:setReferencePoint( display.CenterReferencePoint );
		local moveStar = function()
			if star.x ~= nil then
				if star.x <= 0 then
					--print( "removing" );
					star:removeSelf();
				elseif star.x > 0 then
					star.x = star.x - 5;
				end
			end
		end
		timer.performWithDelay( 1, moveStar, display.contentWidth + 50 );
	end
end
