
# Read the verilog design files
set include_dir [getenv INCLUDE_DIR]
set search_path [concat $search_path $include_dir ../rtl/]
set target_library gscl45nm.db
set link_library gscl45nm.db


# Configure before running the script
# For Report Generations
set REPORTS_DIR reports
set NETLIST_DIR netlist
set NETLIST_EXT .v
set SEPARATOR   _
set EXT         .txt
set AREA	area
set TIMING      timing
set MODULE_NAME register_file
# Set for different runs
# multiple options possible 
# Change these options as needed
set NUM_REGS	32
set DATA_WIDTH  64
set LOG2_NUM_REGS 5
# multiple options possible 
# Change these options as needed
# if NUM_REGS =32 and DATA_WIDTH=64
analyze -f verilog -d {DATA_WIDTH_IS_64,NUMBER_OF_REGISTERS_IS_32} register_file.v
# Create user defined variables 
#set current_design $MODULE_NAME
elaborate $MODULE_NAME -parameter "LOG2_NUM_REGS=$LOG2_NUM_REGS,NUM_REGS=$NUM_REGS, DATA_WIDTH=$DATA_WIDTH"
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
report_area > $REPORTS_DIR/$MODULE_NAME$SEPARATOR$NUM_REGS$SEPARATOR$DATA_WIDTH$SEPARATOR$AREA$EXT
report_timing > $REPORTS_DIR/$MODULE_NAME$SEPARATOR$NUM_REGS$SEPARATOR$DATA_WIDTH$SEPARATOR$TIMING$EXT
write -hierarchy -format verilog -output $NETLIST_DIR/$MODULE_NAME$SEPARATOR$NUM_REGS$SEPARATOR$DATA_WIDTH$NETLIST_EXT
#quit
