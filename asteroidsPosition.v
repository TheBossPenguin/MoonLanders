module asteroidsPosition(
input collisionOccured,
input Clock,
input Reset,
input [2:0] Level,
input [7:0] object,
input moveEn,
output [7:0] oX1, oX2, oX3, oX4, oX5, oX6, oX7, oX8,
output [6:0] oY1, oY2, oY3, oY4, oY5, oY6, oY7, oY8,
output reg oDone
);

reg moveAsteroids;

//rateDividerX rateDivX(Reset, Clock, Level, xSpeedEn);


 parameter X_SCREEN_PIXELS = 8'd160;
 parameter Y_SCREEN_PIXELS = 7'd120;
 
 reg [7:0] x1, x2, x3, x4, x5, x6, x7, x8;
 reg [6:0] y1, y2, y3, y4, y5, y6, y7, y8;
 

localparam
ASTEROID1 = 8'd2,
ASTEROID2 = 8'd3,
ASTEROID3 = 8'd4,
ASTEROID4 = 8'd5,
ASTEROID5 = 8'd6,
ASTEROID6 = 8'd7,
ASTEROID7 = 8'd8,
ASTEROID8 = 8'd9;

reg [25:0] counter;
	always @(posedge Clock) begin
		if (!Reset) begin
			counter <= 6'b0;
		end
		
		if (moveEn) begin
			if (counter == 0) begin
			moveAsteroids <= 1;
				case (Level)
					3'b001: counter <= 26'd2500000;
					3'b010:counter <= 26'd2000000;
					3'b011: counter <= 26'd1500000;
					default: counter <=26'd10;
				endcase
			end
			else begin
				moveAsteroids <= 0;
				counter <= counter - 1;
		end
	end
	end

always @ (posedge Clock) begin
	if (!Reset || collisionOccured) begin
		x1 <= 8'd0;
		x2 <= 8'd10;
		x3 <= 8'd20;
		x4 <= 8'd30;
		x5 <= 8'd40;
		x6 <= 8'd50;
		x7 <= 8'd60;
		x8 <= 8'd70;
		
		y1 <= 7'd20;
		y2 <= 7'd30;
		y3 <= 7'd40;
		y4 <= 7'd50;
		y5 <= 7'd60;
		y6 <= 7'd70;
		y7 <= 7'd80;
		y8 <= 7'd90;
	end


	if (!moveEn)
		oDone <= 0;	
	else if (moveAsteroids) begin
	
			if (x1 == X_SCREEN_PIXELS - 1)
				x1 <= 0;
			else
				x1 <= x1 + 1;


			if (x2 == 0)
				x2 <= X_SCREEN_PIXELS;
			else
				x2 <= x2 - 1;

		
			if (x3 == X_SCREEN_PIXELS - 1)
				x3 <= 0;
			else
				x3 <= x3 + 1;

		
			if (x4 == 0)
				x4 <= X_SCREEN_PIXELS;
			else
				x4 <= x4 - 1;


			if (x5 == 0)
				x5 <= X_SCREEN_PIXELS;
			else
				x5 <= x5 - 1;


			if (x6 == X_SCREEN_PIXELS - 1)
				x6 <= 0;
			else
				x6 <= x6 + 1;


			if (x7 == 0)
				x7 <= X_SCREEN_PIXELS;
			else
				x7 <= x7 - 1;


			if (x8 == X_SCREEN_PIXELS - 1)
				x8 <= 0;
			else
				x8 <= x8 + 1;

		oDone <= 1;
		end
end

assign oX1 = x1;
assign oX2 = x2;
assign oX3 = x3;
assign oX4 = x4;
assign oX5 = x5;
assign oX6 = x6;
assign oX7 = x7;
assign oX8 = x8;

assign oY1 = y1;
assign oY2 = y2;
assign oY3 = y3;
assign oY4 = y4;
assign oY5 = y5;
assign oY6 = y6;
assign oY7 = y7;
assign oY8 = y8;


endmodule
			

//module rateDividerX #(parameter CLOCK_FREQUENCY = 50000000) (
//input Reset,
//input Clock,
//input [2:0]level,
//output xSpeedEn
//);
//
//reg [27:0] counter = 28'b0;
//
//always @(posedge Clock) begin
//	if (!Reset) begin
//		counter <= 28'b0;
//	end
//	else if (counter == 0) begin
//		counter <=CLOCK_FREQUENCY/4 - 1;
////		case (level)
////		3'b001: counter <=CLOCK_FREQUENCY/4 - 1;
////		3'b010:counter <=CLOCK_FREQUENCY/8 - 1;
////		3'b011: counter <=CLOCK_FREQUENCY/12 - 1;
////		default: counter = CLOCK_FREQUENCY - 1;
////		endcase
////		counter <= 28'b1000;
//	end
//	else
//		counter <= counter - 1;
//end
//
//assign xSpeedEn = (counter == 0) ? 1 : 0;
//endmodule
			
			
			
			
			