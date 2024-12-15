`ifndef sh1add_error_seq
`define sh1add_error_seq
class sh1add_error_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(sh1add_error_seq)//register the class with the UVM factory 
  
  function new( string name="sh1add_error_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a transaction to verify sh1add_error operation 
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
     
    };
    req.ap.sh1add=1;
    //in this case we take req.ap.zba=0;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming sh1add error operation sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif