`ifndef BMU_agent
`define BMU_agent
class BMU_agent extends uvm_agent;  
  
  //declare agent components
  BMU_driver driver; 
  BMU_sequencer sequencer; 
  BMU_monitor monitor;
  
  //Register the class in the Factory 
  `uvm_component_utils(BMU_agent)
 
  
  // constructor 
  function new( string name ="BMU_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  // Build components based on activity status
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active()==UVM_ACTIVE) begin 
      // If the agent is active, create both the sequencer and driver
      sequencer = BMU_sequencer::type_id::create("sequencer",this); // Instantiate the sequencer using UVM factory
      driver = BMU_driver::type_id::create("driver",this); // Instantiate the driver using UVM factory
    end 
    // Always create the monitor, regardless of whether the agent is active or passive
    monitor=BMU_monitor::type_id::create("monitor",this); // Instantiate the monitor using UVM factory
  endfunction 
  
  // connect_phase to connect the components
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active()==UVM_ACTIVE) begin 
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end 
  endfunction 
endclass
  `endif