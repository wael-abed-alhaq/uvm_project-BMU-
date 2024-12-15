class Control_Status_Reg_Oper_test extends BMU_base_test;
  `uvm_component_utils(Control_Status_Reg_Oper_test)
//   BMU_enviroment enviroment;
  BMU_reset_seq reset_trans;
  BMU_basic_operation_CSR_Bypass_Input_Data_seq CSR_Bypass_trans;
  csr_ren_in_apfields_not_zero_seq csr_ren_in_apfields_not_zero_trans;
  
  BMU_CSR_wr_data_ap_csr_imm_is_low_seq CSR_wr_csr_imm_low_trans;
  BMU_CSR_wr_data_ap_csr_imm_is_high_seq CSR_wr_csr_imm_high_trans;

  
  function new(string name="Control_Status_Reg_Oper_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    reset_trans=BMU_reset_seq::type_id::create("reset_trans");
    CSR_Bypass_trans=BMU_basic_operation_CSR_Bypass_Input_Data_seq::type_id::create("CSR_Bypass_trans");
    csr_ren_in_apfields_not_zero_trans=csr_ren_in_apfields_not_zero_seq::type_id::create("csr_ren_in_apfields_not_zero_trans");
    
    CSR_wr_csr_imm_low_trans=BMU_CSR_wr_data_ap_csr_imm_is_low_seq::type_id::create("CSR_wr_csr_imm_low_trans");
    CSR_wr_csr_imm_high_trans=BMU_CSR_wr_data_ap_csr_imm_is_high_seq::type_id::create("CSR_wr_csr_imm_high_trans");
    
  endfunction

  task run_phase(uvm_phase phase); 
    phase.raise_objection(this);  
     reset_trans.start(enviroment.agent.sequencer);
    repeat(40)begin
      CSR_Bypass_trans.start(enviroment.agent.sequencer);
      csr_ren_in_apfields_not_zero_trans.start(enviroment.agent.sequencer);
      
      CSR_wr_csr_imm_low_trans.start(enviroment.agent.sequencer);
      CSR_wr_csr_imm_high_trans.start(enviroment.agent.sequencer);
       end
    
    phase.drop_objection(this); 
    `uvm_info(get_type_name(),"END of test",UVM_LOW);
  endtask
endclass