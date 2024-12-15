// `ifndef BMU_subscriber
// `define BMU_subscriber
class BMU_subscriber extends uvm_subscriber#(BMU_sequence_item);
    
  BMU_sequence_item transaction;//declare the Sequence item 

//   regestration 
  `uvm_component_utils(BMU_subscriber)
  
  //   constructor
  function new(string name="BMU_subscriber", uvm_component parent);
    super.new(name, parent);
    transaction = BMU_sequence_item::type_id::create("transaction", this);
    BMU_Covergroup = new();
  endfunction
      
  covergroup BMU_Covergroup;

    // Coverage for reset signal
    c_rst_l: coverpoint transaction.rst_l {
      bins rst_l={[0:1]};
    }

    // Coverage for scan mode
    c_scan_mode: coverpoint transaction.scan_mode {
      bins scan_mode={[0:1]};
    }

    // Coverage for valid input signal
    c_valid_in: coverpoint transaction.valid_in {
      bins valid_in={[0:1]};
    }

   c_ap: coverpoint transaction.ap;

    // Coverage for CSR select signal (`csr_ren_in`)
    c_csr_ren_in: coverpoint transaction.csr_ren_in {
      bins csr_ren_in={[0:1]};
    }

    // Coverage for CSR data input (`csr_rddata_in`)
    c_csr_rddata_in: coverpoint transaction.csr_rddata_in {
      bins low_values = {[0:1023]};           // Low range values
      bins mid_values = {[1024:32767]};       // Mid range values
      bins high_values = {[32768:32'hFFFFFFFF]};  // High range values
//       bins negative_values = {[-32'h80000000:-1]}; // Negative values
    }

    // Coverage for operand A (`a_in`)
    c_a_in: coverpoint transaction.a_in {
      bins low_values = {[0:1023]};           // Low range values
      bins mid_values = {[1024:32767]};       // Mid range values
      bins high_values = {[32768:32'h7FFFFFFF]};  // High range values
      bins negative_values = {[-32'h79999999:-1]}; // Negative values
    }

    // Coverage for operand B (`b_in`)
    c_b_in: coverpoint transaction.b_in {
      bins low_values = {[0:1023]};           // Low range values
      bins mid_values = {[1024:32767]};       // Mid range values
      bins high_values = {[32768:32'h7FFFFFFF]};  // High range values
//       bins negative_values = {[-32'h80000000:-1]}; // Negative values
    }

    // Coverage for result signal (`result_ff`)
    c_result_ff: coverpoint transaction.result_ff {
      bins low_result = {[0:1023]};           // Low range result
      bins mid_result = {[1024:32767]};       // Mid range result
      bins high_result = {[32768:32'hFFFFFFFF]};  // High range result
//       bins negative_values = {[-32'h80000000:-1]}; // Negative values
    }
    
    // Coverage for error signal (`error`)
    c_error: coverpoint transaction.error {
      bins error_occurs ={[0:1]};
    }
  endgroup
      
      // Write method to process each transaction
      virtual function void write(input BMU_sequence_item t);
        transaction = t; // Assign the transaction to transaction for covergroup use
        BMU_Covergroup.sample(); // Sample the covergroup
      endfunction 

endclass 
//  `endif
  
  
  
  
  
  
  