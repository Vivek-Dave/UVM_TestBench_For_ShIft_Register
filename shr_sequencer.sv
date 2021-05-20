

class shr_sequencer extends uvm_sequencer#(shr_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(shr_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="shr_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:shr_sequencer

