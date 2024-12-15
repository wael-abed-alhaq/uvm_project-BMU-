`ifndef rol_operation_basic_seq
`define rol_operation_basic_seq
class rol_operation_basic_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(rol_operation_basic_seq)//register the class with the UVM factory 
  
  function new( string name="rol_operation_basic_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a basic transaction to verify rol operation 
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
    };
    req.ap.rol=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming rol operation sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif