
class shr_env extends uvm_env;

   //---------------------------------------------------------------------------
   `uvm_component_utils(shr_env)
   //---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="shr_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- class handles -----------------------------------------
  shr_agent    agent_h;
  shr_coverage coverage_h;
  shr_scoreboard scoreboard_h;
  //----------------------------------------------------------------------------

  //---------------------- build phase -----------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_h    = shr_agent::type_id::create("agent_h",this);
    coverage_h = shr_coverage::type_id::create("coverage_h",this);
    scoreboard_h = shr_scoreboard::type_id::create("scoreboard_h",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------------- connect phase -----------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent_h.monitor_h.ap_mon.connect(coverage_h.analysis_export);
    agent_h.monitor_h.ap_mon.connect(scoreboard_h.aport_mon);
    agent_h.driver_h.drv2sb.connect(scoreboard_h.aport_drv);
  endfunction
  //----------------------------------------------------------------------------
endclass:shr_env

