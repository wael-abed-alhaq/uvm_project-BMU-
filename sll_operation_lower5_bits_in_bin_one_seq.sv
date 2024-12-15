`ifndef sll_operation_lower5_bits_in_bin_one_seq
`define sll_operation_lower5_bits_in_bin_one_seq
class sll_operation_lower5_bits_in_bin_one_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(sll_operation_lower5_bits_in_bin_one_seq)//register the class with the UVM factory 
  
  function new( string name="sll_operation_lower5_bits_in_bin_one_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a transaction to verify sll operation_lower5_bits_in_bin_one
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      b_in==32'h0000001f;//we have to get that result_ff==a_in because there isnt any shift 
    };
    req.ap.sll=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming sll operation_lower5_bits_in_bin_one sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif