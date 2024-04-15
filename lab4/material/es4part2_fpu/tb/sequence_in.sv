class sequence_in extends uvm_sequence #(packet_in);

    rand bit [15:0] sample[24];

    `uvm_object_utils(sequence_in)

    function new(string name="sequence_in");
        super.new(name);
    endfunction: new

    task body;
        packet_in tx;

        $readmemb("./refmod/samples.txt", sample);

        for (int i = 0; i < 12; i+=2) begin
          tx = packet_in::type_id::create("tx");
          start_item(tx);
          tx.A = sample[i];
          tx.B = sample[i + 1];
          finish_item(tx);
        end
    endtask: body
endclass: sequence_in

