
class shr_agent extends uvm_agent;

  //----------------------------------------------------------------------------
  `uvm_component_utils(shr_agent)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="shr_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------

  //----------------- class handles --------------------------------------------
  shr_sequencer sequencer_h;
  shr_driver    driver_h;
  shr_monitor   monitor_h;
  //----------------------------------------------------------------------------

  //---------------------- build phase -----------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver_h    = shr_driver::type_id::create("driver_h",this);
    sequencer_h = shr_sequencer::type_id::create("sequencer_h",this);
    monitor_h   = shr_monitor::type_id::create("monitor_h",this);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------- connect phase --------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
  endfunction
  //----------------------------------------------------------------------------

endclass:shr_agent

