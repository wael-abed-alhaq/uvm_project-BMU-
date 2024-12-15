`ifndef grev_bin_not_24_seq
`define grev_bin_not_24_seq
class grev_bin_not_24_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(grev_bin_not_24_seq)//register the class with the UVM factory 
  
  function new( string name="grev_bin_not_24_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a  transaction to verify grev with bin!=24  operation 
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      b_in!=24;

    };
    req.ap.grev=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming grev with bin!=24 operation sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif