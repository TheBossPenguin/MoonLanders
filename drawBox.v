`timescale 1ns/1ns

module drawBox(
input Clock,
input Reset,
input plotSignal, 
input backgroundSignal,
input [7:0] object,
input [7:0] xCoord,
input [6:0] yCoord,
output [7:0] oX,
output [6:0] oY,
output [2:0] oColour,
output reg oDone
);

localparam
ROCKET = 8'd1,
ASTEROID1 = 8'd2,
ASTEROID2 = 8'd3,
ASTEROID3 = 8'd4,
ASTEROID4 = 8'd5,
ASTEROID5 = 8'd6,
ASTEROID6 = 8'd7,
ASTEROID7 = 8'd8,
ASTEROID8 = 8'd9;


parameter X_SCREEN_PIXELS = 8'd160;
parameter Y_SCREEN_PIXELS = 7'd120;

parameter rocketWidth = 8'd7;
parameter rocketHeight = 7'd15;
parameter asteroidWidth = 8'd4;
parameter asteroidHeight = 7'd4;

reg [7:0] width;
reg [6:0] height;

reg [7:0] x_counter;
reg [6:0] y_counter;
reg [2:0] colour;
reg startDraw;
			 
always @(*) begin
	if (object == 8'd1) begin
		width = rocketWidth;
		height = rocketHeight;
	end
	else if (object > 8'd1) begin
		width = asteroidWidth;
		height = asteroidHeight;
	end
end


always @ (posedge Clock) begin
if ((!plotSignal) || (!Reset)) begin
	x_counter <= 0;
	y_counter <= 0;
	oDone <= 0;
	startDraw <= 0;
end
else if (plotSignal && (!oDone) && (object > 4'd0) && (!backgroundSignal)) begin
	if (!startDraw) begin
		startDraw <= 1;
		x_counter <= 0;
		y_counter <= 0;
	end
	else if (startDraw) begin
			if (x_counter == width - 1) begin
				x_counter <= 0;
				if (y_counter == height-1) begin
					oDone <= 1;
				end
				else
					y_counter <= y_counter + 1;
			end
			else if (x_counter < width - 1)
				x_counter <= x_counter + 1;
	end
end
end


wire [2:0] colourAsteroid;
wire [2:0] colourRocket;

wire [9:0] memoryAddress;


always @(*) begin
	if (object == 4'd1)
		colour = colourRocket;
	else if (object > 4'd1)
		colour = colourAsteroid;
end

//always @(*) begin
//	if (object == 8'd1)
//		colour = 3'b010;
//	else if (object > 8'd1)
//		colour = 3'b100;
//end

	asteroid a1(.address(memoryAddress), .clock(Clock), .q(colourAsteroid));
	rocket r1(.address(memoryAddress), .clock(Clock), .q(colourRocket));
	



assign oX = xCoord + x_counter;
assign oY = yCoord + y_counter;
assign oColour = colour;
assign memoryAddress = y_counter * width + x_counter;



endmodule
