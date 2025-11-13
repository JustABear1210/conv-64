`timescale 1 ns / 1 ps

	module myip_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4
	)
	(
		// Users to add ports here
		//bram0
		input wire [12:0] addr_a,
        input wire clk_a,
        input wire [63:0] din_a,
        output wire [63:0] dout_a,
        input wire en_a,
        input wire we_a,
        //bram1
        input wire [12:0] addra0,
        input wire clka0,
        input wire [63:0] dina0,
        output wire [63:0] douta0,
        input wire ena0,
        input wire wea0,
        
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
    (* keep = "true" *) wire data_in;
    (* keep = "true" *) wire data_out;
	myip_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) myip_v1_0_S00_AXI_inst (
        .data_in(data_in),
        .op_st(op_st),
        .rst(rst),    
        .out_done(out_done),
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

	// Add user logic here
	
	    (* keep = "true" *) wire bram_ena, bram_wea;
        (* keep = "true" *) wire [8:0] bram_addra;
        (* keep = "true" *) wire [63:0] bram_dina, bram_douta;

        reg opst_delay;
        always @ (posedge s00_axi_aclk ) begin 
            opst_delay <= op_st;
        end
        
        assign bram_ena = data_in ? en_a : opst_delay ? 1 : 0 ;
        assign bram_wea = data_in ? we_a : 0 ;
        (* keep = "true" *) reg [6:0] cnt;
        assign bram_addra = data_in ? addr_a >> 3 : opst_delay ? cnt : 0 ;
        assign bram_dina = data_in ? din_a[63:0] : 0;
	    blk_mem_gen_a brama(.clka(s00_axi_aclk), .addra(bram_addra), .dina(bram_dina), .douta(bram_douta), .wea(bram_wea), .ena(bram_ena)) ; 
        always@(posedge s00_axi_aclk) begin
          if(rst) cnt <= 0 ;
          else if(cnt == 31) cnt <= cnt ;
          else if(opst_delay) cnt <= cnt + 1 ;
          else cnt <= 0 ;
        end
    
        // kernel data
        (* keep = "true" *) wire [15:0]kernel0_a, kernel1_a, kernel2_a, kernel3_a;
        assign kernel0_a = bram_douta[63:48];
        assign kernel1_a = bram_douta[47:32];
        assign kernel2_a = bram_douta[31:16];
        assign kernel3_a = bram_douta[15:0];
        
       (* keep = "true" *)wire [63:0] kernel_out;
       (* keep = "true" *) wire st_out, done;
 
        Fourbyfour my_fourbyfour( 
            .clk(s00_axi_aclk), 
            .op_st(op_st),
            .rst(rst),    
            .a0(kernel0_a), .a1(kernel1_a), .a2(kernel2_a), .a3(kernel3_a),
            .dout(kernel_out),
            .st_out(st_out), .done(done)
        );
	
   
        // 輸出位址計數
        reg [5:0] out_cnt;
        always @(posedge s00_axi_aclk) begin
            if (rst)                    out_cnt <= 0;
            else if (out_cnt == 17)     out_cnt <= out_cnt;
            else if (st_out)      out_cnt <= out_cnt + 1;
            else                        out_cnt <= 0;
        end
	
	
        (* keep = "true" *) wire [8:0] bram_out_addr;
        (* keep = "true" *) wire [63:0] bram_out_din, bram_out_dout;
        (* keep = "true" *) wire bram_out_we, bram_out_en;
        
        assign bram_out_en = 1'b1 ;
        assign bram_out_we = st_out ? 1'b1 : 1'b0 ;
        assign bram_out_addr = st_out ? out_cnt : done ?  addra0 >> 3 : 0 ;

        
        assign bram_out_din = kernel_out;

       
        blk_mem_gen_out bramout0(.clka(s00_axi_aclk), .addra(bram_out_addr), .dina(bram_out_din), .douta(bram_out_dout), .wea(bram_out_we), .ena(bram_out_en)) ; 

        
        assign douta0 = done ? bram_out_dout : 0;

        
        assign out_done = done;
	// User logic ends

	endmodule