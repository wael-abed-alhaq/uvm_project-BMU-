`ifndef BMU_reset_seq
`define BMU_reset_seq
class BMU_reset_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(BMU_reset_seq)//register the class with the UVM factory 
  
  function new( string name="BMU_reset_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      req.rst_l==0;
    };
    start_item(req);
    `uvm_info(get_type_name(),("Reset the DUT"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif