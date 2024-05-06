// This code snippet was auto generated by xls2vlog.py from source file: ./user_project_wrapper.xlsx
// User: josh
// Date: Sep-22-23



module USER_PRJ0 #( parameter pUSER_PROJECT_SIDEBAND_WIDTH   = 5,
          parameter pADDR_WIDTH   = 12,
                   parameter pDATA_WIDTH   = 32
                 )
(
  output wire                        awready,
  output wire                        arready,
  output wire                        wready,
  output wire                        rvalid,
  output wire  [(pDATA_WIDTH-1) : 0] rdata,
  input  wire                        awvalid,
  input  wire                [11: 0] awaddr,
  input  wire                        arvalid,
  input  wire                [11: 0] araddr,
  input  wire                        wvalid,
  input  wire                 [3: 0] wstrb,
  input  wire  [(pDATA_WIDTH-1) : 0] wdata,
  input  wire                        rready,
  input  wire                        ss_tvalid,
  input  wire  [(pDATA_WIDTH-1) : 0] ss_tdata,
  input  wire                 [1: 0] ss_tuser,
    `ifdef USER_PROJECT_SIDEBAND_SUPPORT
  input  wire                 [pUSER_PROJECT_SIDEBAND_WIDTH-1: 0] ss_tupsb,
  `endif
  input  wire                 [3: 0] ss_tstrb,
  input  wire                 [3: 0] ss_tkeep,
  input  wire                        ss_tlast,
  input  wire                        sm_tready,
  output wire                        ss_tready,
  output wire                        sm_tvalid,
  output wire  [(pDATA_WIDTH-1) : 0] sm_tdata,
  output wire                 [2: 0] sm_tid,
  `ifdef USER_PROJECT_SIDEBAND_SUPPORT
  output  wire                 [pUSER_PROJECT_SIDEBAND_WIDTH-1: 0] sm_tupsb,
  `endif
  output wire                 [3: 0] sm_tstrb,
  output wire                 [3: 0] sm_tkeep,
  output wire                        sm_tlast,
  output wire                        low__pri_irq,
  output wire                        High_pri_req,
  output wire                [23: 0] la_data_o,
  input  wire                        axi_clk,
  input  wire                        axis_clk,
  input  wire                        axi_reset_n,
  input  wire                        axis_rst_n,
  input  wire                        user_clock2,
  input  wire                        uck2_rst_n
);


assign sm_tid        = 3'b0;
`ifdef USER_PROJECT_SIDEBAND_SUPPORT
  assign sm_tupsb      = 5'b0;
`endif
assign sm_tstrb      = 4'b0;
assign sm_tkeep      = 1'b0;
assign low__pri_irq  = 1'b0;
assign High_pri_req  = 1'b0;
assign la_data_o     = 24'b0;

// ram for tap
wire [3:0]               tap_WE;
wire                     tap_EN;
wire [(pDATA_WIDTH-1):0] tap_Di;
wire [(pADDR_WIDTH-1):0] tap_A;
wire [(pDATA_WIDTH-1):0] tap_Do;

// ram for data RAM
wire [3:0]               data_WE;
wire                     data_EN;
wire [(pDATA_WIDTH-1):0] data_Di;
wire [(pADDR_WIDTH-1):0] data_A;
wire [(pDATA_WIDTH-1):0] data_Do;

// RAM for tap
bram11 tap_RAM (
	.clk(axis_clk),
	.we(tap_WE),
	.re(tap_EN),
	.wdi(tap_Di),
	.waddr(tap_A >> 2),
	.raddr(tap_A >> 2),
	.rdo(tap_Do)
);

// RAM for data: choose bram11 or bram12
bram11 data_RAM(
	.clk(axis_clk),
	.we(data_WE),
	.re(data_EN),
	.wdi(data_Di),
	.waddr(data_A >> 2),
	.raddr(data_A >> 2),
	.rdo(data_Do)
);

fir inst_fir(
	// axi-lite for write config(status)
	.awready(awready),
	.wready(wready),
	.awvalid(awvalid),
	.awaddr(awaddr),
	.wvalid(wvalid),
	.wdata(wdata),

	// axi-lite for read config(status)
	.arready(arready),
	.rready(rready),
	.arvalid(rvalid),
	.araddr(raddr),
	.rvalid(rvalid),
	.rdata(rdata),

	// axi-stream for input x
	.ss_tvalid(ss_tvalid),
	.ss_tdata(ss_tdata),
	.ss_tlast(ss_tlast),
	.ss_tready(ss_tready),

	// axi-stream for output y
	.sm_tready(sm_tready),
	.sm_tvalid(sm_tvalid),
	.sm_tdata(sm_tdata),
	.sm_tlast(sm_tlast),

	// ram for tap
        .tap_WE(tap_WE),
        .tap_EN(tap_EN),
        .tap_Di(tap_Di),
        .tap_A(tap_A),
        .tap_Do(tap_Do),

        // ram for data
        .data_WE(data_WE),
        .data_EN(data_EN),
        .data_Di(data_Di),
        .data_A(data_A),
        .data_Do(data_Do),

	// other signals
	.axis_clk(axis_clk),
	.axis_rst_n(axis_rst_n)
);


endmodule // USER_PRJ1
