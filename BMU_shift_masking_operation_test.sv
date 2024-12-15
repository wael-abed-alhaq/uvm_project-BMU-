class BMU_shift_masking_operation_test extends BMU_base_test;
  `uvm_component_utils(BMU_shift_masking_operation_test)
  BMU_reset_seq reset_trans;
  
  sll_operation_basic_seq sll_trans;
  sll_operation_lower5_bits_in_bin_zero_seq sll_lower5_bits_in_bin0_trans;
  sll_operation_lower5_bits_in_bin_one_seq sll_lower5_bits_in_bin1_trans;
  
  srl_operation_basic_seq srl_trans; 
  srl_operation_lower5_bits_in_bin_zero_seq srl_lower5_bits_in_bin0_trans;
  srl_operation_lower5_bits_in_bin_one_seq srl_lower5_bits_in_bin1_trans;
  
  sra_operation_basic_seq sra_trans;
  sra_operation_lower5_bits_in_bin_zero_seq sra_operation_lower5_bits_in_bin_zero_trans;
  sra_operation_lower5_bits_in_bin_one_seq sra_operation_lower5_bits_in_bin_one_trans;
  
  rol_operation_basic_seq rol_trans;
  rol_operation_lower5_bits_in_bin_zero_seq rol_operation_lower5_bits_in_bin_zero_trans;
  rol_operation_lower5_bits_in_bin_one_seq rol_operation_lower5_bits_in_bin_one_trans;
  
  ror_operation_basic_seq ror_trans;
  ror_operation_lower5_bits_in_bin_zero_seq ror_operation_lower5_bits_in_bin_zero_trans;
  ror_operation_lower5_bits_in_bin_one_seq ror_operation_lower5_bits_in_bin_one_trans;
  
  bext_operation_basic_seq bext_trans;
  bext_operation_lower5_bits_in_bin_zero_seq bext_operation_lower5_bits_in_bin_zero_trans;
  bext_operation_lower5_bits_in_bin_one_seq bext_operation_lower5_bits_in_bin_one_trans;
  
  binv_operation_basic_seq binv_trans;
  binv_operation_lower5_bits_in_bin_zero_seq binv_operation_lower5_bits_in_bin_zero_trans;
  binv_operation_lower5_bits_in_bin_one_seq binv_operation_lower5_bits_in_bin_one_trans;
  
  sh1add_random_seq sh1add_trans;
  sh1add_basic_seq sh1add_basic_trans;
  sh1add_error_seq sh1add_error_trans;
  
  sh2add_random_seq sh2add_trans;
  sh2add_basic_seq sh2add_basic_trans;
  sh2add_error_seq sh2add_error_trans;
  
  sh3add_random_seq sh3add_trans;
  sh3add_basic_seq sh3add_basic_trans;
  sh3add_error_seq sh3add_error_trans;


  function new(string name="BMU_shift_masking_operation_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    reset_trans=BMU_reset_seq::type_id::create("reset_trans");
    
    sll_trans=sll_operation_basic_seq::type_id::create("sll_trans"); 
    sll_lower5_bits_in_bin0_trans=sll_operation_lower5_bits_in_bin_zero_seq::type_id::create("sll_lower5_bits_in_bin0_trans");
    sll_lower5_bits_in_bin1_trans=sll_operation_lower5_bits_in_bin_one_seq::type_id::create("sll_lower5_bits_in_bin1_trans");
    
    srl_trans=srl_operation_basic_seq::type_id::create("srl_trans");
    srl_lower5_bits_in_bin0_trans=srl_operation_lower5_bits_in_bin_zero_seq::type_id::create("srl_lower5_bits_in_bin0_trans");
    srl_lower5_bits_in_bin1_trans=srl_operation_lower5_bits_in_bin_one_seq::type_id::create("srl_lower5_bits_in_bin1_trans");
    
    sra_trans=sra_operation_basic_seq::type_id::create("sra_trans");
    sra_operation_lower5_bits_in_bin_zero_trans=sra_operation_lower5_bits_in_bin_zero_seq::type_id::create("sra_operation_lower5_bits_in_bin_zero_trans");
    sra_operation_lower5_bits_in_bin_one_trans=sra_operation_lower5_bits_in_bin_one_seq::type_id::create("sra_operation_lower5_bits_in_bin_one_trans");

    
    rol_trans=rol_operation_basic_seq::type_id::create("rol_trans");
    rol_operation_lower5_bits_in_bin_zero_trans=rol_operation_lower5_bits_in_bin_zero_seq::type_id::create("rol_operation_lower5_bits_in_bin_zero_trans");
    rol_operation_lower5_bits_in_bin_one_trans=rol_operation_lower5_bits_in_bin_one_seq::type_id::create("rol_operation_lower5_bits_in_bin_one_trans");

    
    ror_trans=ror_operation_basic_seq::type_id::create("ror_trans");
    ror_operation_lower5_bits_in_bin_zero_trans=ror_operation_lower5_bits_in_bin_zero_seq::type_id::create("ror_operation_lower5_bits_in_bin_zero_trans");
    ror_operation_lower5_bits_in_bin_one_trans=ror_operation_lower5_bits_in_bin_one_seq::type_id::create("ror_operation_lower5_bits_in_bin_one_trans");

    
    bext_trans=bext_operation_basic_seq::type_id::create("bext_trans");
    bext_operation_lower5_bits_in_bin_zero_trans=bext_operation_lower5_bits_in_bin_zero_seq::type_id::create("bext_operation_lower5_bits_in_bin_zero_trans");
    bext_operation_lower5_bits_in_bin_one_trans=bext_operation_lower5_bits_in_bin_one_seq::type_id::create("bext_operation_lower5_bits_in_bin_one_trans");

    
    binv_trans=binv_operation_basic_seq::type_id::create("binv_trans");
    binv_operation_lower5_bits_in_bin_zero_trans=binv_operation_lower5_bits_in_bin_zero_seq::type_id::create("binv_operation_lower5_bits_in_bin_zero_trans");
    binv_operation_lower5_bits_in_bin_one_trans=binv_operation_lower5_bits_in_bin_one_seq::type_id::create("binv_operation_lower5_bits_in_bin_one_trans");

    
    sh1add_trans=sh1add_random_seq::type_id::create("sh1add_trans");
    sh1add_basic_trans=sh1add_basic_seq::type_id::create("sh1add_basic_trans");
    sh1add_error_trans=sh1add_error_seq::type_id::create("sh1add_error_trans");
    
    sh2add_trans=sh2add_random_seq::type_id::create("sh2add_trans");
    sh2add_basic_trans=sh2add_basic_seq::type_id::create("sh2add_basic_trans");
    sh2add_error_trans=sh2add_error_seq::type_id::create("sh2add_error_trans");
    
    sh3add_trans=sh3add_random_seq::type_id::create("sh3add_trans");
    sh3add_basic_trans=sh3add_basic_seq::type_id::create("sh3add_basic_trans");
    sh3add_error_trans=sh3add_error_seq::type_id::create("sh3add_error_trans");
  endfunction

  task run_phase(uvm_phase phase); 
    phase.raise_objection(this);  
    reset_trans.start(enviroment.agent.sequencer);
        repeat(5)begin
      sll_trans.start(enviroment.agent.sequencer);
      sll_lower5_bits_in_bin0_trans.start(enviroment.agent.sequencer);
      sll_lower5_bits_in_bin1_trans.start(enviroment.agent.sequencer);
      
      srl_trans.start(enviroment.agent.sequencer);
      srl_lower5_bits_in_bin0_trans.start(enviroment.agent.sequencer);
      srl_lower5_bits_in_bin1_trans.start(enviroment.agent.sequencer);
      
      sra_trans.start(enviroment.agent.sequencer);
    sra_operation_lower5_bits_in_bin_zero_trans.start(enviroment.agent.sequencer);
    sra_operation_lower5_bits_in_bin_one_trans.start(enviroment.agent.sequencer);
    
      rol_trans.start(enviroment.agent.sequencer);
    rol_operation_lower5_bits_in_bin_zero_trans.start(enviroment.agent.sequencer);
    ror_operation_lower5_bits_in_bin_one_trans.start(enviroment.agent.sequencer);
      
      ror_trans.start(enviroment.agent.sequencer);
    ror_operation_lower5_bits_in_bin_zero_trans.start(enviroment.agent.sequencer);
    ror_operation_lower5_bits_in_bin_one_trans.start(enviroment.agent.sequencer);
      
      bext_trans.start(enviroment.agent.sequencer);
    bext_operation_lower5_bits_in_bin_zero_trans.start(enviroment.agent.sequencer);
    bext_operation_lower5_bits_in_bin_one_trans.start(enviroment.agent.sequencer);
      
      binv_trans.start(enviroment.agent.sequencer);
    binv_operation_lower5_bits_in_bin_zero_trans.start(enviroment.agent.sequencer);
    binv_operation_lower5_bits_in_bin_one_trans.start(enviroment.agent.sequencer);
      
      sh1add_basic_trans.start(enviroment.agent.sequencer);
      sh1add_trans.start(enviroment.agent.sequencer);
      sh1add_error_trans.start(enviroment.agent.sequencer);
      
      sh2add_basic_trans.start(enviroment.agent.sequencer);
      sh2add_trans.start(enviroment.agent.sequencer);
      sh2add_error_trans.start(enviroment.agent.sequencer);
      
      sh3add_basic_trans.start(enviroment.agent.sequencer);
      sh3add_trans.start(enviroment.agent.sequencer);
      sh3add_error_trans.start(enviroment.agent.sequencer);
      
    end
    phase.drop_objection(this); 
    `uvm_info(get_type_name(),"END of test",UVM_LOW);
  endtask
endclass