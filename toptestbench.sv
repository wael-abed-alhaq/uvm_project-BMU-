`include "package.sv"

module BMU_testbench;
  logic clk; 
  logic rst; 
  always #5 clk=~clk; 
  
  //Generate Clock and Reset Signals.
  initial begin 
    clk=0;
    rst=0; 
    #1;
    rst=1;
    #1;
    rst=0;
  end
  
  
  //instantiate the interface 
  BMU_interface intf(.clk(clk));
  
  Bit_Manipulation_Unit BMU(
    .clk(clk),                  // Connect clock signal
    .rst_l(intf.rst_l),              // Connect active-low reset signal
    .scan_mode(intf.scan_mode),      // Connect scan mode control signal
    .valid_in(intf.valid_in),        // Connect valid input signal
    .ap(intf.ap),                    // Connect ALU predecode structure (packed struct)
    .csr_ren_in(intf.csr_ren_in),    // Connect CSR read enable signal
    .csr_rddata_in(intf.csr_rddata_in), // Connect CSR data input
    .a_in(intf.a_in),                // Connect operand A
    .b_in(intf.b_in),                // Connect operand B
    .result_ff(intf.result_ff),      // Connect final result output
    .error(intf.error)               // Connect error output signal
);
  
  //set the interface in the config DB.
  initial begin 
  //set the interface in the config DB.
    uvm_config_db#(virtual BMU_interface)::set(uvm_root::get(), "*", "vif",intf);
  end
  
  //run the test
  initial begin 
//     run_test("Control_Status_Reg_Oper_test");
//     run_test("Logic_operation_test");
//     run_test("BMU_shift_masking_operation_test");
//     run_test("BMU_Arithmetic_Operations_test");
    run_test("Bit_Manipulation_test");
  end
  
  //enable Waveform Dumping 
  initial begin  
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
endmodule 
  
  
  
  