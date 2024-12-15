`ifndef BMU_basic_operation_CSR_Bypass_Input_Data_seq
`define BMU_basic_operation_CSR_Bypass_Input_Data_seq
class BMU_basic_operation_CSR_Bypass_Input_Data_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(BMU_basic_operation_CSR_Bypass_Input_Data_seq)//register the class with the UVM factory 
  
  function new( string name="BMU_basic_operation_CSR_Bypass_Input_Data_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a basic transaction to verify CSR Bypass input data operation when apfields is zero
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==1;
      ap==0;
      
    };
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming CSR Bypass input data when apfields is zero"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif