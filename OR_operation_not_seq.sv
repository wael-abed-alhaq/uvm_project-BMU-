`ifndef OR_operation_not_seq
`define OR_operation_not_seq
class OR_operation_not_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(OR_operation_not_seq)//register the class with the UVM factory 
  
  function new( string name="OR_operation_not_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a transaction to verify OR operation with ap.zbb=1
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
    };
    req.ap.lor=1;
    req.ap.zbb=1;
      
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming OR_not operation sequence with ap.zbb=1"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif