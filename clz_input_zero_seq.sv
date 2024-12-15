`ifndef clz_input_zero_seq
`define clz_input_zero_seq
class clz_input_zero_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(clz_input_zero_seq)//register the class with the UVM factory 
  
  function new( string name="clz_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a  transaction to verify clz with a_in=zero operation 
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      a_in==32'h00000000;
    };
    req.ap.clz=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming clz with a_in=zero operation sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif