`timescale 1ns/1ns

module levelsControl( 
input start,	
input Clock,
input Reset,
input clear,
output reg [2:0]level
);



reg [4:0] current_state, next_state;

localparam
START = 5'd0,
L1 = 5'd1,
L2 = 5'd2,
L3 = 5'd3,
FINISH = 5'd4,
FINISH_GO = 5'd5,
START_GO = 5'd6,

L1_CLEAR = 5'd11,
L2_CLEAR = 5'd12,
L3_CLEAR = 5'd13;

always @(*)
begin: state_table
	case (current_state)
		START: next_state = start ? L1 : START;
		L1: next_state = clear ? L1_CLEAR : L1;
		L1_CLEAR: next_state = clear ? L1_CLEAR : L2;
		L2: next_state = clear ? L2_CLEAR : L2;
		L2_CLEAR: next_state = clear ? L2_CLEAR : L3;
		L3: next_state = clear ? L3_CLEAR : L3;
		L3_CLEAR: next_state = clear ? L3_CLEAR : FINISH;
		FINISH: next_state = start ? FINISH_GO : FINISH;
		FINISH_GO: next_state = start ? FINISH_GO : START;
		default: next_state = START;
	endcase
end

always @(*)
begin: enable_signals
        level = 3'b000;
		  
case (current_state)

			START: begin
			level = 3'b000;
			end
			
			L1: begin
			level = 3'b001;
			end
		
			L1_CLEAR: begin
			level = 3'b001;
			end
			
			L2: begin
         level = 3'b010;
		   end
			
			L2_CLEAR: begin
			level = 3'b010;
			end

			L3: begin
			level = 3'b011;
			end
			
			L3_CLEAR: begin
			level = 3'b011;
			end
			
			FINISH: begin
			level = 3'b100;
			end
			
			FINISH_GO: begin
			level = 3'b100;
			end
endcase
end

//current state registers
always @(posedge Clock)
begin: state_FFs
	if (!Reset)
		current_state <= START;
	else
		current_state <= next_state;
end
endmodule




