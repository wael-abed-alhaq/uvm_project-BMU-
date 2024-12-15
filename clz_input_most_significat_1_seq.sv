`ifndef clz_input_most_significat_1_seq
`define clz_input_most_significat_1_seq
class clz_input_most_significat_1_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(clz_input_most_significat_1_seq)//register the class with the UVM factory 
  
  function new( string name="clz_input_most_significat_1_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a  transaction to verify clz with a_in[31]=1'b1 operation 
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap==0;
      a_in==32'hc5679403;
    };
    req.ap.clz=1;
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming clz with a_in[31]=1'b1 operation sequence"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif