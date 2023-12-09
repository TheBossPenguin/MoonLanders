`timescale 1ns/1ns

module drawBackground(Clock, Reset, backgroundSignal, plotSignal, currentLevel, backgroundX, backgroundY, backgroundColour, backgroundDone);
parameter X_SCREEN_PIXELS = 8'd160;
parameter Y_SCREEN_PIXELS = 8'd120;

input Clock, Reset;
input [2:0] currentLevel;

input backgroundSignal;
input plotSignal;
output [7:0] backgroundX;
output [6:0] backgroundY;
output reg[2:0] backgroundColour;
output reg backgroundDone;

reg [7:0] x_counter;
reg [6:0] y_counter;
reg startDraw;


always @ (posedge Clock) begin
if (!plotSignal || Reset) begin
	x_counter <= 0;
	y_counter <= 0;
	backgroundDone <= 0;
	startDraw <= 0;
end

if(backgroundSignal) begin
	if (!startDraw) begin
		x_counter <= 0;
		y_counter <= 0;
		startDraw <= 1;
	end
	else if (startDraw) begin
			if (x_counter == X_SCREEN_PIXELS - 1) begin
				x_counter <= 0;
				if (y_counter == Y_SCREEN_PIXELS - 1) begin
					background Done <= 1;
				end
				else
					y_counter <= y_counter + 1;
			end
			else if (x_counter < X_SCREEN_PIXELS - 1)
				x_counter <= x_counter + 1;
	end
end
end

wire [2:0] colourStart;
wire [2:0] colourL1;
wire [2:0] colourL2;
wire [2:0] colourL3;
wire [2:0] colourFinish;

wire [14:0] memoryAddress;

assign memoryAddress = y_counter*X_SCREEN_PIXELS + x_counter; //current address to read from

	startScreen start(.address(memoryAddress), .clock(Clock), .q(colourStart));
	level1 L1(.address(memoryAddress), .clock(Clock), .q(colourL1));
	level2 L2(.address(memoryAddress), .clock(Clock), .q(colourL2));
	level3 L3(.address(memoryAddress), .clock(Clock), .q(colourL3));
	finishScreen finish(.address(memoryAddress), .clock(Clock), .q(colourFinish));
	
	
always @(*) begin
	if (currentLevel == 3'b000)
		backgroundColour = colourStart;
	else if (currentLevel == 3'b001)
		backgroundColour = colourL1;
	else if (currentLevel == 3'b010)
		backgroundColour = colourL2;
	else if (currentLevel == 3'b011)
		backgroundColour = colourL3;	
	else if (currentLevel == 3'b100)
		backgroundColour = colourFinish;
end


assign backgroundX = x_counter;
assign backgroundY = y_counter;


endmodule
