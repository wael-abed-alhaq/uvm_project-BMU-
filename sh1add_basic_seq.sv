`ifndef sh1add_basic_seq
`define sh1add_basic_seq
class sh1add_basic_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(sh1add_basic_seq)//register the class with the UVM factory 
  
  function new( string name="sh1add_basic_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a basic transaction to verify sh1add operation with minimal conditions
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      a_in==1;
      b_in==1;
    };
    req.ap.sh1add=1;
    req.ap.zba=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming sh1add basic operation sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif