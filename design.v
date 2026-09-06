module sequence_detector_1101_overlapping (
    input  clk,
    input  reset,
    input  din,
    output reg detected
);

    reg [2:0] state;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            state <= S0;
            detected <= 1'b0;
        end

        else begin

            detected <= 1'b0;

            case (state)
                S0: begin
                    if (din)
                        state <= S1;
                    else
                        state <= S0;
                end
                S1: begin
                    if (din)
                        state <= S2;
                    else
                        state <= S0;
                end
                S2: begin
                    if (din)
                        state <= S2;
                    else
                        state <= S3;
                end
                S3: begin
                    if (din) begin
                        detected <= 1'b1;
                        state <= S1;
                    end
                    else
                        state <= S0;
                end

                default:
                    state <= S0;

            endcase
        end

    end

endmodule