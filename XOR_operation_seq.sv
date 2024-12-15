`ifndef XOR_operation_seq
`define XOR_operation_seq
class XOR_operation_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(XOR_operation_seq)//register the class with the UVM factory 
  
  function new( string name="XOR_operation_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a transaction to verify XOR operation with ap.zbb=0
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
    };
    req.ap.lxor=1;
    req.ap.zbb=0;  //If ap_zbb = 0, then result = a_in ^ b_in ,,,,If ap_zbb = 1, then result = a_in ^ !b_in

    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming XOR operation sequence with ap.zbb=0"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif