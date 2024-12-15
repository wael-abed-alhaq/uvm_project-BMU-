`ifndef bext_operation_lower5_bits_in_bin_one_seq
`define bext_operation_lower5_bits_in_bin_one_seq
class bext_operation_lower5_bits_in_bin_one_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(bext_operation_lower5_bits_in_bin_one_seq)//register the class with the UVM factory 
  
  function new( string name="bext_operation_lower5_bits_in_bin_one_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a basic transaction to verify bext operation_lower5_bits_in_bin_one
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      b_in==32'h0000001f;////we get in result_ff the most significat bit from a_in because b_in is 5'b11111----31
    };
    req.ap.bext=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming bext operation_lower5_bits_in_bin_one sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif