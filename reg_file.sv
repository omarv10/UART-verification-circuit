
module reg_file
   #(
    parameter DATA_WIDTH = 8, // number of bits in a word
              ADDR_WIDTH = 2  // number of address bits
   )
   (
    input logic clk,
    input logic wr_en,
    input logic [ADDR_WIDTH-1:0] w_addr, r_addr,
    input logic [DATA_WIDTH-1:0] w_data,
    output logic [DATA_WIDTH-1:0] r_data
   );

   //signal declaration
   logic [DATA_WIDTH-1:0] array_reg [2**ADDR_WIDTH-1:0];  // register array


   // body
   // register file write operation
   always_ff @(posedge clk)
      if (wr_en)
         array_reg[w_addr] <= w_data;
   // register file read operation
   assign r_data = array_reg[r_addr];
   
endmodule


