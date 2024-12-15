`ifndef gorc_ain_onebyte0_seq
`define gorc_ain_onebyte0_seq
class gorc_ain_onebyte0_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(gorc_ain_onebyte0_seq)//register the class with the UVM factory 
  
  function new( string name="gorc_ain_onebyte0_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a  transaction to verify gorc with ain-onebyte0 operation 
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      a_in==32'h00ffffff;
      b_in==7;
    };
    req.ap.gorc=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming gorc with ain-onebyte0 operation sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif