`ifndef binv_operation_lower5_bits_in_bin_zero_seq
`define binv_operation_lower5_bits_in_bin_zero_seq
class binv_operation_lower5_bits_in_bin_zero_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(binv_operation_lower5_bits_in_bin_zero_seq)//register the class with the UVM factory 
  
  function new( string name="binv_operation_lower5_bits_in_bin_zero_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a basic transaction to verify binv operation_lower5_bits_in_bin_zero
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      b_in==32'hffffffe0;//we have to get the signal with a single bit inverted at the least bit a_in because the lower 5 bit of b_in is 00000
    };
    req.ap.binv=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming binv operation_lower5_bits_in_bin_zero sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif