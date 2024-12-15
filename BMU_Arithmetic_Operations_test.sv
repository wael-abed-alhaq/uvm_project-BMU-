class BMU_Arithmetic_Operations_test extends BMU_base_test;
  `uvm_component_utils(BMU_Arithmetic_Operations_test)
  BMU_reset_seq reset_trans;
  
  subtract_seq sub_trans;
  subtract_error_seq sub_error_trans;
  ADD_seq ADD_trans;
  ADD_overflow_seq ADD_overflow_trans;
  

  

  function new(string name="BMU_shift_masking_operation_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    reset_trans=BMU_reset_seq::type_id::create("reset_trans");
    
    sub_trans=subtract_seq::type_id::create("sub_trans"); 
    sub_error_trans=subtract_error_seq::type_id::create("sub_error_trans"); 
    ADD_trans=ADD_seq::type_id::create("ADD_trans"); 
    ADD_overflow_trans=ADD_overflow_seq::type_id::create("ADD_overflow_trans"); 
  endfunction
  
  task run_phase(uvm_phase phase); 
    phase.raise_objection(this);  
    reset_trans.start(enviroment.agent.sequencer);
    repeat(40)begin
      sub_trans.start(enviroment.agent.sequencer);
      sub_error_trans.start(enviroment.agent.sequencer);
      ADD_trans.start(enviroment.agent.sequencer);
      ADD_overflow_trans.start(enviroment.agent.sequencer);
    end
    phase.drop_objection(this); 
    `uvm_info(get_type_name(),"END of test",UVM_LOW);
  endtask
endclass