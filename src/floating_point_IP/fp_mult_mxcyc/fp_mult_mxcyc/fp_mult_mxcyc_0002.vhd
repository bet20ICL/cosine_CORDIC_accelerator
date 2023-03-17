-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from fp_mult_mxcyc_0002
-- VHDL created on Fri Mar 17 12:44:53 2023


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity fp_mult_mxcyc_0002 is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        b : in std_logic_vector(31 downto 0);  -- float32_m23
        en : in std_logic_vector(0 downto 0);  -- ufix1
        q : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        areset : in std_logic
    );
end fp_mult_mxcyc_0002;

architecture normal of fp_mult_mxcyc_0002 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expX_uid6_fpMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expY_uid7_fpMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal signX_uid8_fpMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signY_uid9_fpMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstAllOWE_uid10_fpMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWF_uid11_fpMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal cstAllZWE_uid12_fpMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_x_uid14_fpMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_x_uid15_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_x_uid15_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid16_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid16_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid17_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid17_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid18_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid18_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid19_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid19_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid20_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid21_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid22_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid23_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid23_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal frac_y_uid28_fpMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_y_uid29_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid29_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid30_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid30_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid31_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid31_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid32_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid32_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid33_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid33_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid34_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid35_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid36_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid37_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid37_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ofracX_uid40_fpMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal ofracY_uid43_fpMulTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expSum_uid44_fpMulTest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid44_fpMulTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid44_fpMulTest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expSum_uid44_fpMulTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal biasInc_uid45_fpMulTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal expSumMBias_uid46_fpMulTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid46_fpMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid46_fpMulTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal expSumMBias_uid46_fpMulTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal signR_uid48_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid48_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyRange_uid54_fpMulTest_in : STD_LOGIC_VECTOR (21 downto 0);
    signal stickyRange_uid54_fpMulTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal extraStickyBitOfProd_uid55_fpMulTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal extraStickyBitOfProd_uid55_fpMulTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid56_fpMulTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal extraStickyBit_uid56_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyExtendedRange_uid57_fpMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyRangeComparator_uid59_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyRangeComparator_uid59_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sticky_uid60_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm1dto0_uid61_fpMulTest_in : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostNorm1dto0_uid61_fpMulTest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal lrs_uid62_fpMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal roundBitDetectionConstant_uid63_fpMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal roundBitDetectionPattern_uid64_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBitDetectionPattern_uid64_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid65_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracPreRound_uid66_fpMulTest_q : STD_LOGIC_VECTOR (34 downto 0);
    signal roundBitAndNormalizationOp_uid68_fpMulTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal fracRPreExc_uid70_fpMulTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid70_fpMulTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExcExt_uid71_fpMulTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expRPreExc_uid72_fpMulTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expRPreExc_uid72_fpMulTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expUdf_uid73_fpMulTest_a : STD_LOGIC_VECTOR (13 downto 0);
    signal expUdf_uid73_fpMulTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal expUdf_uid73_fpMulTest_o : STD_LOGIC_VECTOR (13 downto 0);
    signal expUdf_uid73_fpMulTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal expOvf_uid75_fpMulTest_a : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid75_fpMulTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid75_fpMulTest_o : STD_LOGIC_VECTOR (13 downto 0);
    signal expOvf_uid75_fpMulTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYZ_uid76_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYR_uid77_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXR_uid78_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZC3_uid79_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid80_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIAndExcYI_uid81_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRAndExcYI_uid82_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYRAndExcXI_uid83_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ExcROvfAndInReg_uid84_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid85_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXI_uid86_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYI_uid87_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ZeroTimesInf_uid88_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid89_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid89_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid90_fpMulTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid91_fpMulTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal oneFracRPostExc2_uid92_fpMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPostExc_uid95_fpMulTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid95_fpMulTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPostExc_uid100_fpMulTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid100_fpMulTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal invExcRNaN_uid101_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid102_fpMulTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid102_fpMulTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal R_uid103_fpMulTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal osig_uid106_prod_uid47_fpMulTest_in : STD_LOGIC_VECTOR (47 downto 0);
    signal osig_uid106_prod_uid47_fpMulTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_bs1_in : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_bs1_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_bs4_in : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_bs4_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_bjA5_q : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_bs7_b : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_bjB9_q : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im10_a0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im10_b0 : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im10_s1 : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im10_pr : UNSIGNED (11 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im10_q : STD_LOGIC_VECTOR (11 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_bs11_b : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_join_13_q : STD_LOGIC_VECTOR (47 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_align_14_q : STD_LOGIC_VECTOR (43 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_align_14_qint : STD_LOGIC_VECTOR (43 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_BitExpansion_for_a_q : STD_LOGIC_VECTOR (35 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_SignBit_for_a_b : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_BitExpansion_for_b_q : STD_LOGIC_VECTOR (35 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_UpperBits_for_b_q : STD_LOGIC_VECTOR (9 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_b : STD_LOGIC_VECTOR (24 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_c : STD_LOGIC_VECTOR (10 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_BitSelect_for_b_b : STD_LOGIC_VECTOR (24 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p1_of_2_a : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p1_of_2_b : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p1_of_2_o : STD_LOGIC_VECTOR (25 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p1_of_2_q : STD_LOGIC_VECTOR (24 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p2_of_2_a : STD_LOGIC_VECTOR (12 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p2_of_2_b : STD_LOGIC_VECTOR (12 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p2_of_2_o : STD_LOGIC_VECTOR (12 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_p2_of_2_q : STD_LOGIC_VECTOR (10 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_BitJoin_for_q_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_a_q : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_UpperBits_for_a_q : STD_LOGIC_VECTOR (1 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_b_q : STD_LOGIC_VECTOR (49 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_SignBit_for_b_b : STD_LOGIC_VECTOR (0 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_UpperBits_for_b_q : STD_LOGIC_VECTOR (5 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_b : STD_LOGIC_VECTOR (24 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_c : STD_LOGIC_VECTOR (24 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_b : STD_LOGIC_VECTOR (24 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_c : STD_LOGIC_VECTOR (24 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_a : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_b : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_o : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q : STD_LOGIC_VECTOR (24 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_a : STD_LOGIC_VECTOR (26 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_b : STD_LOGIC_VECTOR (26 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_o : STD_LOGIC_VECTOR (26 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_q : STD_LOGIC_VECTOR (24 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitJoin_for_q_q : STD_LOGIC_VECTOR (49 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_p0_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_p0_q : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_p1_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_p1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_p2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_p2_q : STD_LOGIC_VECTOR (20 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_BitJoin_for_q_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expFracRPostRounding_uid69_fpMulTest_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (10 downto 0);
    signal normalizeBit_uid49_fpMulTest_tessel0_0_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel0_0_b : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel1_0_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel2_0_b : STD_LOGIC_VECTOR (20 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel0_0_b : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel1_0_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel2_0_b : STD_LOGIC_VECTOR (20 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_reset : std_logic;
    type prodXY_uid105_prod_uid47_fpMulTest_im0_cma_a0type is array(NATURAL range <>) of UNSIGNED(17 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_a0 : prodXY_uid105_prod_uid47_fpMulTest_im0_cma_a0type(0 to 0);
    attribute preserve : boolean;
    attribute preserve of prodXY_uid105_prod_uid47_fpMulTest_im0_cma_a0 : signal is true;
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_c0 : prodXY_uid105_prod_uid47_fpMulTest_im0_cma_a0type(0 to 0);
    attribute preserve of prodXY_uid105_prod_uid47_fpMulTest_im0_cma_c0 : signal is true;
    type prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ptype is array(NATURAL range <>) of UNSIGNED(35 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_p : prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ptype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_u : prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ptype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_w : prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ptype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_x : prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ptype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_y : prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ptype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_s : prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ptype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_qq : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ena0 : std_logic;
    signal prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ena1 : std_logic;
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_reset : std_logic;
    type prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_a0type is array(NATURAL range <>) of UNSIGNED(5 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_a0 : prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_a0type(0 to 1);
    attribute preserve of prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_a0 : signal is true;
    type prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_c0type is array(NATURAL range <>) of SIGNED(18 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_c0 : prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_c0type(0 to 1);
    attribute preserve of prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_c0 : signal is true;
    type prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ltype is array(NATURAL range <>) of SIGNED(6 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_l : prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ltype(0 to 1);
    type prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ptype is array(NATURAL range <>) of SIGNED(25 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_p : prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ptype(0 to 1);
    type prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_utype is array(NATURAL range <>) of SIGNED(26 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_u : prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_utype(0 to 1);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_w : prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_utype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_x : prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_utype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_y : prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_utype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_s : prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_utype(0 to 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_qq : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_q : STD_LOGIC_VECTOR (25 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ena0 : std_logic;
    signal prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ena1 : std_logic;
    signal prodXY_uid105_prod_uid47_fpMulTest_bs2_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid105_prod_uid47_fpMulTest_bs2_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal redist0_prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_q_1_q : STD_LOGIC_VECTOR (25 downto 0);
    signal redist1_prodXY_uid105_prod_uid47_fpMulTest_im0_cma_q_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal redist2_normalizeBit_uid49_fpMulTest_tessel0_0_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_fracRPostNorm_uid53_fpMulTest_BitJoin_for_q_q_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist4_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q_1_q : STD_LOGIC_VECTOR (24 downto 0);
    signal redist5_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_c_1_q : STD_LOGIC_VECTOR (24 downto 0);
    signal redist6_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_c_1_q : STD_LOGIC_VECTOR (24 downto 0);
    signal redist7_expFracRPostRounding_uid69_fpMulTest_p1_of_2_q_1_q : STD_LOGIC_VECTOR (24 downto 0);
    signal redist8_expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_c_1_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist9_prodXY_uid105_prod_uid47_fpMulTest_im10_q_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist10_expRPreExc_uid72_fpMulTest_b_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist11_fracRPreExc_uid70_fpMulTest_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist12_signR_uid48_fpMulTest_q_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_expSum_uid44_fpMulTest_q_6_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist14_excI_y_uid33_fpMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_fracXIsZero_uid31_fpMulTest_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_expXIsMax_uid30_fpMulTest_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_expXIsMax_uid30_fpMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_excZ_y_uid29_fpMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist19_excZ_y_uid29_fpMulTest_q_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_excI_x_uid19_fpMulTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_fracXIsZero_uid17_fpMulTest_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist22_expXIsMax_uid16_fpMulTest_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_expXIsMax_uid16_fpMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_excZ_x_uid15_fpMulTest_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_excZ_x_uid15_fpMulTest_q_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_expSum_uid44_fpMulTest_q_6_outputreg_q : STD_LOGIC_VECTOR (8 downto 0);

begin


    -- frac_x_uid14_fpMulTest(BITSELECT,13)@0
    frac_x_uid14_fpMulTest_b <= a(22 downto 0);

    -- cstZeroWF_uid11_fpMulTest(CONSTANT,10)
    cstZeroWF_uid11_fpMulTest_q <= "00000000000000000000000";

    -- fracXIsZero_uid17_fpMulTest(LOGICAL,16)@0 + 1
    fracXIsZero_uid17_fpMulTest_qi <= "1" WHEN cstZeroWF_uid11_fpMulTest_q = frac_x_uid14_fpMulTest_b ELSE "0";
    fracXIsZero_uid17_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid17_fpMulTest_qi, xout => fracXIsZero_uid17_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist21_fracXIsZero_uid17_fpMulTest_q_8(DELAY,191)
    redist21_fracXIsZero_uid17_fpMulTest_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid17_fpMulTest_q, xout => redist21_fracXIsZero_uid17_fpMulTest_q_8_q, ena => en(0), clk => clk, aclr => areset );

    -- cstAllOWE_uid10_fpMulTest(CONSTANT,9)
    cstAllOWE_uid10_fpMulTest_q <= "11111111";

    -- expX_uid6_fpMulTest(BITSELECT,5)@0
    expX_uid6_fpMulTest_b <= a(30 downto 23);

    -- expXIsMax_uid16_fpMulTest(LOGICAL,15)@0 + 1
    expXIsMax_uid16_fpMulTest_qi <= "1" WHEN expX_uid6_fpMulTest_b = cstAllOWE_uid10_fpMulTest_q ELSE "0";
    expXIsMax_uid16_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid16_fpMulTest_qi, xout => expXIsMax_uid16_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist22_expXIsMax_uid16_fpMulTest_q_8(DELAY,192)
    redist22_expXIsMax_uid16_fpMulTest_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid16_fpMulTest_q, xout => redist22_expXIsMax_uid16_fpMulTest_q_8_q, ena => en(0), clk => clk, aclr => areset );

    -- excI_x_uid19_fpMulTest(LOGICAL,18)@8 + 1
    excI_x_uid19_fpMulTest_qi <= redist22_expXIsMax_uid16_fpMulTest_q_8_q and redist21_fracXIsZero_uid17_fpMulTest_q_8_q;
    excI_x_uid19_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excI_x_uid19_fpMulTest_qi, xout => excI_x_uid19_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- cstAllZWE_uid12_fpMulTest(CONSTANT,11)
    cstAllZWE_uid12_fpMulTest_q <= "00000000";

    -- expY_uid7_fpMulTest(BITSELECT,6)@0
    expY_uid7_fpMulTest_b <= b(30 downto 23);

    -- excZ_y_uid29_fpMulTest(LOGICAL,28)@0 + 1
    excZ_y_uid29_fpMulTest_qi <= "1" WHEN expY_uid7_fpMulTest_b = cstAllZWE_uid12_fpMulTest_q ELSE "0";
    excZ_y_uid29_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_y_uid29_fpMulTest_qi, xout => excZ_y_uid29_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist18_excZ_y_uid29_fpMulTest_q_9(DELAY,188)
    redist18_excZ_y_uid29_fpMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_y_uid29_fpMulTest_q, xout => redist18_excZ_y_uid29_fpMulTest_q_9_q, ena => en(0), clk => clk, aclr => areset );

    -- excYZAndExcXI_uid86_fpMulTest(LOGICAL,85)@9
    excYZAndExcXI_uid86_fpMulTest_q <= redist18_excZ_y_uid29_fpMulTest_q_9_q and excI_x_uid19_fpMulTest_q;

    -- frac_y_uid28_fpMulTest(BITSELECT,27)@0
    frac_y_uid28_fpMulTest_b <= b(22 downto 0);

    -- fracXIsZero_uid31_fpMulTest(LOGICAL,30)@0 + 1
    fracXIsZero_uid31_fpMulTest_qi <= "1" WHEN cstZeroWF_uid11_fpMulTest_q = frac_y_uid28_fpMulTest_b ELSE "0";
    fracXIsZero_uid31_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid31_fpMulTest_qi, xout => fracXIsZero_uid31_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist15_fracXIsZero_uid31_fpMulTest_q_8(DELAY,185)
    redist15_fracXIsZero_uid31_fpMulTest_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid31_fpMulTest_q, xout => redist15_fracXIsZero_uid31_fpMulTest_q_8_q, ena => en(0), clk => clk, aclr => areset );

    -- expXIsMax_uid30_fpMulTest(LOGICAL,29)@0 + 1
    expXIsMax_uid30_fpMulTest_qi <= "1" WHEN expY_uid7_fpMulTest_b = cstAllOWE_uid10_fpMulTest_q ELSE "0";
    expXIsMax_uid30_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid30_fpMulTest_qi, xout => expXIsMax_uid30_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist16_expXIsMax_uid30_fpMulTest_q_8(DELAY,186)
    redist16_expXIsMax_uid30_fpMulTest_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid30_fpMulTest_q, xout => redist16_expXIsMax_uid30_fpMulTest_q_8_q, ena => en(0), clk => clk, aclr => areset );

    -- excI_y_uid33_fpMulTest(LOGICAL,32)@8 + 1
    excI_y_uid33_fpMulTest_qi <= redist16_expXIsMax_uid30_fpMulTest_q_8_q and redist15_fracXIsZero_uid31_fpMulTest_q_8_q;
    excI_y_uid33_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excI_y_uid33_fpMulTest_qi, xout => excI_y_uid33_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- excZ_x_uid15_fpMulTest(LOGICAL,14)@0 + 1
    excZ_x_uid15_fpMulTest_qi <= "1" WHEN expX_uid6_fpMulTest_b = cstAllZWE_uid12_fpMulTest_q ELSE "0";
    excZ_x_uid15_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_x_uid15_fpMulTest_qi, xout => excZ_x_uid15_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist24_excZ_x_uid15_fpMulTest_q_9(DELAY,194)
    redist24_excZ_x_uid15_fpMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_x_uid15_fpMulTest_q, xout => redist24_excZ_x_uid15_fpMulTest_q_9_q, ena => en(0), clk => clk, aclr => areset );

    -- excXZAndExcYI_uid87_fpMulTest(LOGICAL,86)@9
    excXZAndExcYI_uid87_fpMulTest_q <= redist24_excZ_x_uid15_fpMulTest_q_9_q and excI_y_uid33_fpMulTest_q;

    -- ZeroTimesInf_uid88_fpMulTest(LOGICAL,87)@9
    ZeroTimesInf_uid88_fpMulTest_q <= excXZAndExcYI_uid87_fpMulTest_q or excYZAndExcXI_uid86_fpMulTest_q;

    -- fracXIsNotZero_uid32_fpMulTest(LOGICAL,31)@8 + 1
    fracXIsNotZero_uid32_fpMulTest_qi <= not (redist15_fracXIsZero_uid31_fpMulTest_q_8_q);
    fracXIsNotZero_uid32_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsNotZero_uid32_fpMulTest_qi, xout => fracXIsNotZero_uid32_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist17_expXIsMax_uid30_fpMulTest_q_9(DELAY,187)
    redist17_expXIsMax_uid30_fpMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist16_expXIsMax_uid30_fpMulTest_q_8_q, xout => redist17_expXIsMax_uid30_fpMulTest_q_9_q, ena => en(0), clk => clk, aclr => areset );

    -- excN_y_uid34_fpMulTest(LOGICAL,33)@9
    excN_y_uid34_fpMulTest_q <= redist17_expXIsMax_uid30_fpMulTest_q_9_q and fracXIsNotZero_uid32_fpMulTest_q;

    -- fracXIsNotZero_uid18_fpMulTest(LOGICAL,17)@8 + 1
    fracXIsNotZero_uid18_fpMulTest_qi <= not (redist21_fracXIsZero_uid17_fpMulTest_q_8_q);
    fracXIsNotZero_uid18_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsNotZero_uid18_fpMulTest_qi, xout => fracXIsNotZero_uid18_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist23_expXIsMax_uid16_fpMulTest_q_9(DELAY,193)
    redist23_expXIsMax_uid16_fpMulTest_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist22_expXIsMax_uid16_fpMulTest_q_8_q, xout => redist23_expXIsMax_uid16_fpMulTest_q_9_q, ena => en(0), clk => clk, aclr => areset );

    -- excN_x_uid20_fpMulTest(LOGICAL,19)@9
    excN_x_uid20_fpMulTest_q <= redist23_expXIsMax_uid16_fpMulTest_q_9_q and fracXIsNotZero_uid18_fpMulTest_q;

    -- excRNaN_uid89_fpMulTest(LOGICAL,88)@9 + 1
    excRNaN_uid89_fpMulTest_qi <= excN_x_uid20_fpMulTest_q or excN_y_uid34_fpMulTest_q or ZeroTimesInf_uid88_fpMulTest_q;
    excRNaN_uid89_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excRNaN_uid89_fpMulTest_qi, xout => excRNaN_uid89_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- invExcRNaN_uid101_fpMulTest(LOGICAL,100)@10
    invExcRNaN_uid101_fpMulTest_q <= not (excRNaN_uid89_fpMulTest_q);

    -- signY_uid9_fpMulTest(BITSELECT,8)@0
    signY_uid9_fpMulTest_b <= STD_LOGIC_VECTOR(b(31 downto 31));

    -- signX_uid8_fpMulTest(BITSELECT,7)@0
    signX_uid8_fpMulTest_b <= STD_LOGIC_VECTOR(a(31 downto 31));

    -- signR_uid48_fpMulTest(LOGICAL,47)@0 + 1
    signR_uid48_fpMulTest_qi <= signX_uid8_fpMulTest_b xor signY_uid9_fpMulTest_b;
    signR_uid48_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signR_uid48_fpMulTest_qi, xout => signR_uid48_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist12_signR_uid48_fpMulTest_q_10(DELAY,182)
    redist12_signR_uid48_fpMulTest_q_10 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "ASYNC" )
    PORT MAP ( xin => signR_uid48_fpMulTest_q, xout => redist12_signR_uid48_fpMulTest_q_10_q, ena => en(0), clk => clk, aclr => areset );

    -- signRPostExc_uid102_fpMulTest(LOGICAL,101)@10 + 1
    signRPostExc_uid102_fpMulTest_qi <= redist12_signR_uid48_fpMulTest_q_10_q and invExcRNaN_uid101_fpMulTest_q;
    signRPostExc_uid102_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signRPostExc_uid102_fpMulTest_qi, xout => signRPostExc_uid102_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- expFracRPostRounding_uid69_fpMulTest_UpperBits_for_b(CONSTANT,128)
    expFracRPostRounding_uid69_fpMulTest_UpperBits_for_b_q <= "0000000000";

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_SignBit_for_b(BITSELECT,137)@3
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_SignBit_for_b_b <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_align_14_q(43 downto 43));

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_UpperBits_for_b(BITJOIN,138)@3
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_UpperBits_for_b_q <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_SignBit_for_b_b & prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_SignBit_for_b_b & prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_SignBit_for_b_b & prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_SignBit_for_b_b & prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_SignBit_for_b_b & prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_SignBit_for_b_b;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- ofracX_uid40_fpMulTest(BITJOIN,39)@0
    ofracX_uid40_fpMulTest_q <= VCC_q & frac_x_uid14_fpMulTest_b;

    -- prodXY_uid105_prod_uid47_fpMulTest_bs4(BITSELECT,111)@0
    prodXY_uid105_prod_uid47_fpMulTest_bs4_in <= STD_LOGIC_VECTOR(ofracX_uid40_fpMulTest_q(17 downto 0));
    prodXY_uid105_prod_uid47_fpMulTest_bs4_b <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_bs4_in(17 downto 0));

    -- prodXY_uid105_prod_uid47_fpMulTest_bjA5(BITJOIN,112)@0
    prodXY_uid105_prod_uid47_fpMulTest_bjA5_q <= GND_q & prodXY_uid105_prod_uid47_fpMulTest_bs4_b;

    -- ofracY_uid43_fpMulTest(BITJOIN,42)@0
    ofracY_uid43_fpMulTest_q <= VCC_q & frac_y_uid28_fpMulTest_b;

    -- prodXY_uid105_prod_uid47_fpMulTest_bs2_merged_bit_select(BITSELECT,169)@0
    prodXY_uid105_prod_uid47_fpMulTest_bs2_merged_bit_select_b <= ofracY_uid43_fpMulTest_q(17 downto 0);
    prodXY_uid105_prod_uid47_fpMulTest_bs2_merged_bit_select_c <= ofracY_uid43_fpMulTest_q(23 downto 18);

    -- prodXY_uid105_prod_uid47_fpMulTest_bjB9(BITJOIN,116)@0
    prodXY_uid105_prod_uid47_fpMulTest_bjB9_q <= GND_q & prodXY_uid105_prod_uid47_fpMulTest_bs2_merged_bit_select_b;

    -- prodXY_uid105_prod_uid47_fpMulTest_bs7(BITSELECT,114)@0
    prodXY_uid105_prod_uid47_fpMulTest_bs7_b <= STD_LOGIC_VECTOR(ofracX_uid40_fpMulTest_q(23 downto 18));

    -- prodXY_uid105_prod_uid47_fpMulTest_ma3_cma(CHAINMULTADD,168)@0 + 2
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_reset <= areset;
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ena0 <= en(0);
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ena1 <= prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ena0;
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_l(0) <= SIGNED(RESIZE(prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_a0(0),7));
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_l(1) <= SIGNED(RESIZE(prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_a0(1),7));
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_p(0) <= prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_l(0) * prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_c0(0);
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_p(1) <= prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_l(1) * prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_c0(1);
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_u(0) <= RESIZE(prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_p(0),27);
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_u(1) <= RESIZE(prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_p(1),27);
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_w(0) <= prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_u(0) + prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_u(1);
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_x(0) <= prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_w(0);
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_y(0) <= prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_x(0);
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_a0 <= (others => (others => '0'));
            prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ena0 = '1') THEN
                prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_a0(0) <= RESIZE(UNSIGNED(prodXY_uid105_prod_uid47_fpMulTest_bs7_b),6);
                prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_a0(1) <= RESIZE(UNSIGNED(prodXY_uid105_prod_uid47_fpMulTest_bs2_merged_bit_select_c),6);
                prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_c0(0) <= RESIZE(SIGNED(prodXY_uid105_prod_uid47_fpMulTest_bjB9_q),19);
                prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_c0(1) <= RESIZE(SIGNED(prodXY_uid105_prod_uid47_fpMulTest_bjA5_q),19);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_ena1 = '1') THEN
                prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_s(0) <= prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_delay : dspba_delay
    GENERIC MAP ( width => 26, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_s(0)(25 downto 0)), xout => prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_qq, ena => en(0), clk => clk, aclr => areset );
    prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_q <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_qq(25 downto 0));

    -- redist0_prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_q_1(DELAY,170)
    redist0_prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 26, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_q, xout => redist0_prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- prodXY_uid105_prod_uid47_fpMulTest_align_14(BITSHIFT,121)@3
    prodXY_uid105_prod_uid47_fpMulTest_align_14_qint <= redist0_prodXY_uid105_prod_uid47_fpMulTest_ma3_cma_q_1_q & "000000000000000000";
    prodXY_uid105_prod_uid47_fpMulTest_align_14_q <= prodXY_uid105_prod_uid47_fpMulTest_align_14_qint(43 downto 0);

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_b(BITJOIN,136)@3
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_b_q <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_UpperBits_for_b_q & prodXY_uid105_prod_uid47_fpMulTest_align_14_q;

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b(BITSELECT,140)@3
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_b <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_b_q(24 downto 0));
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_c <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_b_q(49 downto 25));

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_UpperBits_for_a(CONSTANT,135)
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_UpperBits_for_a_q <= "00";

    -- prodXY_uid105_prod_uid47_fpMulTest_bs11(BITSELECT,118)@0
    prodXY_uid105_prod_uid47_fpMulTest_bs11_b <= ofracX_uid40_fpMulTest_q(23 downto 18);

    -- prodXY_uid105_prod_uid47_fpMulTest_im10(MULT,117)@0 + 2
    prodXY_uid105_prod_uid47_fpMulTest_im10_pr <= UNSIGNED(UNSIGNED(prodXY_uid105_prod_uid47_fpMulTest_im10_a0) * UNSIGNED(prodXY_uid105_prod_uid47_fpMulTest_im10_b0));
    prodXY_uid105_prod_uid47_fpMulTest_im10_component: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid105_prod_uid47_fpMulTest_im10_a0 <= (others => '0');
            prodXY_uid105_prod_uid47_fpMulTest_im10_b0 <= (others => '0');
            prodXY_uid105_prod_uid47_fpMulTest_im10_s1 <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                prodXY_uid105_prod_uid47_fpMulTest_im10_a0 <= prodXY_uid105_prod_uid47_fpMulTest_bs11_b;
                prodXY_uid105_prod_uid47_fpMulTest_im10_b0 <= prodXY_uid105_prod_uid47_fpMulTest_bs2_merged_bit_select_c;
                prodXY_uid105_prod_uid47_fpMulTest_im10_s1 <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_im10_pr);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid105_prod_uid47_fpMulTest_im10_q <= prodXY_uid105_prod_uid47_fpMulTest_im10_s1;

    -- redist9_prodXY_uid105_prod_uid47_fpMulTest_im10_q_1(DELAY,179)
    redist9_prodXY_uid105_prod_uid47_fpMulTest_im10_q_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid105_prod_uid47_fpMulTest_im10_q, xout => redist9_prodXY_uid105_prod_uid47_fpMulTest_im10_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- prodXY_uid105_prod_uid47_fpMulTest_bs1(BITSELECT,108)@0
    prodXY_uid105_prod_uid47_fpMulTest_bs1_in <= ofracX_uid40_fpMulTest_q(17 downto 0);
    prodXY_uid105_prod_uid47_fpMulTest_bs1_b <= prodXY_uid105_prod_uid47_fpMulTest_bs1_in(17 downto 0);

    -- prodXY_uid105_prod_uid47_fpMulTest_im0_cma(CHAINMULTADD,167)@0 + 2
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_reset <= areset;
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ena0 <= en(0);
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ena1 <= prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ena0;
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_p(0) <= prodXY_uid105_prod_uid47_fpMulTest_im0_cma_a0(0) * prodXY_uid105_prod_uid47_fpMulTest_im0_cma_c0(0);
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_u(0) <= RESIZE(prodXY_uid105_prod_uid47_fpMulTest_im0_cma_p(0),36);
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_w(0) <= prodXY_uid105_prod_uid47_fpMulTest_im0_cma_u(0);
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_x(0) <= prodXY_uid105_prod_uid47_fpMulTest_im0_cma_w(0);
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_y(0) <= prodXY_uid105_prod_uid47_fpMulTest_im0_cma_x(0);
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid105_prod_uid47_fpMulTest_im0_cma_a0 <= (others => (others => '0'));
            prodXY_uid105_prod_uid47_fpMulTest_im0_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ena0 = '1') THEN
                prodXY_uid105_prod_uid47_fpMulTest_im0_cma_a0(0) <= RESIZE(UNSIGNED(prodXY_uid105_prod_uid47_fpMulTest_bs1_b),18);
                prodXY_uid105_prod_uid47_fpMulTest_im0_cma_c0(0) <= RESIZE(UNSIGNED(prodXY_uid105_prod_uid47_fpMulTest_bs2_merged_bit_select_b),18);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid105_prod_uid47_fpMulTest_im0_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (prodXY_uid105_prod_uid47_fpMulTest_im0_cma_ena1 = '1') THEN
                prodXY_uid105_prod_uid47_fpMulTest_im0_cma_s(0) <= prodXY_uid105_prod_uid47_fpMulTest_im0_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_delay : dspba_delay
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_im0_cma_s(0)(35 downto 0)), xout => prodXY_uid105_prod_uid47_fpMulTest_im0_cma_qq, ena => en(0), clk => clk, aclr => areset );
    prodXY_uid105_prod_uid47_fpMulTest_im0_cma_q <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_im0_cma_qq(35 downto 0));

    -- redist1_prodXY_uid105_prod_uid47_fpMulTest_im0_cma_q_1(DELAY,171)
    redist1_prodXY_uid105_prod_uid47_fpMulTest_im0_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 36, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid105_prod_uid47_fpMulTest_im0_cma_q, xout => redist1_prodXY_uid105_prod_uid47_fpMulTest_im0_cma_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- prodXY_uid105_prod_uid47_fpMulTest_join_13(BITJOIN,120)@3
    prodXY_uid105_prod_uid47_fpMulTest_join_13_q <= redist9_prodXY_uid105_prod_uid47_fpMulTest_im10_q_1_q & redist1_prodXY_uid105_prod_uid47_fpMulTest_im0_cma_q_1_q;

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_a(BITJOIN,134)@3
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_a_q <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_UpperBits_for_a_q & prodXY_uid105_prod_uid47_fpMulTest_join_13_q;

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a(BITSELECT,139)@3
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_b <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_a_q(24 downto 0);
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_c <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitExpansion_for_a_q(49 downto 25);

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2(ADD,141)@3 + 1
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_a <= STD_LOGIC_VECTOR("0" & prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_b);
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_b <= STD_LOGIC_VECTOR("0" & prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_b);
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_a) + UNSIGNED(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_b));
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_c(0) <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_o(25);
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_o(24 downto 0);

    -- redist5_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_c_1(DELAY,175)
    redist5_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_c_1 : dspba_delay
    GENERIC MAP ( width => 25, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_c, xout => redist5_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_c_1_q, ena => en(0), clk => clk, aclr => areset );

    -- redist6_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_c_1(DELAY,176)
    redist6_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_c_1 : dspba_delay
    GENERIC MAP ( width => 25, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_c, xout => redist6_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_c_1_q, ena => en(0), clk => clk, aclr => areset );

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2(ADD,142)@4 + 1
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_cin <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_c;
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & redist6_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_a_c_1_q) & '1');
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 25 => redist5_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_c_1_q(24)) & redist5_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitSelect_for_b_c_1_q) & prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_cin(0));
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_o <= STD_LOGIC_VECTOR(SIGNED(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_a) + SIGNED(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_b));
            END IF;
        END IF;
    END PROCESS;
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_q <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_o(25 downto 1);

    -- normalizeBit_uid49_fpMulTest_tessel0_0(BITSELECT,153)@5
    normalizeBit_uid49_fpMulTest_tessel0_0_b <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_q(22 downto 22));

    -- redist2_normalizeBit_uid49_fpMulTest_tessel0_0_b_2(DELAY,172)
    redist2_normalizeBit_uid49_fpMulTest_tessel0_0_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => normalizeBit_uid49_fpMulTest_tessel0_0_b, xout => redist2_normalizeBit_uid49_fpMulTest_tessel0_0_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- roundBitDetectionConstant_uid63_fpMulTest(CONSTANT,62)
    roundBitDetectionConstant_uid63_fpMulTest_q <= "010";

    -- fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel2_0(BITSELECT,165)@5
    fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel2_0_b <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_q(21 downto 1));

    -- fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel2_0(BITSELECT,159)@5
    fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel2_0_b <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_q(20 downto 0));

    -- fracRPostNorm_uid53_fpMulTest_p2(MUX,148)@5 + 1
    fracRPostNorm_uid53_fpMulTest_p2_s <= normalizeBit_uid49_fpMulTest_tessel0_0_b;
    fracRPostNorm_uid53_fpMulTest_p2_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            fracRPostNorm_uid53_fpMulTest_p2_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (fracRPostNorm_uid53_fpMulTest_p2_s) IS
                    WHEN "0" => fracRPostNorm_uid53_fpMulTest_p2_q <= fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel2_0_b;
                    WHEN "1" => fracRPostNorm_uid53_fpMulTest_p2_q <= fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel2_0_b;
                    WHEN OTHERS => fracRPostNorm_uid53_fpMulTest_p2_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel1_0(BITSELECT,163)@5
    fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel1_0_b <= STD_LOGIC_VECTOR(prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_q(0 downto 0));

    -- redist4_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q_1(DELAY,174)
    redist4_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 25, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q, xout => redist4_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel1_0(BITSELECT,157)@5
    fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel1_0_b <= STD_LOGIC_VECTOR(redist4_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q_1_q(24 downto 24));

    -- fracRPostNorm_uid53_fpMulTest_p1(MUX,147)@5 + 1
    fracRPostNorm_uid53_fpMulTest_p1_s <= normalizeBit_uid49_fpMulTest_tessel0_0_b;
    fracRPostNorm_uid53_fpMulTest_p1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            fracRPostNorm_uid53_fpMulTest_p1_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (fracRPostNorm_uid53_fpMulTest_p1_s) IS
                    WHEN "0" => fracRPostNorm_uid53_fpMulTest_p1_q <= fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel1_0_b;
                    WHEN "1" => fracRPostNorm_uid53_fpMulTest_p1_q <= fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel1_0_b;
                    WHEN OTHERS => fracRPostNorm_uid53_fpMulTest_p1_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel0_0(BITSELECT,161)@5
    fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel0_0_b <= STD_LOGIC_VECTOR(redist4_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q_1_q(24 downto 23));

    -- fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel0_0(BITSELECT,155)@5
    fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel0_0_b <= STD_LOGIC_VECTOR(redist4_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q_1_q(23 downto 22));

    -- fracRPostNorm_uid53_fpMulTest_p0(MUX,146)@5 + 1
    fracRPostNorm_uid53_fpMulTest_p0_s <= normalizeBit_uid49_fpMulTest_tessel0_0_b;
    fracRPostNorm_uid53_fpMulTest_p0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            fracRPostNorm_uid53_fpMulTest_p0_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (fracRPostNorm_uid53_fpMulTest_p0_s) IS
                    WHEN "0" => fracRPostNorm_uid53_fpMulTest_p0_q <= fracRPostNorm_uid53_fpMulTest_BitSelect_for_a_tessel0_0_b;
                    WHEN "1" => fracRPostNorm_uid53_fpMulTest_p0_q <= fracRPostNorm_uid53_fpMulTest_BitSelect_for_b_tessel0_0_b;
                    WHEN OTHERS => fracRPostNorm_uid53_fpMulTest_p0_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- fracRPostNorm_uid53_fpMulTest_BitJoin_for_q(BITJOIN,149)@6
    fracRPostNorm_uid53_fpMulTest_BitJoin_for_q_q <= fracRPostNorm_uid53_fpMulTest_p2_q & fracRPostNorm_uid53_fpMulTest_p1_q & fracRPostNorm_uid53_fpMulTest_p0_q;

    -- fracRPostNorm1dto0_uid61_fpMulTest(BITSELECT,60)@6
    fracRPostNorm1dto0_uid61_fpMulTest_in <= fracRPostNorm_uid53_fpMulTest_BitJoin_for_q_q(1 downto 0);
    fracRPostNorm1dto0_uid61_fpMulTest_b <= fracRPostNorm1dto0_uid61_fpMulTest_in(1 downto 0);

    -- prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitJoin_for_q(BITJOIN,143)@5
    prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitJoin_for_q_q <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p2_of_2_q & redist4_prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_p1_of_2_q_1_q;

    -- osig_uid106_prod_uid47_fpMulTest(BITSELECT,105)@5
    osig_uid106_prod_uid47_fpMulTest_in <= prodXY_uid105_prod_uid47_fpMulTest_result_add_0_0_BitJoin_for_q_q(47 downto 0);
    osig_uid106_prod_uid47_fpMulTest_b <= osig_uid106_prod_uid47_fpMulTest_in(47 downto 0);

    -- extraStickyBitOfProd_uid55_fpMulTest(BITSELECT,54)@5
    extraStickyBitOfProd_uid55_fpMulTest_in <= STD_LOGIC_VECTOR(osig_uid106_prod_uid47_fpMulTest_b(22 downto 0));
    extraStickyBitOfProd_uid55_fpMulTest_b <= STD_LOGIC_VECTOR(extraStickyBitOfProd_uid55_fpMulTest_in(22 downto 22));

    -- extraStickyBit_uid56_fpMulTest(MUX,55)@5
    extraStickyBit_uid56_fpMulTest_s <= normalizeBit_uid49_fpMulTest_tessel0_0_b;
    extraStickyBit_uid56_fpMulTest_combproc: PROCESS (extraStickyBit_uid56_fpMulTest_s, en, GND_q, extraStickyBitOfProd_uid55_fpMulTest_b)
    BEGIN
        CASE (extraStickyBit_uid56_fpMulTest_s) IS
            WHEN "0" => extraStickyBit_uid56_fpMulTest_q <= GND_q;
            WHEN "1" => extraStickyBit_uid56_fpMulTest_q <= extraStickyBitOfProd_uid55_fpMulTest_b;
            WHEN OTHERS => extraStickyBit_uid56_fpMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- stickyRange_uid54_fpMulTest(BITSELECT,53)@5
    stickyRange_uid54_fpMulTest_in <= osig_uid106_prod_uid47_fpMulTest_b(21 downto 0);
    stickyRange_uid54_fpMulTest_b <= stickyRange_uid54_fpMulTest_in(21 downto 0);

    -- stickyExtendedRange_uid57_fpMulTest(BITJOIN,56)@5
    stickyExtendedRange_uid57_fpMulTest_q <= extraStickyBit_uid56_fpMulTest_q & stickyRange_uid54_fpMulTest_b;

    -- stickyRangeComparator_uid59_fpMulTest(LOGICAL,58)@5 + 1
    stickyRangeComparator_uid59_fpMulTest_qi <= "1" WHEN stickyExtendedRange_uid57_fpMulTest_q = cstZeroWF_uid11_fpMulTest_q ELSE "0";
    stickyRangeComparator_uid59_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => stickyRangeComparator_uid59_fpMulTest_qi, xout => stickyRangeComparator_uid59_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- sticky_uid60_fpMulTest(LOGICAL,59)@6
    sticky_uid60_fpMulTest_q <= not (stickyRangeComparator_uid59_fpMulTest_q);

    -- lrs_uid62_fpMulTest(BITJOIN,61)@6
    lrs_uid62_fpMulTest_q <= fracRPostNorm1dto0_uid61_fpMulTest_b & sticky_uid60_fpMulTest_q;

    -- roundBitDetectionPattern_uid64_fpMulTest(LOGICAL,63)@6 + 1
    roundBitDetectionPattern_uid64_fpMulTest_qi <= "1" WHEN lrs_uid62_fpMulTest_q = roundBitDetectionConstant_uid63_fpMulTest_q ELSE "0";
    roundBitDetectionPattern_uid64_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => roundBitDetectionPattern_uid64_fpMulTest_qi, xout => roundBitDetectionPattern_uid64_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- roundBit_uid65_fpMulTest(LOGICAL,64)@7
    roundBit_uid65_fpMulTest_q <= not (roundBitDetectionPattern_uid64_fpMulTest_q);

    -- roundBitAndNormalizationOp_uid68_fpMulTest(BITJOIN,67)@7
    roundBitAndNormalizationOp_uid68_fpMulTest_q <= GND_q & redist2_normalizeBit_uid49_fpMulTest_tessel0_0_b_2_q & cstZeroWF_uid11_fpMulTest_q & roundBit_uid65_fpMulTest_q;

    -- expFracRPostRounding_uid69_fpMulTest_BitExpansion_for_b(BITJOIN,127)@7
    expFracRPostRounding_uid69_fpMulTest_BitExpansion_for_b_q <= expFracRPostRounding_uid69_fpMulTest_UpperBits_for_b_q & roundBitAndNormalizationOp_uid68_fpMulTest_q;

    -- expFracRPostRounding_uid69_fpMulTest_BitSelect_for_b(BITSELECT,130)@7
    expFracRPostRounding_uid69_fpMulTest_BitSelect_for_b_b <= expFracRPostRounding_uid69_fpMulTest_BitExpansion_for_b_q(24 downto 0);

    -- expFracRPostRounding_uid69_fpMulTest_SignBit_for_a(BITSELECT,125)@7
    expFracRPostRounding_uid69_fpMulTest_SignBit_for_a_b <= STD_LOGIC_VECTOR(expFracPreRound_uid66_fpMulTest_q(34 downto 34));

    -- biasInc_uid45_fpMulTest(CONSTANT,44)
    biasInc_uid45_fpMulTest_q <= "0001111111";

    -- expSum_uid44_fpMulTest(ADD,43)@0 + 1
    expSum_uid44_fpMulTest_a <= STD_LOGIC_VECTOR("0" & expX_uid6_fpMulTest_b);
    expSum_uid44_fpMulTest_b <= STD_LOGIC_VECTOR("0" & expY_uid7_fpMulTest_b);
    expSum_uid44_fpMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expSum_uid44_fpMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expSum_uid44_fpMulTest_o <= STD_LOGIC_VECTOR(UNSIGNED(expSum_uid44_fpMulTest_a) + UNSIGNED(expSum_uid44_fpMulTest_b));
            END IF;
        END IF;
    END PROCESS;
    expSum_uid44_fpMulTest_q <= expSum_uid44_fpMulTest_o(8 downto 0);

    -- redist13_expSum_uid44_fpMulTest_q_6(DELAY,183)
    redist13_expSum_uid44_fpMulTest_q_6 : dspba_delay
    GENERIC MAP ( width => 9, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => expSum_uid44_fpMulTest_q, xout => redist13_expSum_uid44_fpMulTest_q_6_q, ena => en(0), clk => clk, aclr => areset );

    -- redist13_expSum_uid44_fpMulTest_q_6_outputreg(DELAY,196)
    redist13_expSum_uid44_fpMulTest_q_6_outputreg : dspba_delay
    GENERIC MAP ( width => 9, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist13_expSum_uid44_fpMulTest_q_6_q, xout => redist13_expSum_uid44_fpMulTest_q_6_outputreg_q, ena => en(0), clk => clk, aclr => areset );

    -- expSumMBias_uid46_fpMulTest(SUB,45)@6 + 1
    expSumMBias_uid46_fpMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist13_expSum_uid44_fpMulTest_q_6_outputreg_q));
    expSumMBias_uid46_fpMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 10 => biasInc_uid45_fpMulTest_q(9)) & biasInc_uid45_fpMulTest_q));
    expSumMBias_uid46_fpMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expSumMBias_uid46_fpMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expSumMBias_uid46_fpMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expSumMBias_uid46_fpMulTest_a) - SIGNED(expSumMBias_uid46_fpMulTest_b));
            END IF;
        END IF;
    END PROCESS;
    expSumMBias_uid46_fpMulTest_q <= expSumMBias_uid46_fpMulTest_o(10 downto 0);

    -- redist3_fracRPostNorm_uid53_fpMulTest_BitJoin_for_q_q_1(DELAY,173)
    redist3_fracRPostNorm_uid53_fpMulTest_BitJoin_for_q_q_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPostNorm_uid53_fpMulTest_BitJoin_for_q_q, xout => redist3_fracRPostNorm_uid53_fpMulTest_BitJoin_for_q_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- expFracPreRound_uid66_fpMulTest(BITJOIN,65)@7
    expFracPreRound_uid66_fpMulTest_q <= expSumMBias_uid46_fpMulTest_q & redist3_fracRPostNorm_uid53_fpMulTest_BitJoin_for_q_q_1_q;

    -- expFracRPostRounding_uid69_fpMulTest_BitExpansion_for_a(BITJOIN,124)@7
    expFracRPostRounding_uid69_fpMulTest_BitExpansion_for_a_q <= expFracRPostRounding_uid69_fpMulTest_SignBit_for_a_b & expFracPreRound_uid66_fpMulTest_q;

    -- expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a(BITSELECT,129)@7
    expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_b <= STD_LOGIC_VECTOR(expFracRPostRounding_uid69_fpMulTest_BitExpansion_for_a_q(24 downto 0));
    expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_c <= STD_LOGIC_VECTOR(expFracRPostRounding_uid69_fpMulTest_BitExpansion_for_a_q(35 downto 25));

    -- expFracRPostRounding_uid69_fpMulTest_p1_of_2(ADD,131)@7 + 1
    expFracRPostRounding_uid69_fpMulTest_p1_of_2_a <= STD_LOGIC_VECTOR("0" & expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_b);
    expFracRPostRounding_uid69_fpMulTest_p1_of_2_b <= STD_LOGIC_VECTOR("0" & expFracRPostRounding_uid69_fpMulTest_BitSelect_for_b_b);
    expFracRPostRounding_uid69_fpMulTest_p1_of_2_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expFracRPostRounding_uid69_fpMulTest_p1_of_2_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expFracRPostRounding_uid69_fpMulTest_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(expFracRPostRounding_uid69_fpMulTest_p1_of_2_a) + UNSIGNED(expFracRPostRounding_uid69_fpMulTest_p1_of_2_b));
            END IF;
        END IF;
    END PROCESS;
    expFracRPostRounding_uid69_fpMulTest_p1_of_2_c(0) <= expFracRPostRounding_uid69_fpMulTest_p1_of_2_o(25);
    expFracRPostRounding_uid69_fpMulTest_p1_of_2_q <= expFracRPostRounding_uid69_fpMulTest_p1_of_2_o(24 downto 0);

    -- expFracRPostRounding_uid69_fpMulTest_BitSelect_for_b_BitJoin_for_c(BITJOIN,152)@8
    expFracRPostRounding_uid69_fpMulTest_BitSelect_for_b_BitJoin_for_c_q <= expFracRPostRounding_uid69_fpMulTest_UpperBits_for_b_q & GND_q;

    -- redist8_expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_c_1(DELAY,178)
    redist8_expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_c_1 : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_c, xout => redist8_expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_c_1_q, ena => en(0), clk => clk, aclr => areset );

    -- expFracRPostRounding_uid69_fpMulTest_p2_of_2(ADD,132)@8 + 1
    expFracRPostRounding_uid69_fpMulTest_p2_of_2_cin <= expFracRPostRounding_uid69_fpMulTest_p1_of_2_c;
    expFracRPostRounding_uid69_fpMulTest_p2_of_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 11 => redist8_expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_c_1_q(10)) & redist8_expFracRPostRounding_uid69_fpMulTest_BitSelect_for_a_c_1_q) & '1');
    expFracRPostRounding_uid69_fpMulTest_p2_of_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & expFracRPostRounding_uid69_fpMulTest_BitSelect_for_b_BitJoin_for_c_q) & expFracRPostRounding_uid69_fpMulTest_p2_of_2_cin(0));
    expFracRPostRounding_uid69_fpMulTest_p2_of_2_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expFracRPostRounding_uid69_fpMulTest_p2_of_2_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expFracRPostRounding_uid69_fpMulTest_p2_of_2_o <= STD_LOGIC_VECTOR(SIGNED(expFracRPostRounding_uid69_fpMulTest_p2_of_2_a) + SIGNED(expFracRPostRounding_uid69_fpMulTest_p2_of_2_b));
            END IF;
        END IF;
    END PROCESS;
    expFracRPostRounding_uid69_fpMulTest_p2_of_2_q <= expFracRPostRounding_uid69_fpMulTest_p2_of_2_o(11 downto 1);

    -- redist7_expFracRPostRounding_uid69_fpMulTest_p1_of_2_q_1(DELAY,177)
    redist7_expFracRPostRounding_uid69_fpMulTest_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 25, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expFracRPostRounding_uid69_fpMulTest_p1_of_2_q, xout => redist7_expFracRPostRounding_uid69_fpMulTest_p1_of_2_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- expFracRPostRounding_uid69_fpMulTest_BitJoin_for_q(BITJOIN,133)@9
    expFracRPostRounding_uid69_fpMulTest_BitJoin_for_q_q <= expFracRPostRounding_uid69_fpMulTest_p2_of_2_q & redist7_expFracRPostRounding_uid69_fpMulTest_p1_of_2_q_1_q;

    -- expRPreExcExt_uid71_fpMulTest(BITSELECT,70)@9
    expRPreExcExt_uid71_fpMulTest_b <= STD_LOGIC_VECTOR(expFracRPostRounding_uid69_fpMulTest_BitJoin_for_q_q(35 downto 24));

    -- expRPreExc_uid72_fpMulTest(BITSELECT,71)@9
    expRPreExc_uid72_fpMulTest_in <= expRPreExcExt_uid71_fpMulTest_b(7 downto 0);
    expRPreExc_uid72_fpMulTest_b <= expRPreExc_uid72_fpMulTest_in(7 downto 0);

    -- redist10_expRPreExc_uid72_fpMulTest_b_2(DELAY,180)
    redist10_expRPreExc_uid72_fpMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExc_uid72_fpMulTest_b, xout => redist10_expRPreExc_uid72_fpMulTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- expOvf_uid75_fpMulTest(COMPARE,74)@9 + 1
    expOvf_uid75_fpMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => expRPreExcExt_uid71_fpMulTest_b(11)) & expRPreExcExt_uid71_fpMulTest_b));
    expOvf_uid75_fpMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000" & cstAllOWE_uid10_fpMulTest_q));
    expOvf_uid75_fpMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expOvf_uid75_fpMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expOvf_uid75_fpMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expOvf_uid75_fpMulTest_a) - SIGNED(expOvf_uid75_fpMulTest_b));
            END IF;
        END IF;
    END PROCESS;
    expOvf_uid75_fpMulTest_n(0) <= not (expOvf_uid75_fpMulTest_o(13));

    -- invExpXIsMax_uid35_fpMulTest(LOGICAL,34)@9
    invExpXIsMax_uid35_fpMulTest_q <= not (redist17_expXIsMax_uid30_fpMulTest_q_9_q);

    -- InvExpXIsZero_uid36_fpMulTest(LOGICAL,35)@9
    InvExpXIsZero_uid36_fpMulTest_q <= not (redist18_excZ_y_uid29_fpMulTest_q_9_q);

    -- excR_y_uid37_fpMulTest(LOGICAL,36)@9 + 1
    excR_y_uid37_fpMulTest_qi <= InvExpXIsZero_uid36_fpMulTest_q and invExpXIsMax_uid35_fpMulTest_q;
    excR_y_uid37_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excR_y_uid37_fpMulTest_qi, xout => excR_y_uid37_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- invExpXIsMax_uid21_fpMulTest(LOGICAL,20)@9
    invExpXIsMax_uid21_fpMulTest_q <= not (redist23_expXIsMax_uid16_fpMulTest_q_9_q);

    -- InvExpXIsZero_uid22_fpMulTest(LOGICAL,21)@9
    InvExpXIsZero_uid22_fpMulTest_q <= not (redist24_excZ_x_uid15_fpMulTest_q_9_q);

    -- excR_x_uid23_fpMulTest(LOGICAL,22)@9 + 1
    excR_x_uid23_fpMulTest_qi <= InvExpXIsZero_uid22_fpMulTest_q and invExpXIsMax_uid21_fpMulTest_q;
    excR_x_uid23_fpMulTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excR_x_uid23_fpMulTest_qi, xout => excR_x_uid23_fpMulTest_q, ena => en(0), clk => clk, aclr => areset );

    -- ExcROvfAndInReg_uid84_fpMulTest(LOGICAL,83)@10
    ExcROvfAndInReg_uid84_fpMulTest_q <= excR_x_uid23_fpMulTest_q and excR_y_uid37_fpMulTest_q and expOvf_uid75_fpMulTest_n;

    -- redist20_excI_x_uid19_fpMulTest_q_2(DELAY,190)
    redist20_excI_x_uid19_fpMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excI_x_uid19_fpMulTest_q, xout => redist20_excI_x_uid19_fpMulTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- excYRAndExcXI_uid83_fpMulTest(LOGICAL,82)@10
    excYRAndExcXI_uid83_fpMulTest_q <= excR_y_uid37_fpMulTest_q and redist20_excI_x_uid19_fpMulTest_q_2_q;

    -- redist14_excI_y_uid33_fpMulTest_q_2(DELAY,184)
    redist14_excI_y_uid33_fpMulTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excI_y_uid33_fpMulTest_q, xout => redist14_excI_y_uid33_fpMulTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- excXRAndExcYI_uid82_fpMulTest(LOGICAL,81)@10
    excXRAndExcYI_uid82_fpMulTest_q <= excR_x_uid23_fpMulTest_q and redist14_excI_y_uid33_fpMulTest_q_2_q;

    -- excXIAndExcYI_uid81_fpMulTest(LOGICAL,80)@10
    excXIAndExcYI_uid81_fpMulTest_q <= redist20_excI_x_uid19_fpMulTest_q_2_q and redist14_excI_y_uid33_fpMulTest_q_2_q;

    -- excRInf_uid85_fpMulTest(LOGICAL,84)@10
    excRInf_uid85_fpMulTest_q <= excXIAndExcYI_uid81_fpMulTest_q or excXRAndExcYI_uid82_fpMulTest_q or excYRAndExcXI_uid83_fpMulTest_q or ExcROvfAndInReg_uid84_fpMulTest_q;

    -- expUdf_uid73_fpMulTest(COMPARE,72)@9 + 1
    expUdf_uid73_fpMulTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000000000000" & GND_q));
    expUdf_uid73_fpMulTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => expRPreExcExt_uid71_fpMulTest_b(11)) & expRPreExcExt_uid71_fpMulTest_b));
    expUdf_uid73_fpMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expUdf_uid73_fpMulTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expUdf_uid73_fpMulTest_o <= STD_LOGIC_VECTOR(SIGNED(expUdf_uid73_fpMulTest_a) - SIGNED(expUdf_uid73_fpMulTest_b));
            END IF;
        END IF;
    END PROCESS;
    expUdf_uid73_fpMulTest_n(0) <= not (expUdf_uid73_fpMulTest_o(13));

    -- excZC3_uid79_fpMulTest(LOGICAL,78)@10
    excZC3_uid79_fpMulTest_q <= excR_x_uid23_fpMulTest_q and excR_y_uid37_fpMulTest_q and expUdf_uid73_fpMulTest_n;

    -- redist19_excZ_y_uid29_fpMulTest_q_10(DELAY,189)
    redist19_excZ_y_uid29_fpMulTest_q_10 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist18_excZ_y_uid29_fpMulTest_q_9_q, xout => redist19_excZ_y_uid29_fpMulTest_q_10_q, ena => en(0), clk => clk, aclr => areset );

    -- excYZAndExcXR_uid78_fpMulTest(LOGICAL,77)@10
    excYZAndExcXR_uid78_fpMulTest_q <= redist19_excZ_y_uid29_fpMulTest_q_10_q and excR_x_uid23_fpMulTest_q;

    -- redist25_excZ_x_uid15_fpMulTest_q_10(DELAY,195)
    redist25_excZ_x_uid15_fpMulTest_q_10 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist24_excZ_x_uid15_fpMulTest_q_9_q, xout => redist25_excZ_x_uid15_fpMulTest_q_10_q, ena => en(0), clk => clk, aclr => areset );

    -- excXZAndExcYR_uid77_fpMulTest(LOGICAL,76)@10
    excXZAndExcYR_uid77_fpMulTest_q <= redist25_excZ_x_uid15_fpMulTest_q_10_q and excR_y_uid37_fpMulTest_q;

    -- excXZAndExcYZ_uid76_fpMulTest(LOGICAL,75)@10
    excXZAndExcYZ_uid76_fpMulTest_q <= redist25_excZ_x_uid15_fpMulTest_q_10_q and redist19_excZ_y_uid29_fpMulTest_q_10_q;

    -- excRZero_uid80_fpMulTest(LOGICAL,79)@10
    excRZero_uid80_fpMulTest_q <= excXZAndExcYZ_uid76_fpMulTest_q or excXZAndExcYR_uid77_fpMulTest_q or excYZAndExcXR_uid78_fpMulTest_q or excZC3_uid79_fpMulTest_q;

    -- concExc_uid90_fpMulTest(BITJOIN,89)@10
    concExc_uid90_fpMulTest_q <= excRNaN_uid89_fpMulTest_q & excRInf_uid85_fpMulTest_q & excRZero_uid80_fpMulTest_q;

    -- excREnc_uid91_fpMulTest(LOOKUP,90)@10 + 1
    excREnc_uid91_fpMulTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excREnc_uid91_fpMulTest_q <= "01";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (concExc_uid90_fpMulTest_q) IS
                    WHEN "000" => excREnc_uid91_fpMulTest_q <= "01";
                    WHEN "001" => excREnc_uid91_fpMulTest_q <= "00";
                    WHEN "010" => excREnc_uid91_fpMulTest_q <= "10";
                    WHEN "011" => excREnc_uid91_fpMulTest_q <= "00";
                    WHEN "100" => excREnc_uid91_fpMulTest_q <= "11";
                    WHEN "101" => excREnc_uid91_fpMulTest_q <= "00";
                    WHEN "110" => excREnc_uid91_fpMulTest_q <= "00";
                    WHEN "111" => excREnc_uid91_fpMulTest_q <= "00";
                    WHEN OTHERS => -- unreachable
                                   excREnc_uid91_fpMulTest_q <= (others => '-');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- expRPostExc_uid100_fpMulTest(MUX,99)@11
    expRPostExc_uid100_fpMulTest_s <= excREnc_uid91_fpMulTest_q;
    expRPostExc_uid100_fpMulTest_combproc: PROCESS (expRPostExc_uid100_fpMulTest_s, en, cstAllZWE_uid12_fpMulTest_q, redist10_expRPreExc_uid72_fpMulTest_b_2_q, cstAllOWE_uid10_fpMulTest_q)
    BEGIN
        CASE (expRPostExc_uid100_fpMulTest_s) IS
            WHEN "00" => expRPostExc_uid100_fpMulTest_q <= cstAllZWE_uid12_fpMulTest_q;
            WHEN "01" => expRPostExc_uid100_fpMulTest_q <= redist10_expRPreExc_uid72_fpMulTest_b_2_q;
            WHEN "10" => expRPostExc_uid100_fpMulTest_q <= cstAllOWE_uid10_fpMulTest_q;
            WHEN "11" => expRPostExc_uid100_fpMulTest_q <= cstAllOWE_uid10_fpMulTest_q;
            WHEN OTHERS => expRPostExc_uid100_fpMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid92_fpMulTest(CONSTANT,91)
    oneFracRPostExc2_uid92_fpMulTest_q <= "00000000000000000000001";

    -- fracRPreExc_uid70_fpMulTest(BITSELECT,69)@9
    fracRPreExc_uid70_fpMulTest_in <= expFracRPostRounding_uid69_fpMulTest_BitJoin_for_q_q(23 downto 0);
    fracRPreExc_uid70_fpMulTest_b <= fracRPreExc_uid70_fpMulTest_in(23 downto 1);

    -- redist11_fracRPreExc_uid70_fpMulTest_b_2(DELAY,181)
    redist11_fracRPreExc_uid70_fpMulTest_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPreExc_uid70_fpMulTest_b, xout => redist11_fracRPreExc_uid70_fpMulTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- fracRPostExc_uid95_fpMulTest(MUX,94)@11
    fracRPostExc_uid95_fpMulTest_s <= excREnc_uid91_fpMulTest_q;
    fracRPostExc_uid95_fpMulTest_combproc: PROCESS (fracRPostExc_uid95_fpMulTest_s, en, cstZeroWF_uid11_fpMulTest_q, redist11_fracRPreExc_uid70_fpMulTest_b_2_q, oneFracRPostExc2_uid92_fpMulTest_q)
    BEGIN
        CASE (fracRPostExc_uid95_fpMulTest_s) IS
            WHEN "00" => fracRPostExc_uid95_fpMulTest_q <= cstZeroWF_uid11_fpMulTest_q;
            WHEN "01" => fracRPostExc_uid95_fpMulTest_q <= redist11_fracRPreExc_uid70_fpMulTest_b_2_q;
            WHEN "10" => fracRPostExc_uid95_fpMulTest_q <= cstZeroWF_uid11_fpMulTest_q;
            WHEN "11" => fracRPostExc_uid95_fpMulTest_q <= oneFracRPostExc2_uid92_fpMulTest_q;
            WHEN OTHERS => fracRPostExc_uid95_fpMulTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- R_uid103_fpMulTest(BITJOIN,102)@11
    R_uid103_fpMulTest_q <= signRPostExc_uid102_fpMulTest_q & expRPostExc_uid100_fpMulTest_q & fracRPostExc_uid95_fpMulTest_q;

    -- xOut(GPOUT,4)@11
    q <= R_uid103_fpMulTest_q;

END normal;
