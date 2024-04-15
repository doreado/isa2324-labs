class refmod extends uvm_component;
    `uvm_component_utils(refmod)
    
    packet_in tr_in;
    packet_out tr_out;
    uvm_get_port #(packet_in) in;
    uvm_put_port #(packet_out) out;

    rand bit [15:0] results[12];
    
    function new(string name = "refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = packet_out::type_id::create("tr_out", this);
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        // read into results
        $readmemb("./refmod/result_c.txt", results);

        for (int i = 0; i < 12; i+=1) begin
            in.get(tr_in);
            tr_out.data = results[i];
            $display("refmod: A      B        OUT");
            $display("        %6d  %6d  %6d", tr_in.A, tr_in.B, tr_out.data);
            $display("        0x%04h  0x%04h  0x%04h", tr_in.A, tr_in.B, tr_out.data);
            out.put(tr_out);
        end
    endtask: run_phase
endclass: refmod
