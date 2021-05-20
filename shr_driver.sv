
class shr_driver extends uvm_driver #(shr_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(shr_driver)
  //----------------------------------------------------------------------------
  uvm_analysis_port #(shr_sequence_item) drv2sb;
  //----------------------------------------------------------------------------
  function new(string name="shr_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  //---------------------------------------------------------------------------- 

  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface");
    end
    drv2sb=new("drv2sb",this);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    shr_sequence_item txn=shr_sequence_item::type_id::create("txn");
    initilize();
    forever begin
      seq_item_port.get_next_item(txn);
      drive_item(txn);
      drv2sb.write(txn);
      seq_item_port.item_done();    
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task initilize();
    vif.rst=0;
    vif.in =0;
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task drive_item(shr_sequence_item tr);
    @vif.cb;
    vif.cb.in  <= tr.in;
    vif.cb.rst <= tr.rst;
  endtask
  //----------------------------------------------------------------------------
  
endclass:shr_driver