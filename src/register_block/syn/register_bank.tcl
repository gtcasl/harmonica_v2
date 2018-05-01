
# Read the verilog design files
set include_dir [getenv INCLUDE_DIR]
set submodule register_file
set search_path [concat $search_path $include_dir ../rtl/ ../../$submodule/rtl/]
set target_library gscl45nm.db
set link_library gscl45nm.db


# Configure before running the script
# For Report Generations
set REPORTS_DIR reports
set SEPARATOR   _
set EXT         .txt
set AREA	area
set TIMING      timing
set MODULE_NAME register_bank
# Set for different runs
# multiple options possible 
# Change these options as needed
set NUM_REGS	16
set DATA_WIDTH  32
set LOG2_NUM_REGS 4
set NUM_LANES   8
# multiple options possible 
# Change these options as needed
# if NUM_REGS =32 and DATA_WIDTH=64
analyze -f verilog -d {DATA_WIDTH_IS_32} $submodule.v
analyze -f verilog -d {DATA_WIDTH_IS_32} $MODULE_NAME.v
# Create user defined variables 
#set current_design $MODULE_NAME
elaborate $MODULE_NAME -parameter "NUM_LANES=$NUM_LANES,LOG2_NUM_REGS=$LOG2_NUM_REGS,NUM_REGS=$NUM_REGS, DATA_WIDTH=$DATA_WIDTH"
#r Create user defined variables 
set CLK_PORT [get_ports clk]
set CLK_PERIOD 10.00 
set CLK_SKEW 0.20

# Time Budget 
create_clock -period $CLK_PERIOD -name my_clock $CLK_PORT
#set_dont_touch_network my_clock
set_clock_uncertainty $CLK_SKEW [get_clocks my_clock]
link
compile
report_area > $REPORTS_DIR/$MODULE_NAME$SEPARATOR$NUM_LANES$SEPARATOR$NUM_REGS$SEPARATOR$DATA_WIDTH$SEPARATOR$AREA$EXT
report_timing > $REPORTS_DIR/$MODULE_NAME$SEPARATOR$NUM_LANES$SEPARATOR$NUM_REGS$SEPARATOR$DATA_WIDTH$SEPARATOR$TIMING$EXT
quit
