`timescale 1ns/1ns

module drawControl(moveDone, level, Clock, Reset, start, done, backgroundDone, plotSignal, backgroundSignal, object, drawObjectState, drawBackgroundState, moveEn);


input Clock, Reset, done, backgroundDone;
input start;
input [2:0]level;

output reg drawObjectState, drawBackgroundState;
output reg moveEn, moveDone;
output reg plotSignal;
output reg backgroundSignal;
output reg [7:0] object;

reg [5:0] current_state, next_state;
reg [28:0] rateDivider;
reg [28:0] frameCounter;
reg frameUpdate;

localparam 
DRAW_START = 5'd20,
DRAW_END = 5'd21,
DRAW_BACKGROUND = 5'd22,
WAIT_BACKGROUND = 5'd23,
CHECK_FINISHED = 5'd24,
DRAW_END_WAIT = 5'd25,

NEXT_FRAME = 5'd26,
MOVE = 5'd27,

DRAW_ROCKET = 5'd1,
DRAW_ASTEROID1 = 5'd2,
DRAW_ASTEROID2 = 5'd3,
DRAW_ASTEROID3 = 5'd4,
DRAW_ASTEROID4 = 5'd5,
DRAW_ASTEROID5 = 5'd6,
DRAW_ASTEROID6 = 5'd7,
DRAW_ASTEROID7 = 5'd8,
DRAW_ASTEROID8 = 5'd9,


WAIT_ROCKET = 5'd10,
WAIT1 = 5'd11,
WAIT2 = 5'd12,
WAIT3 = 5'd13,
WAIT4 = 5'd14,
WAIT5 = 5'd15,
WAIT6 = 5'd16,
WAIT7 = 5'd17,
WAIT8 = 5'd18;



always @(*)
begin: state_table
	case (current_state)
		DRAW_START: next_state = start ? DRAW_BACKGROUND : DRAW_START;
		DRAW_BACKGROUND: next_state = backgroundDone ? WAIT_BACKGROUND : DRAW_BACKGROUND;
		WAIT_BACKGROUND: next_state = DRAW_ROCKET;
		DRAW_ROCKET: next_state = done ? WAIT_ROCKET : DRAW_ROCKET;
		WAIT_ROCKET: next_state = DRAW_ASTEROID1;
		DRAW_ASTEROID1: next_state = done ? WAIT1 : DRAW_ASTEROID1;
		WAIT1: next_state = DRAW_ASTEROID2;	
		DRAW_ASTEROID2: next_state = done ? WAIT2: DRAW_ASTEROID2;	
		WAIT2: next_state = DRAW_ASTEROID3;	
		DRAW_ASTEROID3: next_state = done ? WAIT3: DRAW_ASTEROID3;	
		WAIT3: next_state = DRAW_ASTEROID4;	
		DRAW_ASTEROID4: next_state = done ? WAIT4 : DRAW_ASTEROID4;
		WAIT4: next_state = DRAW_ASTEROID5;	
		DRAW_ASTEROID5: next_state = done ? WAIT5 : DRAW_ASTEROID5;
		WAIT5: next_state = DRAW_ASTEROID6;	
		DRAW_ASTEROID6: next_state = done ? WAIT6 : DRAW_ASTEROID6;
		WAIT6: next_state = DRAW_ASTEROID7;			
		DRAW_ASTEROID7: next_state = done ? WAIT7 : DRAW_ASTEROID7;
		WAIT7: next_state = DRAW_ASTEROID8;	
		DRAW_ASTEROID8: next_state = done ? WAIT8 : DRAW_ASTEROID8;
		WAIT8: next_state = NEXT_FRAME;	
		 
		NEXT_FRAME: next_state = frameUpdate ? CHECK_FINISHED : NEXT_FRAME;
		
		MOVE: next_state = done ? CHECK_FINISHED : MOVE;
		
		CHECK_FINISHED: next_state = (level == 3'b100) ? DRAW_END : DRAW_BACKGROUND;
		
		DRAW_END: next_state = start ? DRAW_END_WAIT : DRAW_END;
		DRAW_END_WAIT: next_state = start ? DRAW_END_WAIT : DRAW_START;
		
		
		default: next_state = DRAW_START;
	endcase
end


always @(*)
begin: enable_signals
	plotSignal = 0;
	backgroundSignal = 0;
	object = 0;
	drawBackgroundState = 0;
	drawObjectState = 0;
	
case (current_state)

	DRAW_START: begin
	backgroundSignal = 1;
	plotSignal = 1;
	drawBackgroundState = 1;
	end
	
	DRAW_END: begin
	backgroundSignal = 1;
	plotSignal = 1;
	drawBackgroundState = 1;
	end
	
	DRAW_BACKGROUND: begin
	backgroundSignal = 1;
	plotSignal = 1;
	drawBackgroundState = 1;
	end
	
	DRAW_ROCKET: begin
	object = 4'd1;
	plotSignal = 1;
	drawObjectState = 1;
	end
	
	DRAW_ASTEROID1: begin
	object = 4'd2;
	plotSignal = 1;
	drawObjectState = 1;
	end
	
	DRAW_ASTEROID2: begin
	object = 4'd3;
	plotSignal = 1;
	drawObjectState = 1;
	end
	
	DRAW_ASTEROID3: begin
	object = 4'd4;
	plotSignal = 1;
	drawObjectState = 1;
	end
	
	DRAW_ASTEROID4: begin
	object = 4'd5;
	plotSignal = 1;
	drawObjectState = 1;
	end
	
	DRAW_ASTEROID5: begin
	object = 4'd6;
	plotSignal = 1;
	drawObjectState = 1;
	end
	
	DRAW_ASTEROID6: begin
	object = 4'd7;
	plotSignal = 1;
	drawObjectState = 1;
	end
	
	DRAW_ASTEROID7: begin
	object = 4'd8;
	plotSignal = 1;
	drawObjectState = 1;
	end
	
	DRAW_ASTEROID8: begin
	object = 8'd9;
	plotSignal = 1;
	drawObjectState = 1;
	end
	
	MOVE: begin
	moveEn = 1;
	end
	
	endcase
end

	
	
	//current state registers
always @(posedge Clock)
begin: state_FFs
	if (!Reset) begin
		current_state <= DRAW_START;
		frameUpdate <= 0;
		frameCounter <= 0;
		rateDivider <= 833333; //50 MHz clock to 60Hz
//		rateDivider <= 40; //500Hz simulation clock to 60Hz
	end
	else begin
		current_state <= next_state;
			if (current_state == NEXT_FRAME) begin
				if (frameCounter == rateDivider) begin
					frameCounter <= 0;
					frameUpdate <= 1;
				end
				else begin
					frameCounter <= frameCounter + 1;
					frameUpdate <= 0;
				end		
		end
	end
end


endmodule
	
	

