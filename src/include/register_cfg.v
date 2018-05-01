
// Default parameters            
`ifdef NUMBER_OF_REGISTERS_IS_32 
	defparam RF_32.LOG2_NUM_REGS =5;
	defparam RF_32.NUM_REGS      =32;
	`ifdef DATA_WIDTH_IS_64
        defparam RF_32.DATA_WIDTH     = 64;
	`endif
`elsif NUMBER_OF_REGISTERS_IS_64 
	defparam RF_64.LOG2_NUM_REGS = 6;
	defparam RF_64.NUM_REGS	= 64;
	`ifdef DATA_WIDTH_IS_64
        defparam RF_64.DATA_WIDTH     = 64;
	`endif
`elsif DATA_WIDTH_IS_64
        defparam RF.DATA_WIDTH     = 64;
`endif
