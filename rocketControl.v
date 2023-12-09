`timescale 1ns/1ns

module rocketControl(
input up,
input down,
input Clock,
input Reset,
output reg upEn,
output reg downEn
);

reg [2:0] current_state, next_state;

localparam
STILL = 3'd0,
UP = 3'd1,
DOWN = 3'd2;

always @(*)
begin: state_table
	case (current_state)
	STILL: next_state = up ? UP : STILL | down ? DOWN : STILL;
	UP: next_state = up ? UP : STILL;
	DOWN: next_state = down ? DOWN : STILL;
	default: next_state = STILL;
	endcase
end

always @(*)
begin: enable_signals
        upEn = 1'b0;
        downEn = 1'b0;
		  
case (current_state)		
			
			UP: begin
        upEn = 1'b1;
		  end

			DOWN: begin
			downEn = 1'b1;
			end
			
endcase
end

always @(posedge Clock)
begin: state_FFs
	if (!Reset)
		current_state <= STILL;
	else
		current_state <= next_state;
end

endmodule
