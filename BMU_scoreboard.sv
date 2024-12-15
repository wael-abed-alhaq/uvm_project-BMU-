// `ifndef BMU_scoreboard
// `define BMU_scoreboard
class BMU_scoreboard extends uvm_scoreboard;
  
  BMU_sequence_item packet;  
  BMU_sequence_item refPacket; //refrencepacket for expected values
  // Create the refPacket instance
  
  //implement the wrute() function to receive and store the sequence items into the packetQueue
  BMU_sequence_item packetQueue [$];
  
  ref_model_1 ref_mod;
  
  `uvm_component_utils(BMU_scoreboard)
  function new(string name, uvm_component parent);
    super.new(name,parent);
    ref_mod=new();
  endfunction 
  
  uvm_analysis_imp#(BMU_sequence_item,BMU_scoreboard) exp;//Define an analysis port named exp 
  
   
  
  // initialize the analysis port in the build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp=new("exp",this);
    refPacket = BMU_sequence_item::type_id::create("refPacket", this);

  endfunction
 
  // function to receive packets from the analysis port
  function void write(BMU_sequence_item req);
    packetQueue.push_back(req); 
  endfunction
  
  //implement the  run_phase to conitinuously check for incoming packets 
  virtual task run_phase(uvm_phase phase);  
   
    forever begin  
      wait(packetQueue.size()>0);  
      packet = packetQueue.pop_front();  
      //implement the logic to calculate the reference values and compare them witht the actual results
      refPacket.rst_l = packet.rst_l;            // Copy reset signal
      refPacket.scan_mode = packet.scan_mode;    // Copy scan mode
      refPacket.valid_in = packet.valid_in;      // Copy valid input signal
      refPacket.ap = packet.ap;                  // Copy ALU predecode structure (rtl_alu_pkt_t type)
      refPacket.csr_ren_in = packet.csr_ren_in;  // Copy CSR read enable
      refPacket.csr_rddata_in = packet.csr_rddata_in; // Copy CSR data input
      refPacket.a_in = packet.a_in;              // Copy operand A
      refPacket.b_in = packet.b_in;              // Copy operand B

      // Calculate the reference output
      ref_mod.Bit_Manipulation_Unit(packet.rst_l, packet.scan_mode, packet.ap, packet.a_in, packet.b_in, packet.valid_in, packet.csr_ren_in, packet.csr_rddata_in, refPacket.result_ff,refPacket.error);
           
      if(is_equal(packet,refPacket)) begin  
          // Log pass message when the packets match
        `uvm_info("PASS", $sformatf("----::Match::----\n------------------------------------------------------------\n---------------------Actual Packet(DUT):----------------------------------------------\n-----------------------------------------------------\n%s\n*****************************************************************************************************************************************\n(DUT)*************************result_ff: 0x%h (%0b) [Decimal: %0d]       ,       error: %0b****************************************************\n**********************************************************************************************************************************************************************\n\n------------------------------------------------------\n---------------------Expected Packet (REF_module):----------------------------------\n-------------------------------------------------------------\n%s\n***************************************************************************************************************************************************\n(ref_mod)*************************result_ff: 0x%h (%0b) [Decimal: %0d]       ,      error: %0b *************************\n**********************************************************************************************************************************************\n\n\n",packet.convert2string(),packet.result_ff,packet.result_ff,packet.result_ff,packet.error,refPacket.convert2string(),refPacket.result_ff,refPacket.result_ff,refPacket.result_ff,refPacket.error), UVM_LOW);
        end else begin
          // Log fail message when the packets do not match
          `uvm_error("MISMATCH", $sformatf("----::Mismatch::----\n------------------------------------------------------------\n---------------------Actual Packet(DUT):--------------------------\n----------------------------------------\n%s\n*********************************************************************************************************************************************\n(DUT)*************************result_ff: 0x%h (%0b) [Decimal: %0d]      ,     error: %0b********************************************************** \n\n------------------------------------------------------\n---------------------Expected Packet (REF_module):----------------------------------\n---------------------------------------------------\n%s\n***************************************************************************************************************\n(ref_mod)*************************result_ff: 0x%h (%0b) [Decimal: %0d],          error: %0b ************************************************************\n\n\n",packet.convert2string(),packet.result_ff,packet.result_ff,packet.result_ff,packet.error,refPacket.convert2string(),refPacket.result_ff,refPacket.result_ff,refPacket.result_ff,refPacket.error));
        end
      end
endtask
      
  function bit is_equal(BMU_sequence_item reference, BMU_sequence_item packet);
    return (reference.result_ff === packet.result_ff) &&
         (reference.error === packet.error) &&
         (reference.a_in === packet.a_in) &&
         (reference.b_in === packet.b_in) &&
         (reference.rst_l === packet.rst_l) &&
         (reference.scan_mode === packet.scan_mode) &&
         (reference.valid_in === packet.valid_in) &&
         (reference.ap === packet.ap) &&
         (reference.csr_ren_in === packet.csr_ren_in) &&
         (reference.csr_rddata_in === packet.csr_rddata_in);
   endfunction 
endclass 
// `endif
     
      
      
      