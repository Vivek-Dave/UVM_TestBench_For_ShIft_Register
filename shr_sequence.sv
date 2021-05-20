
/***************************************************
** class name  : shr_sequence
** description : generate random input for DUT
***************************************************/
class shr_sequence extends uvm_sequence#(shr_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(shr_sequence)            
  //----------------------------------------------------------------------------

  shr_sequence_item txn;
  int N=30;

  //----------------------------------------------------------------------------
  function new(string name="shr_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    repeat(N) begin 
      txn=shr_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize();
      txn.rst=0;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass:shr_sequence

/***************************************************
** class name  : rst_sequence
** description : it will reset DUT
***************************************************/
class rst_sequence extends shr_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(rst_sequence)      
  //----------------------------------------------------------------------------
  
  shr_sequence_item txn;
  
  //----------------------------------------------------------------------------
  function new(string name="rst_sequence");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn=shr_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.in=0;
    txn.rst=1;
    finish_item(txn);
  endtask:body
  //----------------------------------------------------------------------------
  
endclass