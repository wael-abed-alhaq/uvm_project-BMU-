`ifndef csr_ren_in_apfields_not_zero_seq
`define csr_ren_in_apfields_not_zero_seq
class csr_ren_in_apfields_not_zero_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(csr_ren_in_apfields_not_zero_seq)//register the class with the UVM factory 
  
  function new( string name="csr_ren_in_apfields_not_zero_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a basic transaction to verify CSR Bypass input data with apfields not zero operation
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==1;
      
    };
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming CSR Bypass input data with apfields not zero"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif