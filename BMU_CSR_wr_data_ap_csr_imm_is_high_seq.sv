`ifndef BMU_CSR_wr_data_ap_csr_imm_is_high_seq
`define BMU_CSR_wr_data_ap_csr_imm_is_high_seq
class BMU_CSR_wr_data_ap_csr_imm_is_high_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(BMU_CSR_wr_data_ap_csr_imm_is_high_seq)//register the class with the UVM factory 
  
  function new( string name="BMU_CSR_wr_data_ap_csr_imm_is_high_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    
    req.randomize() with {
      // Configuring a transaction to verify CSR write data operations when ap.csr_imm is high
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      ap==0;
      csr_ren_in== 0;
      };
    
      req.ap.csr_write = 1;
      req.ap.csr_imm = 1;

    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming CSR write data operation sequence with ap.csr_imm=1;"),UVM_NONE)
    finish_item(req); 
    #10; 
    
  endtask 
endclass
 `endif