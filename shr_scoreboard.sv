
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class shr_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(shr_scoreboard)
  
  uvm_analysis_imp_drv #(shr_sequence_item, shr_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(shr_sequence_item, shr_scoreboard) aport_mon;
  
  uvm_tlm_fifo #(shr_sequence_item) expfifo;
  uvm_tlm_fifo #(shr_sequence_item) outfifo;
  
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  bit t_rst;
  bit [3:0] t_in;
  bit [3:0] t_out;
  

  function new(string name="shr_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
    
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	aport_drv = new("aport_drv", this);
	aport_mon = new("aport_mon", this);
	expfifo= new("expfifo",this);
	outfifo= new("outfifo",this);
  endfunction

  int count;
  int q[$]={0,0,0};
  function void write_drv(shr_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    t_rst = tr.rst;
    t_in  = tr.in;
    if(t_rst==1) begin 
        t_out=0;
      	count=0;
      q={0,0,0};
      $display("\n @restart : quese size=%d   \n",q.size());
    end
    else begin
      q.push_back(t_in);
      if(count==1)
        t_out=0;
      else 
        t_out=q[count-2];
    end
    tr.out = t_out;
    count++;
    void'(expfifo.try_put(tr));
  endfunction

  function void write_mon(shr_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  
  task run_phase(uvm_phase phase);
	shr_sequence_item exp_tr, out_tr;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
      if (out_tr.out===exp_tr.out && count>2) begin
            PASS();
        `uvm_info ("PASS ",out_tr.convert2string() , UVM_LOW)
	end
      
      else if(out_tr.out!==exp_tr.out && count>2) begin
	   ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_LOW)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_LOW)
          `uvm_warning("ERROR",exp_tr.convert2string())
	end
    end
  endtask

  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
          `uvm_info("PASSED",$sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",VECT_CNT, PASS_CNT), UVM_LOW)
        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed***",VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction

  function void PASS();
	VECT_CNT++;
	PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction

endclass

