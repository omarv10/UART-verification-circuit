
module fifo_ctrl
#(
    parameter ADDR_WIDTH = 4 // number of bits in a word
   )
   (
    input logic clk, reset,
    input logic rd, wr,
    output logic [ADDR_WIDTH-1:0] w_addr,
    output logic empty, full,
    output logic [ADDR_WIDTH-1:0] r_addr
   );

   //signal declaration
 //  logic [ADDR_WIDTH-1:0] array_reg [2**W-1:0];  // register array
   logic [ADDR_WIDTH-1:0] w_ptr_logic, w_ptr_next, w_ptr_succ;
   logic [ADDR_WIDTH-1:0] r_ptr_logic, r_ptr_next, r_ptr_succ;
   logic full_logic, empty_logic, full_next, empty_next;
   logic wr_en;



   // fifo control logic
   // register for read and write pointers
   always_ff @(posedge clk, posedge reset)
      if (reset)
         begin
            w_ptr_logic <= 0;
            r_ptr_logic <= 0;
            full_logic <= 1'b0;
            empty_logic <= 1'b1;
         end
      else
         begin
            w_ptr_logic <= w_ptr_next;
            r_ptr_logic <= r_ptr_next;
            full_logic <= full_next;
            empty_logic <= empty_next;
         end

   // next-state logic for read and write pointers
   always_comb
      begin
      // successive pointer values
      w_ptr_succ = w_ptr_logic + 1;
      r_ptr_succ = r_ptr_logic + 1;
      // default: keep old values
      w_ptr_next = w_ptr_logic;
      r_ptr_next = r_ptr_logic;
      full_next = full_logic;
      empty_next = empty_logic;
      case ({wr, rd})
         // 2'b00:  no op
         2'b01: // read
            if (~empty_logic) // not empty
               begin
                  r_ptr_next = r_ptr_succ;
                  full_next = 1'b0;
                  if (r_ptr_succ==w_ptr_logic)
                     empty_next = 1'b1;
               end
         2'b10: // write
            if (~full_logic) // not full
               begin
                  w_ptr_next = w_ptr_succ;
                  empty_next = 1'b0;
                  if (w_ptr_succ==r_ptr_logic)
                     full_next = 1'b1;
               end
         2'b11: // write and read
            begin
               w_ptr_next = w_ptr_succ;
               r_ptr_next = r_ptr_succ;
            end
      endcase
   end

   // output
   assign w_addr = w_ptr_logic;
   assign r_addr = r_ptr_logic;   
   assign full = full_logic;
   assign empty = empty_logic;

endmodule
