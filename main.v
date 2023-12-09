`timescale 1ns/1ns


module main( SW, CLOCK_50, KEY, VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B, HEX0);


input CLOCK_50;
input [9:0] SW;
input [3:0] KEY;

output VGA_CLK, VGA_HS,	VGA_VS, VGA_BLANK_N, VGA_SYNC_N;
output [7:0] VGA_R, VGA_G, VGA_B;
output [6:0] HEX0;

wire Clock, Reset;
assign Clock = CLOCK_50;

wire start, up, down ;

assign start = !KEY[0];
assign Reset = KEY[1];
assign up = !KEY[2];
assign down = !KEY[3];


wire drawgroundState, drObjectState;

//VGA Variables
wire [7:0] vgaX; //these get sent directly to the VGA
wire [6:0] vgaY;
wire [2:0] vgaColour;

assign drawgroundState= SW[2];
assign drObjectState= SW[3];

wire [7:0] xRocket;
wire [6:0] yRocket;
wire oDone, backgroundDone, plotSignal, backgroundSignal, drawObjectState, drawBackgroundState;
wire moveDone;
wire [7:0] object;
wire [2:0] level;
wire upEn, downEn, clear, moveEn;
wire [7:0] xCoord;
wire [6:0] yCoord;
wire [7:0] oX;
wire [6:0] oY;
wire [2:0] colour, backgroundColour;
wire [7:0] backgroundX;
wire [6:0] backgroundY;
wire [7:0] asteroid1X, asteroid2X, asteroid3X, asteroid4X, asteroid5X, asteroid6X, asteroid7X, asteroid8X;
wire [6:0] asteroid1Y, asteroid2Y, asteroid3Y, asteroid4Y, asteroid5Y, asteroid6Y, asteroid7Y, asteroid8Y;

levelsControl Lvl(start, CLOCK_50, KEY[1], clear, level);

drawControl drawFSM(moveDone, level , CLOCK_50, KEY[1], start, oDone, backgroundDone, 
plotSignal, backgroundSignal, object, drawObjectState, drawBackgroundState, moveEn);

rocketControl rocketCtrl(up, down, CLOCK_50, KEY[1], upEn, downEn);

rocketPosition rocketPos(collisionOccured, KEY[1], CLOCK_50, upEn, downEn, clear, yRocket, xRocket);

asteroidsPosition astPos(collisionOccured, CLOCK_50, KEY[1],level,object, moveEn, asteroid1X, asteroid2X, 
asteroid3X, asteroid4X, asteroid5X, asteroid6X, asteroid7X, asteroid8X , 
asteroid1Y, asteroid2Y, asteroid3Y, asteroid4Y, asteroid5Y, asteroid6Y, asteroid7Y, asteroid8Y, moveDone);

drawBox drawObject(CLOCK_50, KEY[1], plotSignal, backgroundSignal, object, xCoord, yCoord, oX, oY, colour, oDone);

collisions COLHandler( xRocket, asteroid1X, asteroid2X, asteroid3X, asteroid4X, asteroid5X, 
asteroid6X, asteroid7X, asteroid8X, yRocket, asteroid1Y, 
asteroid2Y, asteroid3Y, asteroid4Y, asteroid5Y, asteroid6Y, asteroid7Y, asteroid8Y,
CLOCK_50, KEY[1], object, collisionOccured, xCoord, yCoord);

drawBackground BACKGROUND(CLOCK_50, KEY[1], backgroundSignal, plotSignal, level, backgroundX, backgroundY,
  backgroundColour ,backgroundDone);
	



vga_adapter VGA(
		.resetn(KEY[1]),
		.clock(CLOCK_50),
		.colour(vgaColour),
		.x(vgaX),
		.y(vgaY),
		.plot(plotSignal),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_BLANK(VGA_BLANK_N),
		.VGA_SYNC(VGA_SYNC_N),
		.VGA_CLK(VGA_CLK));
	defparam VGA.RESOLUTION = "160x120";
	defparam VGA.MONOCHROME = "FALSE";
	defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
	defparam VGA.BACKGROUND_IMAGE = "black.mif";
	
	//HEX display 
	
	lvlhex displayHex(Reset, CLOCK_50, level ,HEX0);
	
	
	reg [7:0] vgaXOut;
	reg [6:0] vgaYOut;
	reg [2:0] vgaColourOut;
	
	
	always @(*)
	begin
		if (drawBackgroundState||drawgroundState) begin
		vgaXOut = backgroundX;
		vgaYOut = backgroundY;
		vgaColourOut = backgroundColour;
		end
		else if(drawObjectState||drObjectState) begin
		
		vgaXOut = oX;
		vgaYOut = oY;
		vgaColourOut = colour;
		
		end
		
	end	
	
	
	assign vgaX = vgaXOut;
	assign vgaY = vgaYOut;
	assign vgaColour = vgaColourOut;
	
	
	
endmodule
