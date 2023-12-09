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
output [2:0] backgroundColour;
output reg backgroundDone;

reg [7:0] x_counter;
reg [6:0] y_counter;
reg [2:0] colour;
reg startDraw;


always @ (posedge Clock) begin
if ((!backgroundSignal) || (!Reset)) begin
	x_counter <= 0;
	y_counter <= 0;
	backgroundDone <= 0;
	startDraw <= 0;
end
else if (backgroundSignal && (!backgroundDone)) begin
	if (!startDraw) begin
		startDraw <= 1;
		x_counter <= 0;
		y_counter <= 0;
	end
	else if (startDraw) begin
			if (x_counter == X_SCREEN_PIXELS - 1) begin
				x_counter <= 0;
				if (y_counter == Y_SCREEN_PIXELS - 1) begin
					backgroundDone <= 1;
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

	start startScreen(.address(memoryAddress), .clock(Clock), .q(colourStart));
	level1 L1(.address(memoryAddress), .clock(Clock), .q(colourL1));
	level2 L2(.address(memoryAddress), .clock(Clock), .q(colourL2));
	level3 L3(.address(memoryAddress), .clock(Clock), .q(colourL3));
	finish finishScreen(.address(memoryAddress), .clock(Clock), .q(colourFinish));
	
	
always @(*) begin
	if (currentLevel == 3'b000)
		colour = colourStart;
	else if (currentLevel == 3'b001)
		colour = colourL1;
	else if (currentLevel == 3'b010)
		colour = colourL2;
	else if (currentLevel == 3'b011)
		colour = colourL3;	
	else if (currentLevel == 3'b100)
		colour = colourFinish;
end

//always @(*) begin
//	if (currentLevel == 3'b000)
//		colour = 3'b101;
//	else if (currentLevel == 3'b001)
//		colour = 3'b111;
//	else if (currentLevel == 3'b010)
//		colour = 3'b011;
//	else if (currentLevel == 3'b011)
//		colour = 3'b110;	
//	else if (currentLevel == 3'b100)
//		colour = 3'b000;
//end


assign backgroundX = x_counter;
assign backgroundY = y_counter;
assign backgroundColour = colour;


endmodule
