`ifndef XOR_operation_error_seq
`define XOR_operation_error_seq
class XOR_operation_error_seq extends uvm_sequence #(BMU_sequence_item);
  `uvm_object_utils(XOR_operation_error_seq)//register the class with the UVM factory 
  
  function new( string name="XOR_operation_error_seq");//define a constructor to initialize the sequence 
    super.new(name);
  endfunction
  
  virtual task body(); 
    //instance of the transaction 
    BMU_sequence_item req = BMU_sequence_item::type_id::create("req");
    req.randomize() with {
      // Configuring a basic transaction to verify XOR operation with apfields!=0
      rst_l==1;
      valid_in==1;
      scan_mode==0;
      csr_ren_in==0;
      ap.lxor==1;
    };
    req.ap.clz = 1; req.ap.ctz = 1; req.ap.cpop=1; req.ap.siext_b = 1; req.ap.siext_h = 1; req.ap.min = 1; req.ap.max = 1; req.ap.pack = 1; req.ap.packu = 1; req.ap.packh = 1; req.ap.rol = 1; req.ap.ror = 1; req.ap.grev = 1; req.ap.gorc = 1; req.ap.zbb = 1; req.ap.bset = 1; req.ap.bclr = 1; req.ap.binv = 1; req.ap.bext = 1; req.ap.sh1add = 1; req.ap.sh2add = 1; req.ap.sh3add = 1; req.ap.zba = 1; req.ap.land = 1; req.ap.lor = 1; req.ap.sll = 1; req.ap.srl = 1; req.ap.sra = 1; req.ap.beq = 1; req.ap.bne =1; req.ap.blt =1; req.ap.bge =1; req.ap.add = 1; req.ap.sub = 1; req.ap.slt = 1; req.ap.unsign = 1; req.ap.jal =1; req.ap.predict_t =1; req.ap.predict_nt=1;  req.ap.csr_write=1; req.ap.csr_imm=1;
    
      
    start_item(req);
    `uvm_info(get_type_name(),("\nPerforming XOR_error operation sequence apfields!=0"),UVM_NONE)
    finish_item(req); 
    #10; 
  endtask 
endclass
 `endif