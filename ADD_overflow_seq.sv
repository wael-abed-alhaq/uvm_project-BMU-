`ifndef ADD_overflow_seq
`define ADD_overflow_seq
class ADD_overflow_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(ADD_overflow_seq)//register the class with the UVM factory 
  
  function new( string name="ADD_overflow_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a  transaction to verify add_overflow operation 
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      a_in==32'hFFFFFFFF;
      b_in==32'hFFFFFFFF;
     
    };
    req.ap.add=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming add_overflow operation sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif