vcs +incdir+$INCLUDE_DIR default_val_test_16_32.sv ../rtl/register_file.v +define+DATA_WIDTH_IS_32 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR default_val_test_32_32.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_32+DATA_WIDTH_IS_32 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR default_val_test_64_32.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_64+DATA_WIDTH_IS_32 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR default_val_test_16_64.sv ../rtl/register_file.v +define+DATA_WIDTH_IS_64 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR default_val_test_32_64.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_32+DATA_WIDTH_IS_64 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR default_val_test_64_64.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_64+DATA_WIDTH_IS_64 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR write_read_each_bit_16_32.sv ../rtl/register_file.v +define+DATA_WIDTH_IS_32 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR write_read_each_bit_32_32.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_32+DATA_WIDTH_IS_32 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR write_read_each_bit_64_32.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_64+DATA_WIDTH_IS_32 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR write_read_each_bit_64_64.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_64+DATA_WIDTH_IS_64 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR write_read_each_bit_32_64.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_32+DATA_WIDTH_IS_64 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR random_write_read_16_32.sv ../rtl/register_file.v +define+DATA_WIDTH_IS_32 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR random_write_read_32_32.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_32+DATA_WIDTH_IS_32 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR random_write_read_64_32.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_64+DATA_WIDTH_IS_32 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR random_write_read_64_64.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_64+DATA_WIDTH_IS_64 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR random_write_read_32_64.sv ../rtl/register_file.v +define+NUMBER_OF_REGISTERS_IS_32+DATA_WIDTH_IS_64 +v2k -sverilog
./simv
vcs +incdir+$INCLUDE_DIR random_write_read_16_64.sv ../rtl/register_file.v +define+DATA_WIDTH_IS_64 +v2k -sverilog
./simv
