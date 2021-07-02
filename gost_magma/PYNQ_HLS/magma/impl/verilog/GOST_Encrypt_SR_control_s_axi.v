// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module GOST_Encrypt_SR_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 6,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire [7:0]                    Data_i,
    input  wire [7:0]                    Data_o,
    input  wire                          Data_o_ap_vld,
    output wire [31:0]                   Size,
    output wire [0:0]                    Mode,
    output wire [7:0]                    GOST_Table,
    output wire [7:0]                    GOST_Key
);
//------------------------Address Info-------------------
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of Data_i
//        bit 7~0 - Data_i[7:0] (Read/Write)
//        others  - reserved
// 0x14 : reserved
// 0x18 : Data signal of Data_o
//        bit 7~0 - Data_o[7:0] (Read)
//        others  - reserved
// 0x1c : Control signal of Data_o
//        bit 0  - Data_o_ap_vld (Read/COR)
//        others - reserved
// 0x20 : Data signal of Size
//        bit 31~0 - Size[31:0] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of Mode
//        bit 0  - Mode[0] (Read/Write)
//        others - reserved
// 0x2c : reserved
// 0x30 : Data signal of GOST_Table
//        bit 7~0 - GOST_Table[7:0] (Read/Write)
//        others  - reserved
// 0x34 : reserved
// 0x38 : Data signal of GOST_Key
//        bit 7~0 - GOST_Key[7:0] (Read/Write)
//        others  - reserved
// 0x3c : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_DATA_I_DATA_0     = 6'h10,
    ADDR_DATA_I_CTRL       = 6'h14,
    ADDR_DATA_O_DATA_0     = 6'h18,
    ADDR_DATA_O_CTRL       = 6'h1c,
    ADDR_SIZE_DATA_0       = 6'h20,
    ADDR_SIZE_CTRL         = 6'h24,
    ADDR_MODE_DATA_0       = 6'h28,
    ADDR_MODE_CTRL         = 6'h2c,
    ADDR_GOST_TABLE_DATA_0 = 6'h30,
    ADDR_GOST_TABLE_CTRL   = 6'h34,
    ADDR_GOST_KEY_DATA_0   = 6'h38,
    ADDR_GOST_KEY_CTRL     = 6'h3c,
    WRIDLE                 = 2'd0,
    WRDATA                 = 2'd1,
    WRRESP                 = 2'd2,
    WRRESET                = 2'd3,
    RDIDLE                 = 2'd0,
    RDDATA                 = 2'd1,
    RDRESET                = 2'd2,
    ADDR_BITS                = 6;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg  [7:0]                    int_Data_i = 'b0;
    reg                           int_Data_o_ap_vld;
    reg  [7:0]                    int_Data_o = 'b0;
    reg  [31:0]                   int_Size = 'b0;
    reg  [0:0]                    int_Mode = 'b0;
    reg  [7:0]                    int_GOST_Table = 'b0;
    reg  [7:0]                    int_GOST_Key = 'b0;

//------------------------Instantiation------------------


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
            case (raddr)
                ADDR_DATA_I_DATA_0: begin
                    rdata <= int_Data_i[7:0];
                end
                ADDR_DATA_O_DATA_0: begin
                    rdata <= int_Data_o[7:0];
                end
                ADDR_DATA_O_CTRL: begin
                    rdata[0] <= int_Data_o_ap_vld;
                end
                ADDR_SIZE_DATA_0: begin
                    rdata <= int_Size[31:0];
                end
                ADDR_MODE_DATA_0: begin
                    rdata <= int_Mode[0:0];
                end
                ADDR_GOST_TABLE_DATA_0: begin
                    rdata <= int_GOST_Table[7:0];
                end
                ADDR_GOST_KEY_DATA_0: begin
                    rdata <= int_GOST_Key[7:0];
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign Data_i     = int_Data_i;
assign Size       = int_Size;
assign Mode       = int_Mode;
assign GOST_Table = int_GOST_Table;
assign GOST_Key   = int_GOST_Key;
// int_Data_i[7:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_Data_i[7:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DATA_I_DATA_0)
            int_Data_i[7:0] <= (WDATA[31:0] & wmask) | (int_Data_i[7:0] & ~wmask);
    end
end

// int_Data_o
always @(posedge ACLK) begin
    if (ARESET)
        int_Data_o <= 0;
    else if (ACLK_EN) begin
        if (Data_o_ap_vld)
            int_Data_o <= Data_o;
    end
end

// int_Data_o_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_Data_o_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (Data_o_ap_vld)
            int_Data_o_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_DATA_O_CTRL)
            int_Data_o_ap_vld <= 1'b0; // clear on read
    end
end

// int_Size[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_Size[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_SIZE_DATA_0)
            int_Size[31:0] <= (WDATA[31:0] & wmask) | (int_Size[31:0] & ~wmask);
    end
end

// int_Mode[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_Mode[0:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_MODE_DATA_0)
            int_Mode[0:0] <= (WDATA[31:0] & wmask) | (int_Mode[0:0] & ~wmask);
    end
end

// int_GOST_Table[7:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_GOST_Table[7:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_GOST_TABLE_DATA_0)
            int_GOST_Table[7:0] <= (WDATA[31:0] & wmask) | (int_GOST_Table[7:0] & ~wmask);
    end
end

// int_GOST_Key[7:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_GOST_Key[7:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_GOST_KEY_DATA_0)
            int_GOST_Key[7:0] <= (WDATA[31:0] & wmask) | (int_GOST_Key[7:0] & ~wmask);
    end
end


//------------------------Memory logic-------------------

endmodule
