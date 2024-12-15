

class BMU_base_test extends uvm_test;
  BMU_enviroment enviroment;
  `uvm_component_utils(BMU_base_test)


  function new(string name="BMU_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    enviroment=BMU_enviroment::type_id::create("enviroment",this);
  endfunction
  
  function void  end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase (phase);
    `uvm_info(get_type_name(), "End of elaboration phase: verifying component setup", UVM_MEDIUM);
    uvm_top.print_topology();
  endfunction
endclass