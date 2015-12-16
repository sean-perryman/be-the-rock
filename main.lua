--Be the rock
local version = 0.16;

debugText = false;
debugMem = false;
debugMove = false;
debugMoveCoords = false;
debugMoveLV = false;
--physics.setDrawMode( "debug" );

print_r = require( "exFuncs" ).print_r;
local monitorMemory = require( "exFuncs" ).monitorMemory;
local physics = require( "physics" );

local bounds = require( "bounds" ).bounds;
local meteorStage = require( "genMeteor" ).meteorStage;
local initialStars = require( "stars" ).initialStars;
local genStars = require( "stars" ).genStars;
local createShip = require( "spaceShip" ).createShip;

_w = display.contentWidth;
_h = display.contentHeight;
_pw = display.pixelWidth;
_ph = display.pixelHeight;
_aw = display.actualContentWidth;
_ah = display.actualContentHeight;
_vw = display.viewableContentWidth;
_vh = display.viewableContentHeight;
_cx = display.contentCenterX;
_cy = display.contentCenterY;

--main display group
displayMain = display.newGroup();

--start physics
physics.start();
physics.setGravity( 0, 0 );

createShip( 50 );
meteorStage();
initialStars();
genStars();
bounds();

if debugMem then monitorMemory(); end