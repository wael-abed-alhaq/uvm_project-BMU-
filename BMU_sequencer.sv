// `ifndef BMU_sequencer
// `define BMU_sequencer
class BMU_sequencer extends uvm_sequencer #(BMU_sequence_item);
  
  //Register the class
  `uvm_component_utils(BMU_sequencer)
  
  //constructor
  function new( string name ="BMU_sequencer",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass
// `endif