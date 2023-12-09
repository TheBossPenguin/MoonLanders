`timescale 1ns/1ns

module rocketPosition(
input collisionOccured,
input Reset, Clock,
input up, down,
output reg cleared,
output [6:0] yRocket,
output [7:0] xRocket
);

wire ySpeedEn;

parameter Y_SCREEN_PIXELS = 7'd120;
parameter startingYPosition = 7'd100;

reg [6:0]ycounter;

rateDividerY rateDivY(Reset, Clock, ySpeedEn);

assign xRocket = 8'd80;

always @ (posedge Clock) begin
if (!Reset || collisionOccured) begin
	ycounter <= startingYPosition;
	cleared <= 0;
end 
else begin
	if (ycounter == startingYPosition)
		cleared <= 0;
	if (ycounter == 0) begin
		cleared <= 1;
		ycounter<= startingYPosition;
	end
	else begin
	if (ySpeedEn == 1) begin
		if (up)
			ycounter <= ycounter - 1;
		else if (down && (ycounter < startingYPosition))
			ycounter <= ycounter + 1;
	end
	end
	end
end

assign yRocket = ycounter;

endmodule


module rateDividerY #(parameter CLOCK_FREQUENCY = 50000000) (
input Reset,
input Clock,
output ySpeedEn
);

reg [27:0] counter = 28'b0;

always @(posedge Clock) begin
	if (!Reset) begin
		counter <= 28'b0;
	end
	else if (counter == 0) begin
		counter <=CLOCK_FREQUENCY/17 - 1;
//		counter <= 28'b1000;
	end
	else
		counter <= counter - 1;
	end

assign ySpeedEn = (counter == 0) ? 1 : 0;

endmodule

