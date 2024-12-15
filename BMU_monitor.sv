// `ifndef BMU_monitor
// `define BMU_monitor
class BMU_monitor extends uvm_monitor;
  
  virtual BMU_interface vif;  
  uvm_analysis_port#(BMU_sequence_item) port;//Declare a uvm_analysis_port that will transmit ALU_SequenceItem transactions.
  
  BMU_sequence_item packet;  //Declare a variable of type BMU_sequence_item to store sampled data from the DUT.
  

  `uvm_component_utils(BMU_monitor)
     
  // bulid Constructor 
  //constructor
  function new( string name ="BMU_monitor",uvm_component parent);
    super.new(name,parent);
    port=new("port",this);
    packet=new();
  endfunction
  
  function void build_phase(uvm_phase phase);  
    super.build_phase(phase);  
    if(!uvm_config_db#(virtual BMU_interface)::get(this, "", "vif", vif))  
      `uvm_fatal(get_type_name(), "Not set at top level"); 
  endfunction 
  
  task run_phase(uvm_phase phase);  
    forever begin  
      @(vif.MONITOR_CB);
      //input sampled
      packet.rst_l = vif.MONITOR_CB.rst_l;  
      packet.scan_mode = vif.MONITOR_CB.scan_mode;  
      packet.valid_in = vif.MONITOR_CB.valid_in;  
      packet.ap = vif.MONITOR_CB.ap;
      packet.csr_ren_in = vif.MONITOR_CB.csr_ren_in;
      packet.csr_rddata_in = vif.MONITOR_CB.csr_rddata_in;
      packet.a_in = vif.MONITOR_CB.a_in;
      packet.b_in = vif.MONITOR_CB.b_in;
      `uvm_info(get_type_name(), $sformatf("Monitor: input signals sampled from the DUT are: rst_l = %0b, scan_mode = %0b, valid_in = %0b, ap = %0h, csr_ren_in = %0b, csr_rddata_in = %0d, a_in = %0d, b_in = %0d", packet.rst_l, packet.scan_mode, packet.valid_in, packet.ap, packet.csr_ren_in, packet.csr_rddata_in, packet.a_in, packet.b_in), UVM_HIGH);  
      //output sampled
      packet.result_ff = vif.MONITOR_CB.result_ff;  
      packet.error = vif.MONITOR_CB.error;  
      // Log the captured output signals
      `uvm_info(get_type_name(), $sformatf("Monitor: output signals sampled from the DUT are: result_ff =%0d, error = %b", packet.result_ff, packet.error), UVM_HIGH);   
      // Write the captured transaction to the analysis port    
      port.write(packet);

      end  
  endtask
endclass
// `endif