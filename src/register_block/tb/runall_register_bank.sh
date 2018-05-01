vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_8_16_32.sv -sverilog +v2k +define+DATA_WIDTH_IS_32
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_8_16_64.sv -sverilog +v2k +define+DATA_WIDTH_IS_64
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_8_32_32.sv -sverilog +v2k +define+DATA_WIDTH_IS_32+NUMBER_OF_REGISTERS_IS_32
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_8_32_64.sv -sverilog +v2k +define+DATA_WIDTH_IS_64+NUMBER_OF_REGISTERS_IS_32
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_8_64_32.sv -sverilog +v2k +define+DATA_WIDTH_IS_32+NUMBER_OF_REGISTERS_IS_64
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_8_64_64.sv -sverilog +v2k +define+DATA_WIDTH_IS_64+NUMBER_OF_REGISTERS_IS_64
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_16_16_32.sv -sverilog +v2k +define+DATA_WIDTH_IS_32+NUM_LANES_IS_16
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_16_16_64.sv -sverilog +v2k +define+DATA_WIDTH_IS_64+NUM_LANES_IS_16
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_16_32_32.sv -sverilog +v2k +define+DATA_WIDTH_IS_32+NUM_LANES_IS_16+NUMBER_OF_REGISTERS_IS_32
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_16_32_64.sv -sverilog +v2k +define+DATA_WIDTH_IS_64+NUM_LANES_IS_16+NUMBER_OF_REGISTERS_IS_32
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_16_64_32.sv -sverilog +v2k +define+DATA_WIDTH_IS_32+NUM_LANES_IS_16+NUMBER_OF_REGISTERS_IS_64
./simv
rm -rf simv* csrc
vcs +incdir+$INCLUDE_DIR ../../register_file/rtl/register_file.v ../rtl/register_bank.v write_read_test_all_lanes_16_64_64.sv -sverilog +v2k +define+DATA_WIDTH_IS_64+NUM_LANES_IS_16+NUMBER_OF_REGISTERS_IS_64
./simv
rm -rf simv* csrc
