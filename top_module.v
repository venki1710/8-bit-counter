`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2024 12:05:48
// Design Name: 
// Module Name: top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_module(clk_100MHz,reset,cathode,anode,dp);
input clk_100MHz,reset;
output dp;
output [7:0] anode;
output [6:0] cathode;
wire [7:0] count;
wire [3:0] ones,tens,hundreds;
wire clk_1Hz, clk_10KHz;
assign dp = 1'b1;
eight_bit_counter(clk_1Hz,reset,count);
binary_to_BCD(clk_100MHz,count,ones,tens,hundreds);
clock_divider_1Hz Clk_1Hz(clk_100MHz,reset,clk_1Hz);
clock_divider_10KHz CLK_10KHz(clk_100MHz,reset,clk_10KHz);
seven_segment_controller seven_segment_controller(clk_10KHz,reset,ones,tens,hundreds,cathode,anode);
endmodule



module eight_bit_counter(clk_1Hz,reset,count);
input clk_1Hz,reset;
output reg [7:0] count;
always @(posedge clk_1Hz)
begin
    if(reset==1'b1 || count==8'b11111111)
    begin
    count <= 8'b00000000;
    end
    else
    begin
        count <= count + 1; 
    end
    
end
endmodule


module binary_to_BCD(clk_100MHz,count,ones,tens,hundreds);
input clk_100MHz;
input [7:0] count;
output reg [3:0] ones,tens,hundreds;
reg [7:0] temp;
always @(*)
begin
    hundreds = count/ 100;
    temp = count % 100;
    tens = temp/10;
    ones = temp % 10;
end
endmodule


// clcok divider circuit for 1Hz;
module clock_divider_1Hz(clk_100MHz,reset,clk_1Hz);
input clk_100MHz,reset;
output reg clk_1Hz;
reg [25:0] counter;
always @(posedge clk_100MHz)
begin
    if(reset==1'b1)
    begin
    counter <= 26'b0;
    clk_1Hz <= 1'b0;
    end
    else
    begin
        if(counter == 26'd49999999)
        begin
        counter <= 26'b0;
        clk_1Hz <= ~clk_1Hz;
        end
        else
        begin
        counter <= counter + 1;
        end
    end
end
endmodule


// clock_divider for the clk_10KHz

module clock_divider_10KHz(clk_100MHz,reset,clk_10KHz);
parameter value = 4999;
input clk_100MHz,reset;
output reg clk_10KHz;
integer count =0;
always @(posedge clk_100MHz)
begin
    if(reset ==1'b1)
    begin
        count <= 0;
        clk_10KHz = 1'b0;
    end
    else
    begin
        if(count == value)
            begin
                clk_10KHz = ~clk_10KHz;
                count = 0;
        end
    else
        begin
            count = count + 1;
        end
    end
end
endmodule


module seven_segment_controller(clk_10KHz,reset,ones,tens,hundreds,cathode,anode);
    parameter zero = 4'b0000, one = 4'b0001, two = 4'b0010, three = 4'b0011, 
              four = 4'b0100, five = 4'b0101, six = 4'b0110, seven = 4'b0111, 
              eight = 4'b1000, nine = 4'b1001;

    parameter zero_dis = 7'b0000001, one_dis = 7'b1001111, two_dis = 7'b0010010, 
              three_dis = 7'b0000110, four_dis = 7'b1001100, five_dis = 7'b0100100,
              six_dis = 7'b0100000, seven_dis = 7'b0001111, eight_dis = 7'b0000000,
              nine_dis = 7'b0000100;

    parameter ones_place = 8'b11111110, tens_place = 8'b11111101, 
              hundred_place = 8'b11111011, thousands_place = 8'b11110111;
    input clk_10KHz,reset;
    input [3:0] ones,tens,hundreds;
    output reg [6:0] cathode;
    output reg [7:0] anode;

    reg [1:0] count; 
    reg [3:0] value;

    always @(posedge clk_10KHz or posedge reset) begin
        if (reset) begin
            count <= 2'b00;
        end else begin
            count <= count + 1;
        end
    end

    always @(*) begin
        case (count)
            2'b00: value = ones;
            2'b01: value = tens;
            2'b10: value = hundreds;
            2'b11: value = ones;
            default: value = 4'b0000;
        endcase
    end

    always @(*) begin
        case (value)
            zero: cathode = zero_dis;
            one: cathode = one_dis;
            two: cathode = two_dis;
            three: cathode = three_dis;
            four: cathode = four_dis;
            five: cathode = five_dis;
            six: cathode = six_dis;
            seven: cathode = seven_dis;
            eight: cathode = eight_dis;
            nine: cathode = nine_dis;
            default: cathode = 7'b1111111; 
        endcase
    end

    always @(*) begin
        case (count)
            2'b00: anode = ones_place;
            2'b01: anode = tens_place;
            2'b10: anode = hundred_place;
            2'b11: anode = ones_place;
            default: anode = 8'b11111111; 
        endcase
    end
endmodule


