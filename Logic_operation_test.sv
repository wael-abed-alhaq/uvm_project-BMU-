class Logic_operation_test extends BMU_base_test;
  `uvm_component_utils(Logic_operation_test)
//   BMU_enviroment enviroment;
  BMU_reset_seq reset_trans;
  AND_operation_seq AND_trans;
  AND_operation_not_seq AND_not_trans;
  AND_operation_error_seq AND_error_trans;
  AND_operation_error2_seq AND_error2_trans;
  
  OR_operation_seq OR_trans;
  OR_operation_not_seq OR_not_trans;
  OR_operation_error_seq OR_error_trans;
  OR_operation_error2_seq OR_error2_trans;
  
  XOR_operation_seq XOR_trans;
  XOR_operation_not_seq XOR_not_trans;
  XOR_operation_error_seq XOR_error_trans;
  XOR_operation_error2_seq XOR_error2_trans;

  
  function new(string name="Logic_operation_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    reset_trans=BMU_reset_seq::type_id::create("reset_trans");
    AND_trans=AND_operation_seq::type_id::create("AND_trans");
    AND_not_trans=AND_operation_not_seq::type_id::create("AND_not_trans");
    AND_error_trans=AND_operation_error_seq::type_id::create("AND_error_trans");
    AND_error2_trans=AND_operation_error2_seq::type_id::create("AND_error2_trans");
    
    OR_trans=OR_operation_seq::type_id::create("OR_trans");
    OR_not_trans=OR_operation_not_seq::type_id::create("OR_not_trans");
    OR_error_trans=OR_operation_error_seq::type_id::create("OR_error_trans");
    OR_error2_trans=OR_operation_error2_seq::type_id::create("OR_error2_trans");

    
    
    XOR_trans=XOR_operation_seq::type_id::create("XOR_trans");
    XOR_not_trans=XOR_operation_not_seq::type_id::create("XOR_not_trans");
    XOR_error_trans=XOR_operation_error_seq::type_id::create("XOR_error_trans");
    XOR_error2_trans=XOR_operation_error2_seq::type_id::create("XOR_error2_trans");
  endfunction

  
  task run_phase(uvm_phase phase); 
    phase.raise_objection(this);  
    reset_trans.start(enviroment.agent.sequencer);
    repeat(5)begin
    AND_trans.start(enviroment.agent.sequencer);
    AND_not_trans.start(enviroment.agent.sequencer);
    AND_error_trans.start(enviroment.agent.sequencer);
    AND_error2_trans.start(enviroment.agent.sequencer);
    
    
      
    OR_trans.start(enviroment.agent.sequencer);
    OR_not_trans.start(enviroment.agent.sequencer); 
    OR_error_trans.start(enviroment.agent.sequencer);
    OR_error2_trans.start(enviroment.agent.sequencer);

    
    XOR_trans.start(enviroment.agent.sequencer);
    XOR_not_trans.start(enviroment.agent.sequencer); 
    XOR_error_trans.start(enviroment.agent.sequencer);
    XOR_error2_trans.start(enviroment.agent.sequencer);
       end
    phase.drop_objection(this); 
    `uvm_info(get_type_name(),"END of test",UVM_LOW);
  endtask
endclass