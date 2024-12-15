// `ifndef BMU_enviroment
// `define BMU_enviroment

class BMU_enviroment extends uvm_env;
  // Register this class with the UVM factory
  `uvm_component_utils(BMU_enviroment)

  
  function new(string name,uvm_component parent);  
    super.new(name,parent);  
  endfunction  
  
  
  // handle the agent, scoreboard and subscriber
  BMU_agent agent;
  BMU_scoreboard scoreboard;
  BMU_subscriber subscriber;
  
  //use th factory to instantiate the components in ALU_enviroment
  function void build_phase(uvm_phase phase);  
    super.build_phase(phase);  
    agent = BMU_agent::type_id::create("agent", this);  
    scoreboard = BMU_scoreboard::type_id::create("scoreboard", this);  
    subscriber = BMU_subscriber::type_id::create("subscriber", this);  
  endfunction


//   connect phase
  function void connect_phase(uvm_phase phase);  
    agent.monitor.port.connect(scoreboard.exp);
    agent.monitor.port.connect(subscriber.analysis_export);
  endfunction 
endclass
//  `endif