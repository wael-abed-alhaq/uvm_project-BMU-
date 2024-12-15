`ifndef gorc_bin_not_7_seq
`define gorc_bin_not_7_seq
class gorc_bin_not_7_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(gorc_bin_not_7_seq)//register the class with the UVM factory 
  
  function new( string name="gorc_bin_not_7_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a  transaction to verify gorc with bin!=7  operation 
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      b_in!=7;

    };
    req.ap.grev=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming gorc with bin!=7 operation sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif