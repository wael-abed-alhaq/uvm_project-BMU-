`ifndef AND_operation_error2_seq
`define AND_operation_error2_seq
class AND_operation_error2_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(AND_operation_error2_seq)//register the class with the UVM factory 
  
  function new( string name="AND_operation_error2_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a basic transaction to verify AND operation with csr_ren_in=1
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      ap==0;
      csr_ren_in==1;
    };
    req.ap.land=1;
      
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming AND_error operation sequence csr_ren_in=1"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif