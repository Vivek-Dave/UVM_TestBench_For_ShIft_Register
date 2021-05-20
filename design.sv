module sh_design(in,out,rst,clk);
    input rst;
    input clk;
    input  [3:0] in;
    output reg [3:0] out;

    reg [3:0] temp1,temp2;

    always@(posedge clk or posedge  rst)
    begin
        if(rst==1) begin
            out<=0;
            temp1<=0;
            temp2<=0;
        end
        else begin
            temp1<=in;
            temp2<=temp1;
            out<=temp2;
        end
    end

endmodule