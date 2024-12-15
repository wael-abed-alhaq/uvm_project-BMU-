// `ifndef BMU_driver
// `define BMU_driver
class BMU_driver extends uvm_driver#(BMU_sequence_item);
  
  virtual BMU_interface vif;//declare a virtual interface varible in the class to interface with the DUT.
  
  `uvm_component_utils(BMU_driver)
  //use the UVM macros uvm_component_utils to register the driver class
  
   // bulid Constructor 
   //constructor
  function new( string name ="BMU_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //asssign the interface Virtual Handler
  //implement the build_phase function 
  //use uvm_config_db to get the virtual interface instance and assign it to the drivers vif varible
  function void build_phase(uvm_phase phase);  
    super.build_phase(phase);  
    if(!uvm_config_db#(virtual BMU_interface)::get(this, "", "vif", vif))  
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction
  
  
  //continuously get transaction from the sequence item port and drive them to the DUT using the drive task 
  task run_phase(uvm_phase phase);  
    forever begin  
      seq_item_port.get_next_item(req);  //get the next transaction 
      drive();   //call the drive() to send signals to the DUT
      `uvm_info(get_type_name(), $sformatf("Driver: signals driven to the DUT are: %s", req.convert2string1()), UVM_HIGH);//print info using uvm_info
      seq_item_port.item_done();  //mark the sequence_item as done 
      end
  endtask 
  
  //Drive the signals from the sequence item to the DUT interface using the virtual interface.
  task drive();  //Implement the drive task.
    @(vif.DRIVER_CB);//// Wait for the next clock cycle to complete the drive operation
    //Use the virtual interface to drive the signals  to the DUT.
    // Drive the signals using the virtual interface
    vif.DRIVER_CB.rst_l <= req.rst_l;
    vif.DRIVER_CB.scan_mode <= req.scan_mode;
    vif.DRIVER_CB.valid_in <= req.valid_in;
    vif.DRIVER_CB.ap <= req.ap;
    vif.DRIVER_CB.csr_ren_in <= req.csr_ren_in;
    vif.DRIVER_CB.csr_rddata_in <= req.csr_rddata_in;
    vif.DRIVER_CB.a_in <= req.a_in;
    vif.DRIVER_CB.b_in <= req.b_in;
  endtask 
  
endclass
// `endif