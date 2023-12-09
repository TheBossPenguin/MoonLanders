module collisions(
    input [7:0] rocketX, asteroid1X, asteroid2X, asteroid3X, asteroid4X, asteroid5X, asteroid6X, asteroid7X, asteroid8X,
    input [6:0] rocketY, asteroid1Y, asteroid2Y, asteroid3Y, asteroid4Y, asteroid5Y, asteroid6Y, asteroid7Y, asteroid8Y,
	 input Clock, Reset,
	 input [7:0] object,
	 output reg collisionOccured,
	 output reg [7:0] oX,
	 output reg [6:0] oY
);

	parameter X_SCREEN_PIXELS = 11'd160;
	parameter Y_SCREEN_PIXELS = 11'd120;
	
	localparam
	ASTEROID1 = 8'd2,
	ASTEROID2 = 8'd3,
	ASTEROID3 = 8'd4,
	ASTEROID4 = 8'd5,
	ASTEROID5 = 8'd6,
	ASTEROID6 = 8'd7,
	ASTEROID7 = 8'd8,
	ASTEROID8 = 8'd9;
	
	wire [7:0] rocketLeft;
	wire [6:0] rocketTop;
	wire [7:0] rocketRight;
	wire [6:0] rocketBottom;
	
	
	wire [7:0] asteroid1Left; // x value of left
	wire [6:0] asteroid1Top; // y value of top
	wire [7:0] asteroid1Right; // x value of right
	wire [6:0] asteroid1Bottom; // y value of bottom
	
	wire [7:0] asteroid2Left; // x value of left
	wire [6:0] asteroid2Top; // y value of top
	wire [7:0] asteroid2Right; // x value of right
	wire [6:0] asteroid2Bottom; // y value of bottom
	
	wire [7:0] asteroid3Left; // x value of left
	wire [6:0] asteroid3Top; // y value of top
	wire [7:0] asteroid3Right; // x value of right
	wire [6:0] asteroid3Bottom; // y value of bottom
	
	wire [7:0] asteroid4Left; // x value of left
	wire [6:0] asteroid4Top; // y value of top
	wire [7:0] asteroid4Right; // x value of right
	wire [6:0] asteroid4Bottom; // y value of bottom
	
	wire [7:0] asteroid5Left; // x value of left
	wire [6:0] asteroid5Top; // y value of top
	wire [7:0] asteroid5Right; // x value of right
	wire [6:0] asteroid5Bottom; // y value of bottom
	
	wire [7:0] asteroid6Left; // x value of left
	wire [6:0] asteroid6Top; // y value of top
	wire [7:0] asteroid6Right; // x value of right
	wire [6:0] asteroid6Bottom; // y value of bottom
	
	wire [7:0] asteroid7Left; // x value of left
	wire [6:0] asteroid7Top; // y value of top
	wire [7:0] asteroid7Right; // x value of right
	wire [6:0] asteroid7Bottom; // y value of bottom
	
	wire [7:0] asteroid8Left; // x value of left
	wire [6:0] asteroid8Top; // y value of top
	wire [7:0] asteroid8Right; // x value of right
	wire [6:0] asteroid8Bottom; // y value of bottom

	parameter rocketWidth = 7;
	parameter rocketHeight = 15;
	parameter asteroidWidth = 4;
	parameter asteroidHeight = 4;
	
	assign rocketLeft = rocketX;
	assign rocketTop = rocketY;
	assign rocketRight = rocketX + rocketWidth - 1;
	assign rocketBottom = rocketY + rocketHeight - 1;
	
	assign asteroid1Left = asteroid1X;
	assign asteroid1Top = asteroid1Y;
	assign asteroid1Right = asteroid1X + asteroidWidth - 1;
	assign asteroid1Bottom = asteroid1Y + asteroidHeight - 1;
	
	assign asteroid2Left = asteroid2X;
	assign asteroid2Top = asteroid2Y;
	assign asteroid2Right = asteroid2X + asteroidWidth - 1;
	assign asteroid2Bottom = asteroid2Y + asteroidHeight - 1;
	
	assign asteroid3Left = asteroid3X;
	assign asteroid3Top = asteroid3Y;
	assign asteroid3Right = asteroid3X + asteroidWidth - 1;
	assign asteroid3Bottom = asteroid3Y + asteroidHeight - 1;
	
	assign asteroid4Left = asteroid4X;
	assign asteroid4Top = asteroid4Y;
	assign asteroid4Right = asteroid4X + asteroidWidth - 1;
	assign asteroid4Bottom = asteroid4Y + asteroidHeight - 1;
	
	assign asteroid5Left = asteroid5X;
	assign asteroid5Top = asteroid5Y;
	assign asteroid5Right = asteroid5X + asteroidWidth - 1;
	assign asteroid5Bottom = asteroid5Y + asteroidHeight - 1;
	
	assign asteroid6Left = asteroid6X;
	assign asteroid6Top = asteroid6Y;
	assign asteroid6Right = asteroid6X + asteroidWidth - 1;
	assign asteroid6Bottom = asteroid6Y + asteroidHeight - 1;
	
	assign asteroid7Left = asteroid7X;
	assign asteroid7Top = asteroid7Y;
	assign asteroid7Right = asteroid7X + asteroidWidth - 1;
	assign asteroid7Bottom = asteroid7Y + asteroidHeight - 1;
	
	assign asteroid8Left = asteroid8X;
	assign asteroid8Top = asteroid8Y;
	assign asteroid8Right = asteroid8X + asteroidWidth - 1;
	assign asteroid8Bottom = asteroid8Y + asteroidHeight - 1;


	 // check for rocket collision with any asteroid
	always @(posedge Clock) begin
		if (!Reset) begin
			collisionOccured <= 0;
		end

		collisionOccured <= 0;
		//Rocket width/height outlines object hitboxes 
		if ((rocketLeft <= asteroid1Right) && (rocketTop <= asteroid1Bottom) && (rocketRight >= asteroid1Left) && (rocketBottom >= asteroid1Top))
			collisionOccured <= 1;

		//Repeat all of rocket check with asteroid1 with other asteroids
		if ((rocketLeft <= asteroid2Right) && (rocketTop <= asteroid2Bottom) && (rocketRight >= asteroid2Left) && (rocketBottom >= asteroid2Top))
			collisionOccured <= 1;
			
		if ((rocketLeft <= asteroid3Right) && (rocketTop <= asteroid3Bottom) && (rocketRight >= asteroid3Left) && (rocketBottom >= asteroid3Top))
			collisionOccured <= 1;
			
		if ((rocketLeft <= asteroid4Right) && (rocketTop <= asteroid4Bottom) && (rocketRight >= asteroid4Left) && (rocketBottom >= asteroid4Top))
			collisionOccured <= 1;
			
		if ((rocketLeft <= asteroid5Right) && (rocketTop <= asteroid5Bottom) && (rocketRight >= asteroid5Left) && (rocketBottom >= asteroid5Top))
			collisionOccured <= 1;
			
		if ((rocketLeft <= asteroid6Right) && (rocketTop <= asteroid6Bottom) && (rocketRight >= asteroid6Left) && (rocketBottom >= asteroid6Top))
			collisionOccured <= 1;
			
		if ((rocketLeft <= asteroid7Right) && (rocketTop <= asteroid7Bottom) && (rocketRight >= asteroid7Left) && (rocketBottom >= asteroid7Top))
			collisionOccured <= 1;
			
		if ((rocketLeft <= asteroid8Right) && (rocketTop <= asteroid8Bottom) && (rocketRight >= asteroid8Left) && (rocketBottom >= asteroid8Top))
			collisionOccured <= 1;					
			
	end

	always @(*) begin //select the object to draw to drawBox
		case (object)
		1: begin
			oX = rocketX;
			oY = rocketY;
		end
	
		2: begin
			oX = asteroid1X;
			oY = asteroid1Y;
		end
	
		3: begin
			oX = asteroid2X;
			oY = asteroid2Y;
		end
		
		4: begin
			oX = asteroid3X;
			oY = asteroid3Y;
		end
		
		5: begin
			oX = asteroid4X;
			oY = asteroid4Y;
		end
		
		6: begin
			oX = asteroid5X;
			oY = asteroid5Y;
		end
		
		7: begin
			oX = asteroid6X;
			oY = asteroid6Y;
		end
		
		8: begin
			oX = asteroid7X;
			oY = asteroid7Y;
		end
		
		9: begin
			oX = asteroid8X;
			oY = asteroid8Y;
		end
			
		endcase
	end		
			 
	
endmodule
