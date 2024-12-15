// `ifndef BMU_interface
// `define BMU_interface
interface BMU_interface (input logic clk);
  //input and output signals 
  logic rst_l;     // Reset
  logic scan_mode; // Scan control
  logic                valid_in;       // Valid
  rtl_alu_pkt_t        ap;             // predecodes
  logic                csr_ren_in;     // CSR select
  logic         [31:0] csr_rddata_in;  // CSR data
  logic signed  [31:0] a_in;           // A operand
  logic         [31:0] b_in;           // B operand
  logic [31:0] result_ff;  // final result
  logic error; //Error output signal


//define clocking blocks.
// A. Clocking Block for Driver (DRIVER_CB)  
  clocking DRIVER_CB @(negedge clk); // Triggered on the negative edge of the clock 
    default input #1 output #0; //the delay will not effect the the flow becuse these signals are going to be driven immediately by the driver without needing additional delay.
    
    output rst_l;// Driver outputs reset 
    output scan_mode;// Scan control
    output valid_in; // Driver outputs Scan_control
    output ap; // Driver outputs the operation code
    output csr_ren_in; //CSR select 
    output csr_rddata_in;//CSR data 
    output a_in;//A operand 
    output b_in;//B operand 
  endclocking 



  //define clocking blocks.
  // B. Clocking Block for Monitor (MONITOR_CB)  
  clocking MONITOR_CB @(posedge clk); // Triggered on the positive edge of the clock 
    default input #0 output #1; // the delay will not affect the flow because these signals are going to be sampled immediately by the monitor without needing additional delay.
    
    input rst_l;// Driver outputs reset 
    input scan_mode;// Scan control
    input valid_in; // Driver outputs Scan_control
    input ap; // Driver outputs the operation code
    input csr_ren_in; //CSR select 
    input csr_rddata_in;//CSR data 
    input a_in;//A operand 
    input b_in;//B operand 
    input result_ff;
    input error;
  endclocking 


  // 3. Define Mod Ports  
  // A. Modport for Driver (DRIVER_MOD)  
  modport DRIVER_MOD (clocking DRIVER_CB, input clk);  
    
  // B. Modport for Monitor (MONITOR_MOD)  
  modport MONITOR_MOD (clocking MONITOR_CB, input clk);  
endinterface
// `endif