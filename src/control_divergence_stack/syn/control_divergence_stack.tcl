
# Read the verilog design files
set include_dir [getenv INCLUDE_DIR]
set search_path [concat $search_path $include_dir ../rtl/]
set target_library gscl45nm.db
set link_library gscl45nm.db
set submodule stack

# Configure before running the script
# For Report Generations
set REPORTS_DIR reports
set NETLIST_DIR netlist
set NETLIST_EXT .v
set SEPARATOR   _
set EXT         .txt
set AREA	area
set TIMING      timing
set MODULE_NAME control_divergence_stack 
# Set for different runs
# multiple options possible 
# Change these options as needed
# set STACK_DEPTH 8
# set STACK_WIDTH 72
# set PC_WIDTH 32
# set LOG2_STACK_DEPTH 3
# multiple options possible 
# Change these options as needed
# if NUM_REGS =32 and DATA_WIDTH=64
analyze -f verilog $submodule.v
analyze -f verilog control_divergence_stack.v


# Create user defined variables 
#set current_design $MODULE_NAME
elaborate $MODULE_NAME
#elaborate $MODULE_NAME -parameter "LOG2_NUM_REGS=$LOG2_NUM_REGS,NUM_REGS=$NUM_REGS, DATA_WIDTH=$DATA_WIDTH"
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
report_area > $REPORTS_DIR/$MODULE_NAME$SEPARATOR$AREA$EXT
report_timing > $REPORTS_DIR/$MODULE_NAME$SEPARATOR$TIMING$EXT
write -hierarchy -format verilog -output $NETLIST_DIR/$MODULE_NAME$NETLIST_EXT
quit
