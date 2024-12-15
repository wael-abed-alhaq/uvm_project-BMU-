// `include "rtl_def.sv" // Ensure rtl_alu_pkt_t is properly defined

import rtl_pkg::*;

class BMU_sequence_item extends uvm_sequence_item;    
  //data members
  rand logic rst_l;     // Reset
  rand logic scan_mode; // Scan control
  rand logic                valid_in;       // Valid
  rand rtl_alu_pkt_t        ap;             // predecodes
  rand logic                csr_ren_in;     // CSR select
  rand logic         [31:0] csr_rddata_in;  // CSR data
  rand logic signed  [31:0] a_in;           // A operand
  rand logic         [31:0] b_in;           // B operand
  logic [31:0] result_ff;  // final result
  logic error; //Error output signal
  
  //Utility and Field macros
  `uvm_object_utils_begin(BMU_sequence_item)  
  `uvm_field_int(rst_l, UVM_ALL_ON)
  `uvm_field_int(scan_mode, UVM_ALL_ON)
  `uvm_field_int(valid_in, UVM_ALL_ON)
  `uvm_field_int(ap, UVM_ALL_ON) 
  `uvm_field_int(csr_ren_in, UVM_ALL_ON)  
  `uvm_field_int(csr_rddata_in, UVM_ALL_ON)  
  `uvm_field_int(a_in, UVM_ALL_ON)
  `uvm_field_int(b_in, UVM_ALL_ON) 
  `uvm_field_int(result_ff, UVM_ALL_ON)  
  `uvm_field_int(error, UVM_ALL_ON)
  `uvm_object_utils_end
  
  //constructor
  function new(string name = "BMU_sequence_item");
    super.new(name);
  endfunction
  
  //function to print the data member(convert to string)
  function string convert2string();
    return $sformatf("rst_l: %0b, scan_mode: %0b, valid_in: %0b, ap: %p, \ncsr_ren_in: %0b, csr_rddata_in: 0x%h [Decimal: %d],\n a_in: 0x%h (%0b) [Decimal: %0d]   ,    b_in: 0x%h (%0b) [Decimal: %d],", rst_l, scan_mode, valid_in, ap, csr_ren_in, csr_rddata_in, csr_rddata_in, a_in, a_in,a_in, b_in, b_in,b_in);
  endfunction
  
  function string convert2string1();
    return $sformatf("rst_l: %0b, scan_mode: %0b, valid_in: %0b, ap: %p, csr_ren_in: 0x%h, csr_rddata_in: %0b, a_in: %0d   ,    b_in: %0d, result_ff: %0d, error: %0b", rst_l, scan_mode, valid_in, ap, csr_ren_in, csr_rddata_in, a_in, b_in, result_ff, error);
  endfunction
  
endclass
// `endif