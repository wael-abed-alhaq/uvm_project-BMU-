class Bit_Manipulation_test extends BMU_base_test;
  `uvm_component_utils(Bit_Manipulation_test)
  BMU_reset_seq reset_trans;
  
  set_on_less_than_seq slt_trans;
  
  clz_seq clz_trans;
  clz_input_zero_seq clz__input_zero_trans;
  clz_input_most_significat_1_seq clz_input_most_significat_1_trans;
  
  ctz_seq ctz_trans;
  ctz_input_zero_seq ctz__input_zero_trans;
  ctz_input_least_significat_1_seq ctz_input_least_significat_1_trans;
  
  cpop_seq cpop_trans;
  cpop_ain_zero_seq cpop_ain_zero_trans;
  cpop_ain_ones_seq cpop_ain_ones_trans;
  
  siext_b_seq siext_b_trans;
  siext_h_seq siext_h_trans;
  
  max_seq max_trans;
  min_seq min_trans;
  
  pack_seq pack_trans;
  packu_seq packu_trans;
  packh_seq packh_trans;
  
  grev_bin_24_seq grev_bin_24_trans;
  grev_bin_not_24_seq grev_bin_not_24_trans;
  
  gorc_basic_seq gorc_basic_trans;
  gorc_ain_zero_seq gorc_ain_zero_trans;
  gorc_ain_ones_seq gorc_ain_ones_trans;
  gorc_bin_not_7_seq gorc_bin_not_7_trans;
  gorc_ain_onebyte0_seq gorc_ain_onebyte0_trans;

  

  function new(string name="BMU_shift_masking_operation_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    reset_trans=BMU_reset_seq::type_id::create("reset_trans");
    
    slt_trans=set_on_less_than_seq::type_id::create("slt_trans");
    
    clz_trans=clz_seq::type_id::create("clz_trans");
    clz__input_zero_trans=clz_input_zero_seq::type_id::create("clz__input_zero_trans"); clz_input_most_significat_1_trans=clz_input_most_significat_1_seq::type_id::create("clz_input_most_significat_1_trans");
    
    ctz_trans=ctz_seq::type_id::create("ctz_trans");
    ctz__input_zero_trans=ctz_input_zero_seq::type_id::create("ctz__input_zero_trans"); ctz_input_least_significat_1_trans=ctz_input_least_significat_1_seq::type_id::create("ctz_input_least_significat_1_trans");
    
    cpop_trans=cpop_seq::type_id::create("cpop_trans");
    cpop_ain_zero_trans=cpop_ain_zero_seq::type_id::create("cpop_ain_zero_trans");
    cpop_ain_ones_trans=cpop_ain_ones_seq::type_id::create("cpop_ain_ones_trans");
    
    siext_b_trans=siext_b_seq::type_id::create("siext_b_trans");
    siext_h_trans=siext_h_seq::type_id::create("siext_h_trans");
    
    max_trans=max_seq::type_id::create("max_trans");
    min_trans=min_seq::type_id::create("min_trans");
    
    pack_trans=pack_seq::type_id::create("pack_trans");
    packu_trans=packu_seq::type_id::create("packu_trans");
    packh_trans=packh_seq::type_id::create("packh_trans");
    
    grev_bin_24_trans=grev_bin_24_seq::type_id::create("grev_bin_24_trans");
    grev_bin_not_24_trans=grev_bin_not_24_seq::type_id::create("grev_bin_not_24_trans");

    gorc_basic_trans=gorc_basic_seq::type_id::create("gorc_basic_trans");
    gorc_ain_zero_trans=gorc_ain_zero_seq::type_id::create("gorc_ain_zero_trans");
    gorc_ain_ones_trans=gorc_ain_ones_seq::type_id::create("gorc_ain_ones_trans");
    gorc_bin_not_7_trans=gorc_bin_not_7_seq::type_id::create("gorc_bin_not_7_trans");
    gorc_ain_onebyte0_trans=gorc_ain_onebyte0_seq::type_id::create("gorc_ain_onebyte0_trans");



   
  endfunction
  
  task run_phase(uvm_phase phase); 
    phase.raise_objection(this);  
    reset_trans.start(enviroment.agent.sequencer);
//         repeat(5)begin
            slt_trans.start(enviroment.agent.sequencer);
      
      clz_trans.start(enviroment.agent.sequencer);
            clz__input_zero_trans.start(enviroment.agent.sequencer);//bug
      clz_input_most_significat_1_trans.start(enviroment.agent.sequencer);
      
      ctz_trans.start(enviroment.agent.sequencer);
//             ctz__input_zero_trans.start(enviroment.agent.sequencer);//bug 
      ctz_input_least_significat_1_trans.start(enviroment.agent.sequencer);
      
      cpop_trans.start(enviroment.agent.sequencer);
      cpop_ain_zero_trans.start(enviroment.agent.sequencer);
      cpop_ain_ones_trans.start(enviroment.agent.sequencer);
      
      siext_b_trans.start(enviroment.agent.sequencer);
      siext_h_trans.start(enviroment.agent.sequencer);
      
      max_trans.start(enviroment.agent.sequencer);
      min_trans.start(enviroment.agent.sequencer);
      
      pack_trans.start(enviroment.agent.sequencer);
      packu_trans.start(enviroment.agent.sequencer);//bug
      packh_trans.start(enviroment.agent.sequencer);
      
      grev_bin_24_trans.start(enviroment.agent.sequencer);
      grev_bin_not_24_trans.start(enviroment.agent.sequencer); 
      
      gorc_basic_trans.start(enviroment.agent.sequencer);
      gorc_ain_zero_trans.start(enviroment.agent.sequencer);
      gorc_ain_ones_trans.start(enviroment.agent.sequencer);
      gorc_bin_not_7_trans.start(enviroment.agent.sequencer);
      gorc_ain_onebyte0_trans.start(enviroment.agent.sequencer);
      
//       end
    phase.drop_objection(this); 
    `uvm_info(get_type_name(),"END of test",UVM_LOW);
  endtask
endclass