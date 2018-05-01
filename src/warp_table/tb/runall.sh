vcs -sverilog +v2k connectivity_test.sv ../rtl/warp_table.v
./simv
rm -rf simv*
vcs -sverilog +v2k warp_table_overflow_test.sv ../rtl/warp_table.v
./simv
rm -rf simv*
vcs -sverilog +v2k warp_table_bypass.sv ../rtl/warp_table.v
./simv
rm -rf simv*
vcs -sverilog +v2k warp_table_write_read_entry.sv ../rtl/warp_table.v 
./simv
