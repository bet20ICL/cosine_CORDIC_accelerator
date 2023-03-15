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

-- VHDL created from fp_addsub_11cyc_0002
-- VHDL created on Tue Mar 14 21:15:29 2023


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

entity fp_addsub_11cyc_0002 is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        b : in std_logic_vector(31 downto 0);  -- float32_m23
        opSel : in std_logic_vector(0 downto 0);  -- ufix1
        en : in std_logic_vector(0 downto 0);  -- ufix1
        q : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        areset : in std_logic
    );
end fp_addsub_11cyc_0002;

architecture normal of fp_addsub_11cyc_0002 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signB_uid6_fpAddSubTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal restB_uid7_fpAddSubTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal invSignB_uid8_fpAddSubTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxSignB_uid9_fpAddSubTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxSignB_uid9_fpAddSubTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bOperand_uid10_fpAddSubTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal expFracX_uid15_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (30 downto 0);
    signal expFracY_uid16_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (30 downto 0);
    signal xGTEy_uid17_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid17_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid17_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid17_fpAddSubTest_ieeeAdd_n : STD_LOGIC_VECTOR (0 downto 0);
    signal sigY_uid18_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracY_uid19_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expY_uid20_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (7 downto 0);
    signal ypn_uid21_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal aSig_uid25_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aSig_uid25_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bSig_uid26_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal bSig_uid26_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (22 downto 0);
    signal cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal exp_aSig_uid30_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (30 downto 0);
    signal exp_aSig_uid30_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_aSig_uid31_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (22 downto 0);
    signal frac_aSig_uid31_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid33_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid33_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid34_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid35_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_aSig_uid36_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_aSig_uid37_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_aSig_uid37_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid38_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid39_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_aSig_uid40_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exp_bSig_uid44_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (30 downto 0);
    signal exp_bSig_uid44_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_bSig_uid45_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (22 downto 0);
    signal frac_bSig_uid45_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid47_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid47_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid48_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid49_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_bSig_uid50_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_bSig_uid51_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_bSig_uid51_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid52_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_bSig_uid54_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigA_uid59_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sigB_uid60_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal effSub_uid61_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal effSub_uid61_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid65_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid65_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (22 downto 0);
    signal oFracB_uid68_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expAmExpB_uid69_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid69_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid69_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid69_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (8 downto 0);
    signal cWFP2_uid70_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal shiftedOut_uid72_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid72_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid72_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid72_fpAddSubTest_ieeeAdd_c : STD_LOGIC_VECTOR (0 downto 0);
    signal padConst_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal iShiftedOut_uid76_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (48 downto 0);
    signal alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal zocst_uid85_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (1 downto 0);
    signal fracAAddOp_uid86_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOp_uid89_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracAddResult_uid91_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid91_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid91_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid91_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (26 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracGRS_uid93_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal cAmA_uid95_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal aMinusA_uid96_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNorm_uid98_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (26 downto 0);
    signal oneCST_uid99_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expInc_uid100_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid100_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid100_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid100_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expPostNorm_uid101_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid101_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid101_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid101_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (9 downto 0);
    signal Sticky0_uid102_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky0_uid102_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky1_uid103_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (1 downto 0);
    signal Sticky1_uid103_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Round_uid104_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (2 downto 0);
    signal Round_uid104_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Guard_uid105_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (3 downto 0);
    signal Guard_uid105_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal LSB_uid106_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (4 downto 0);
    signal LSB_uid106_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rndBitCond_uid107_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal cRBit_uid108_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rBi_uid109_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rBi_uid109_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid110_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (25 downto 0);
    signal fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (23 downto 0);
    signal expFracR_uid112_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFrac_uid113_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid113_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid113_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (34 downto 0);
    signal wEP2AllOwE_uid114_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (9 downto 0);
    signal rndExp_uid115_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExp_uid115_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rOvf_uid120_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal wEP2AllZ_uid121_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (9 downto 0);
    signal rUdfEQMin_uid122_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdfExtraBit_uid123_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rUdfExtraBit_uid123_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdf_uid124_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPreExc_uid125_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid125_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExc_uid126_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (31 downto 0);
    signal expRPreExc_uid126_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (7 downto 0);
    signal regInputs_uid127_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal regInputs_uid127_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZeroVInC_uid128_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal excRZero_uid129_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rInfOvf_uid130_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rInfOvf_uid130_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInfVInC_uid131_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (5 downto 0);
    signal excRInf_uid132_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN2_uid133_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAIBISub_uid134_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid135_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid136_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid137_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invAMinusA_uid138_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRReg_uid139_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigBBInf_uid140_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigAAInf_uid141_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInf_uid142_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZBZSigASigB_uid143_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZARSigA_uid144_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRZero_uid145_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcRNaN_uid147_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid148_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneFracRPostExc2_uid149_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPostExc_uid152_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid152_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPostExc_uid156_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid156_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal R_uid157_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid159_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (11 downto 0);
    signal vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (11 downto 0);
    signal cStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid186_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid187_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal wIntCst_uid192_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng16_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage0Idx1_uid196_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx2Rng32_uid197_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (16 downto 0);
    signal rightShiftStage0Idx2Pad32_uid198_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage0Idx2_uid199_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx3Rng48_uid200_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx3Pad48_uid201_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0Idx3_uid202_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx1Rng4_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (44 downto 0);
    signal rightShiftStage1Idx1_uid207_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx2Rng8_uid208_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (40 downto 0);
    signal rightShiftStage1Idx2_uid210_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx3Rng12_uid211_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (36 downto 0);
    signal rightShiftStage1Idx3Pad12_uid212_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (11 downto 0);
    signal rightShiftStage1Idx3_uid213_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx1Rng1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage2Idx1_uid218_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx2Rng2_uid219_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (46 downto 0);
    signal rightShiftStage2Idx2_uid221_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx3Rng3_uid222_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (45 downto 0);
    signal rightShiftStage2Idx3Pad3_uid223_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage2Idx3_uid224_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal zeroOutCst_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal leftShiftStage0Idx1Rng8_uid233_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx1Rng8_uid233_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx1_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx2_uid237_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx3Pad24_uid238_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx3Rng24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx3Rng24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx3_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx1Rng2_uid244_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx1Rng2_uid244_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx1_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx2Rng4_uid247_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2Rng4_uid247_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx3Pad6_uid249_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (5 downto 0);
    signal leftShiftStage1Idx3Rng6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (21 downto 0);
    signal leftShiftStage1Idx3Rng6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (21 downto 0);
    signal leftShiftStage1Idx3_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage2Idx1Rng1_uid255_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage2Idx1Rng1_uid255_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage2Idx1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (25 downto 0);
    signal rVStage_uid168_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid168_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_d : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (25 downto 0);
    signal redist1_r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist2_vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist4_vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist6_signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_regInputs_uid127_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_expRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist9_fracRPreExc_uid125_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_3_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist14_rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist15_effSub_uid61_fpAddSubTest_ieeeAdd_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_sigB_uid60_fpAddSubTest_ieeeAdd_b_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist19_sigA_uid59_fpAddSubTest_ieeeAdd_b_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist22_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist26_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist34_expY_uid20_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist35_fracY_uid19_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist36_sigY_uid18_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_xIn_a_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_outputreg_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_reset0 : std_logic;
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve : boolean;
    attribute preserve of redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_i : signal is true;
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_sticky_ena_q : signal is true;
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- cAmA_uid95_fpAddSubTest_ieeeAdd(CONSTANT,94)
    cAmA_uid95_fpAddSubTest_ieeeAdd_q <= "11100";

    -- zs_uid159_lzCountVal_uid94_fpAddSubTest_ieeeAdd(CONSTANT,158)
    zs_uid159_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "0000000000000000";

    -- signB_uid6_fpAddSubTest(BITSELECT,5)@0
    signB_uid6_fpAddSubTest_b <= STD_LOGIC_VECTOR(b(31 downto 31));

    -- invSignB_uid8_fpAddSubTest(LOGICAL,7)@0
    invSignB_uid8_fpAddSubTest_q <= not (signB_uid6_fpAddSubTest_b);

    -- muxSignB_uid9_fpAddSubTest(MUX,8)@0
    muxSignB_uid9_fpAddSubTest_s <= opSel;
    muxSignB_uid9_fpAddSubTest_combproc: PROCESS (muxSignB_uid9_fpAddSubTest_s, en, invSignB_uid8_fpAddSubTest_q, signB_uid6_fpAddSubTest_b)
    BEGIN
        CASE (muxSignB_uid9_fpAddSubTest_s) IS
            WHEN "0" => muxSignB_uid9_fpAddSubTest_q <= invSignB_uid8_fpAddSubTest_q;
            WHEN "1" => muxSignB_uid9_fpAddSubTest_q <= signB_uid6_fpAddSubTest_b;
            WHEN OTHERS => muxSignB_uid9_fpAddSubTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- restB_uid7_fpAddSubTest(BITSELECT,6)@0
    restB_uid7_fpAddSubTest_b <= b(30 downto 0);

    -- bOperand_uid10_fpAddSubTest(BITJOIN,9)@0
    bOperand_uid10_fpAddSubTest_q <= muxSignB_uid9_fpAddSubTest_q & restB_uid7_fpAddSubTest_b;

    -- sigY_uid18_fpAddSubTest_ieeeAdd(BITSELECT,17)@0
    sigY_uid18_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(bOperand_uid10_fpAddSubTest_q(31 downto 31));

    -- redist36_sigY_uid18_fpAddSubTest_ieeeAdd_b_1(DELAY,301)
    redist36_sigY_uid18_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigY_uid18_fpAddSubTest_ieeeAdd_b, xout => redist36_sigY_uid18_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- expY_uid20_fpAddSubTest_ieeeAdd(BITSELECT,19)@0
    expY_uid20_fpAddSubTest_ieeeAdd_b <= bOperand_uid10_fpAddSubTest_q(30 downto 23);

    -- redist34_expY_uid20_fpAddSubTest_ieeeAdd_b_1(DELAY,299)
    redist34_expY_uid20_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expY_uid20_fpAddSubTest_ieeeAdd_b, xout => redist34_expY_uid20_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- fracY_uid19_fpAddSubTest_ieeeAdd(BITSELECT,18)@0
    fracY_uid19_fpAddSubTest_ieeeAdd_b <= bOperand_uid10_fpAddSubTest_q(22 downto 0);

    -- redist35_fracY_uid19_fpAddSubTest_ieeeAdd_b_1(DELAY,300)
    redist35_fracY_uid19_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracY_uid19_fpAddSubTest_ieeeAdd_b, xout => redist35_fracY_uid19_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- ypn_uid21_fpAddSubTest_ieeeAdd(BITJOIN,20)@1
    ypn_uid21_fpAddSubTest_ieeeAdd_q <= redist36_sigY_uid18_fpAddSubTest_ieeeAdd_b_1_q & redist34_expY_uid20_fpAddSubTest_ieeeAdd_b_1_q & redist35_fracY_uid19_fpAddSubTest_ieeeAdd_b_1_q;

    -- redist37_xIn_a_1(DELAY,302)
    redist37_xIn_a_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => a, xout => redist37_xIn_a_1_q, ena => en(0), clk => clk, aclr => areset );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- expFracY_uid16_fpAddSubTest_ieeeAdd(BITSELECT,15)@0
    expFracY_uid16_fpAddSubTest_ieeeAdd_b <= bOperand_uid10_fpAddSubTest_q(30 downto 0);

    -- expFracX_uid15_fpAddSubTest_ieeeAdd(BITSELECT,14)@0
    expFracX_uid15_fpAddSubTest_ieeeAdd_b <= a(30 downto 0);

    -- xGTEy_uid17_fpAddSubTest_ieeeAdd(COMPARE,16)@0 + 1
    xGTEy_uid17_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("00" & expFracX_uid15_fpAddSubTest_ieeeAdd_b);
    xGTEy_uid17_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("00" & expFracY_uid16_fpAddSubTest_ieeeAdd_b);
    xGTEy_uid17_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            xGTEy_uid17_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                xGTEy_uid17_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(xGTEy_uid17_fpAddSubTest_ieeeAdd_a) - UNSIGNED(xGTEy_uid17_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    xGTEy_uid17_fpAddSubTest_ieeeAdd_n(0) <= not (xGTEy_uid17_fpAddSubTest_ieeeAdd_o(32));

    -- bSig_uid26_fpAddSubTest_ieeeAdd(MUX,25)@1
    bSig_uid26_fpAddSubTest_ieeeAdd_s <= xGTEy_uid17_fpAddSubTest_ieeeAdd_n;
    bSig_uid26_fpAddSubTest_ieeeAdd_combproc: PROCESS (bSig_uid26_fpAddSubTest_ieeeAdd_s, en, redist37_xIn_a_1_q, ypn_uid21_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (bSig_uid26_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => bSig_uid26_fpAddSubTest_ieeeAdd_q <= redist37_xIn_a_1_q;
            WHEN "1" => bSig_uid26_fpAddSubTest_ieeeAdd_q <= ypn_uid21_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => bSig_uid26_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigB_uid60_fpAddSubTest_ieeeAdd(BITSELECT,59)@1
    sigB_uid60_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(bSig_uid26_fpAddSubTest_ieeeAdd_q(31 downto 31));

    -- redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_2(DELAY,281)
    redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigB_uid60_fpAddSubTest_ieeeAdd_b, xout => redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- aSig_uid25_fpAddSubTest_ieeeAdd(MUX,24)@1
    aSig_uid25_fpAddSubTest_ieeeAdd_s <= xGTEy_uid17_fpAddSubTest_ieeeAdd_n;
    aSig_uid25_fpAddSubTest_ieeeAdd_combproc: PROCESS (aSig_uid25_fpAddSubTest_ieeeAdd_s, en, ypn_uid21_fpAddSubTest_ieeeAdd_q, redist37_xIn_a_1_q)
    BEGIN
        CASE (aSig_uid25_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => aSig_uid25_fpAddSubTest_ieeeAdd_q <= ypn_uid21_fpAddSubTest_ieeeAdd_q;
            WHEN "1" => aSig_uid25_fpAddSubTest_ieeeAdd_q <= redist37_xIn_a_1_q;
            WHEN OTHERS => aSig_uid25_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigA_uid59_fpAddSubTest_ieeeAdd(BITSELECT,58)@1
    sigA_uid59_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(aSig_uid25_fpAddSubTest_ieeeAdd_q(31 downto 31));

    -- redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_2(DELAY,283)
    redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigA_uid59_fpAddSubTest_ieeeAdd_b, xout => redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- effSub_uid61_fpAddSubTest_ieeeAdd(LOGICAL,60)@3 + 1
    effSub_uid61_fpAddSubTest_ieeeAdd_qi <= redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_2_q xor redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_2_q;
    effSub_uid61_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => effSub_uid61_fpAddSubTest_ieeeAdd_qi, xout => effSub_uid61_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- exp_bSig_uid44_fpAddSubTest_ieeeAdd(BITSELECT,43)@1
    exp_bSig_uid44_fpAddSubTest_ieeeAdd_in <= bSig_uid26_fpAddSubTest_ieeeAdd_q(30 downto 0);
    exp_bSig_uid44_fpAddSubTest_ieeeAdd_b <= exp_bSig_uid44_fpAddSubTest_ieeeAdd_in(30 downto 23);

    -- exp_aSig_uid30_fpAddSubTest_ieeeAdd(BITSELECT,29)@1
    exp_aSig_uid30_fpAddSubTest_ieeeAdd_in <= aSig_uid25_fpAddSubTest_ieeeAdd_q(30 downto 0);
    exp_aSig_uid30_fpAddSubTest_ieeeAdd_b <= exp_aSig_uid30_fpAddSubTest_ieeeAdd_in(30 downto 23);

    -- expAmExpB_uid69_fpAddSubTest_ieeeAdd(SUB,68)@1 + 1
    expAmExpB_uid69_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & exp_aSig_uid30_fpAddSubTest_ieeeAdd_b);
    expAmExpB_uid69_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("0" & exp_bSig_uid44_fpAddSubTest_ieeeAdd_b);
    expAmExpB_uid69_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expAmExpB_uid69_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expAmExpB_uid69_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(expAmExpB_uid69_fpAddSubTest_ieeeAdd_a) - UNSIGNED(expAmExpB_uid69_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    expAmExpB_uid69_fpAddSubTest_ieeeAdd_q <= expAmExpB_uid69_fpAddSubTest_ieeeAdd_o(8 downto 0);

    -- cWFP2_uid70_fpAddSubTest_ieeeAdd(CONSTANT,69)
    cWFP2_uid70_fpAddSubTest_ieeeAdd_q <= "11001";

    -- shiftedOut_uid72_fpAddSubTest_ieeeAdd(COMPARE,71)@2 + 1
    shiftedOut_uid72_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("000000" & cWFP2_uid70_fpAddSubTest_ieeeAdd_q);
    shiftedOut_uid72_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("00" & expAmExpB_uid69_fpAddSubTest_ieeeAdd_q);
    shiftedOut_uid72_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid72_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                shiftedOut_uid72_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid72_fpAddSubTest_ieeeAdd_a) - UNSIGNED(shiftedOut_uid72_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    shiftedOut_uid72_fpAddSubTest_ieeeAdd_c(0) <= shiftedOut_uid72_fpAddSubTest_ieeeAdd_o(10);

    -- iShiftedOut_uid76_fpAddSubTest_ieeeAdd(LOGICAL,75)@3
    iShiftedOut_uid76_fpAddSubTest_ieeeAdd_q <= not (shiftedOut_uid72_fpAddSubTest_ieeeAdd_c);

    -- zeroOutCst_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,226)
    zeroOutCst_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "0000000000000000000000000000000000000000000000000";

    -- rightShiftStage2Idx3Pad3_uid223_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,222)
    rightShiftStage2Idx3Pad3_uid223_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "000";

    -- rightShiftStage2Idx3Rng3_uid222_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,221)@2
    rightShiftStage2Idx3Rng3_uid222_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 3);

    -- rightShiftStage2Idx3_uid224_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,223)@2
    rightShiftStage2Idx3_uid224_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2Idx3Pad3_uid223_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q & rightShiftStage2Idx3Rng3_uid222_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- zs_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd(CONSTANT,178)
    zs_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "00";

    -- rightShiftStage2Idx2Rng2_uid219_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,218)@2
    rightShiftStage2Idx2Rng2_uid219_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 2);

    -- rightShiftStage2Idx2_uid221_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,220)@2
    rightShiftStage2Idx2_uid221_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= zs_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q & rightShiftStage2Idx2Rng2_uid219_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage2Idx1Rng1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,215)@2
    rightShiftStage2Idx1Rng1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 1);

    -- rightShiftStage2Idx1_uid218_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,217)@2
    rightShiftStage2Idx1_uid218_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= GND_q & rightShiftStage2Idx1Rng1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage1Idx3Pad12_uid212_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,211)
    rightShiftStage1Idx3Pad12_uid212_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "000000000000";

    -- rightShiftStage1Idx3Rng12_uid211_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,210)@2
    rightShiftStage1Idx3Rng12_uid211_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 12);

    -- rightShiftStage1Idx3_uid213_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,212)@2
    rightShiftStage1Idx3_uid213_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1Idx3Pad12_uid212_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q & rightShiftStage1Idx3Rng12_uid211_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- cstAllZWE_uid29_fpAddSubTest_ieeeAdd(CONSTANT,28)
    cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q <= "00000000";

    -- rightShiftStage1Idx2Rng8_uid208_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,207)@2
    rightShiftStage1Idx2Rng8_uid208_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 8);

    -- rightShiftStage1Idx2_uid210_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,209)@2
    rightShiftStage1Idx2_uid210_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q & rightShiftStage1Idx2Rng8_uid208_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- zs_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd(CONSTANT,172)
    zs_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "0000";

    -- rightShiftStage1Idx1Rng4_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,204)@2
    rightShiftStage1Idx1Rng4_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 4);

    -- rightShiftStage1Idx1_uid207_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,206)@2
    rightShiftStage1Idx1_uid207_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= zs_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q & rightShiftStage1Idx1Rng4_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage0Idx3Pad48_uid201_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,200)
    rightShiftStage0Idx3Pad48_uid201_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx3Rng48_uid200_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,199)@2
    rightShiftStage0Idx3Rng48_uid200_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q(48 downto 48);

    -- rightShiftStage0Idx3_uid202_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,201)@2
    rightShiftStage0Idx3_uid202_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx3Pad48_uid201_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q & rightShiftStage0Idx3Rng48_uid200_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage0Idx2Pad32_uid198_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,197)
    rightShiftStage0Idx2Pad32_uid198_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "00000000000000000000000000000000";

    -- rightShiftStage0Idx2Rng32_uid197_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,196)@2
    rightShiftStage0Idx2Rng32_uid197_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q(48 downto 32);

    -- rightShiftStage0Idx2_uid199_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,198)@2
    rightShiftStage0Idx2_uid199_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx2Pad32_uid198_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q & rightShiftStage0Idx2Rng32_uid197_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage0Idx1Rng16_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,193)@2
    rightShiftStage0Idx1Rng16_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q(48 downto 16);

    -- rightShiftStage0Idx1_uid196_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,195)@2
    rightShiftStage0Idx1_uid196_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= zs_uid159_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q & rightShiftStage0Idx1Rng16_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd(LOGICAL,45)@1 + 1
    excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_qi <= "1" WHEN exp_bSig_uid44_fpAddSubTest_ieeeAdd_b = cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q ELSE "0";
    excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_qi, xout => excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd(LOGICAL,52)@2
    InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q <= not (excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q);

    -- cstZeroWF_uid28_fpAddSubTest_ieeeAdd(CONSTANT,27)
    cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q <= "00000000000000000000000";

    -- frac_bSig_uid45_fpAddSubTest_ieeeAdd(BITSELECT,44)@1
    frac_bSig_uid45_fpAddSubTest_ieeeAdd_in <= bSig_uid26_fpAddSubTest_ieeeAdd_q(22 downto 0);
    frac_bSig_uid45_fpAddSubTest_ieeeAdd_b <= frac_bSig_uid45_fpAddSubTest_ieeeAdd_in(22 downto 0);

    -- redist27_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1(DELAY,292)
    redist27_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => frac_bSig_uid45_fpAddSubTest_ieeeAdd_b, xout => redist27_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- fracBz_uid65_fpAddSubTest_ieeeAdd(MUX,64)@2
    fracBz_uid65_fpAddSubTest_ieeeAdd_s <= excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q;
    fracBz_uid65_fpAddSubTest_ieeeAdd_combproc: PROCESS (fracBz_uid65_fpAddSubTest_ieeeAdd_s, en, redist27_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q, cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (fracBz_uid65_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => fracBz_uid65_fpAddSubTest_ieeeAdd_q <= redist27_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q;
            WHEN "1" => fracBz_uid65_fpAddSubTest_ieeeAdd_q <= cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => fracBz_uid65_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oFracB_uid68_fpAddSubTest_ieeeAdd(BITJOIN,67)@2
    oFracB_uid68_fpAddSubTest_ieeeAdd_q <= InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q & fracBz_uid65_fpAddSubTest_ieeeAdd_q;

    -- padConst_uid73_fpAddSubTest_ieeeAdd(CONSTANT,72)
    padConst_uid73_fpAddSubTest_ieeeAdd_q <= "0000000000000000000000000";

    -- rightPaddedIn_uid74_fpAddSubTest_ieeeAdd(BITJOIN,73)@2
    rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q <= oFracB_uid68_fpAddSubTest_ieeeAdd_q & padConst_uid73_fpAddSubTest_ieeeAdd_q;

    -- rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(MUX,203)@2
    rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s <= rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_b;
    rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_combproc: PROCESS (rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s, en, rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q, rightShiftStage0Idx1_uid196_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage0Idx2_uid199_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage0Idx3_uid202_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx1_uid196_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "10" => rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx2_uid199_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx3_uid202_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(MUX,214)@2
    rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s <= rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_c;
    rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_combproc: PROCESS (rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s, en, rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage1Idx1_uid207_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage1Idx2_uid210_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage1Idx3_uid213_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1Idx1_uid207_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "10" => rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1Idx2_uid210_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1Idx3_uid213_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,259)@2
    rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in <= expAmExpB_uid69_fpAddSubTest_ieeeAdd_q(5 downto 0);
    rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_b <= rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in(5 downto 4);
    rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_c <= rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in(3 downto 2);
    rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_d <= rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in(1 downto 0);

    -- rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(MUX,225)@2 + 1
    rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s <= rightShiftStageSel5Dto4_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_d;
    rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s) IS
                    WHEN "00" => rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1_uid215_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
                    WHEN "01" => rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2Idx1_uid218_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
                    WHEN "10" => rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2Idx2_uid221_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
                    WHEN "11" => rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2Idx3_uid224_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
                    WHEN OTHERS => rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- wIntCst_uid192_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,191)
    wIntCst_uid192_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "110001";

    -- shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(COMPARE,192)@2 + 1
    shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("00" & expAmExpB_uid69_fpAddSubTest_ieeeAdd_q);
    shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("00000" & wIntCst_uid192_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q);
    shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_a) - UNSIGNED(shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_n(0) <= not (shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_o(10));

    -- r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(MUX,227)@3
    r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s <= shiftedOut_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_n;
    r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_combproc: PROCESS (r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s, en, rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, zeroOutCst_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2_uid226_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "1" => r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= zeroOutCst_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd(LOGICAL,76)@3
    alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 1 => iShiftedOut_uid76_fpAddSubTest_ieeeAdd_q(0)) & iShiftedOut_uid76_fpAddSubTest_ieeeAdd_q));
    alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_q <= r_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q and alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_b;

    -- stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,260)@3
    stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_b <= alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_q(22 downto 0);
    stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c <= alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_q(48 downto 23);

    -- redist0_stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c_1(DELAY,265)
    redist0_stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 26, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c, xout => redist0_stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => areset );

    -- fracBAddOp_uid89_fpAddSubTest_ieeeAdd(BITJOIN,88)@4
    fracBAddOp_uid89_fpAddSubTest_ieeeAdd_q <= GND_q & redist0_stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c_1_q;

    -- fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd(LOGICAL,89)@4
    fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 1 => effSub_uid61_fpAddSubTest_ieeeAdd_q(0)) & effSub_uid61_fpAddSubTest_ieeeAdd_q));
    fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_q <= fracBAddOp_uid89_fpAddSubTest_ieeeAdd_q xor fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_b;

    -- zocst_uid85_fpAddSubTest_ieeeAdd(CONSTANT,84)
    zocst_uid85_fpAddSubTest_ieeeAdd_q <= "01";

    -- frac_aSig_uid31_fpAddSubTest_ieeeAdd(BITSELECT,30)@1
    frac_aSig_uid31_fpAddSubTest_ieeeAdd_in <= aSig_uid25_fpAddSubTest_ieeeAdd_q(22 downto 0);
    frac_aSig_uid31_fpAddSubTest_ieeeAdd_b <= frac_aSig_uid31_fpAddSubTest_ieeeAdd_in(22 downto 0);

    -- redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3(DELAY,297)
    redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3 : dspba_delay
    GENERIC MAP ( width => 23, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => frac_aSig_uid31_fpAddSubTest_ieeeAdd_b, xout => redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3_q, ena => en(0), clk => clk, aclr => areset );

    -- cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd(LOGICAL,79)@3 + 1
    cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_qi <= "1" WHEN stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_b = cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q ELSE "0";
    cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_qi, xout => cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- effSubInvSticky_uid83_fpAddSubTest_ieeeAdd(LOGICAL,82)@4
    effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_q <= effSub_uid61_fpAddSubTest_ieeeAdd_q and cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_q;

    -- fracAAddOp_uid86_fpAddSubTest_ieeeAdd(BITJOIN,85)@4
    fracAAddOp_uid86_fpAddSubTest_ieeeAdd_q <= zocst_uid85_fpAddSubTest_ieeeAdd_q & redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3_q & GND_q & effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_q;

    -- fracAddResult_uid91_fpAddSubTest_ieeeAdd(ADD,90)@4
    fracAddResult_uid91_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & fracAAddOp_uid86_fpAddSubTest_ieeeAdd_q);
    fracAddResult_uid91_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("0" & fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_q);
    fracAddResult_uid91_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(fracAddResult_uid91_fpAddSubTest_ieeeAdd_a) + UNSIGNED(fracAddResult_uid91_fpAddSubTest_ieeeAdd_b));
    fracAddResult_uid91_fpAddSubTest_ieeeAdd_q <= fracAddResult_uid91_fpAddSubTest_ieeeAdd_o(27 downto 0);

    -- rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd(BITSELECT,91)@4
    rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_in <= fracAddResult_uid91_fpAddSubTest_ieeeAdd_q(26 downto 0);
    rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b <= rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_in(26 downto 0);

    -- redist14_rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b_1(DELAY,279)
    redist14_rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b, xout => redist14_rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd(LOGICAL,80)@4 + 1
    invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_qi <= not (cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_q);
    invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_qi, xout => invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- fracGRS_uid93_fpAddSubTest_ieeeAdd(BITJOIN,92)@5
    fracGRS_uid93_fpAddSubTest_ieeeAdd_q <= redist14_rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b_1_q & invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_q;

    -- rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITSELECT,159)@5
    rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b <= fracGRS_uid93_fpAddSubTest_ieeeAdd_q(27 downto 12);

    -- vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,160)@5 + 1
    vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_qi <= "1" WHEN rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b = zs_uid159_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q ELSE "0";
    vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_qi, xout => vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist4_vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2(DELAY,269)
    redist4_vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q, xout => redist4_vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1(DELAY,277)
    redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracGRS_uid93_fpAddSubTest_ieeeAdd_q, xout => redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITSELECT,162)@6
    vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_in <= redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1_q(11 downto 0);
    vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b <= vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_in(11 downto 0);

    -- mO_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd(CONSTANT,161)
    mO_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1111";

    -- cStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITJOIN,163)@6
    cStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b & mO_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- redist5_rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1(DELAY,270)
    redist5_rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b, xout => redist5_rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd(MUX,165)@6
    vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s <= vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
    vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_combproc: PROCESS (vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s, en, redist5_rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q, cStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= redist5_rVStage_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q;
            WHEN "1" => vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= cStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid168_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,261)@6
    rVStage_uid168_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b <= vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(15 downto 8);
    rVStage_uid168_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c <= vStagei_uid166_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(7 downto 0);

    -- vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,168)@6
    vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1" WHEN rVStage_uid168_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b = cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- redist2_vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1(DELAY,267)
    redist2_vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q, xout => redist2_vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd(MUX,171)@6 + 1
    vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s <= vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
    vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s) IS
                    WHEN "0" => vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid168_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b;
                    WHEN "1" => vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid168_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c;
                    WHEN OTHERS => vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,262)@7
    rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b <= vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(7 downto 4);
    rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c <= vStagei_uid172_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(3 downto 0);

    -- vCount_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,174)@7
    vCount_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1" WHEN rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b = zs_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd(MUX,177)@7
    vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s <= vCount_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
    vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_combproc: PROCESS (vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s, en, rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b, rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b;
            WHEN "1" => vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,263)@7
    rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b <= vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(3 downto 2);
    rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c <= vStagei_uid178_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(1 downto 0);

    -- vCount_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,180)@7
    vCount_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1" WHEN rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b = zs_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd(MUX,183)@7
    vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s <= vCount_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
    vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_combproc: PROCESS (vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s, en, rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b, rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b;
            WHEN "1" => vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid186_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITSELECT,185)@7
    rVStage_uid186_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b <= vStagei_uid184_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(1 downto 1);

    -- vCount_uid187_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,186)@7
    vCount_uid187_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1" WHEN rVStage_uid186_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b = GND_q ELSE "0";

    -- r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITJOIN,187)@7
    r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= redist4_vCount_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2_q & redist2_vCount_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q & vCount_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q & vCount_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q & vCount_uid187_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- redist1_r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1(DELAY,266)
    redist1_r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1 : dspba_delay
    GENERIC MAP ( width => 5, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q, xout => redist1_r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- aMinusA_uid96_fpAddSubTest_ieeeAdd(LOGICAL,95)@8
    aMinusA_uid96_fpAddSubTest_ieeeAdd_q <= "1" WHEN redist1_r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q = cAmA_uid95_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- invAMinusA_uid138_fpAddSubTest_ieeeAdd(LOGICAL,137)@8
    invAMinusA_uid138_fpAddSubTest_ieeeAdd_q <= not (aMinusA_uid96_fpAddSubTest_ieeeAdd_q);

    -- redist19_sigA_uid59_fpAddSubTest_ieeeAdd_b_7(DELAY,284)
    redist19_sigA_uid59_fpAddSubTest_ieeeAdd_b_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_2_q, xout => redist19_sigA_uid59_fpAddSubTest_ieeeAdd_b_7_q, ena => en(0), clk => clk, aclr => areset );

    -- cstAllOWE_uid27_fpAddSubTest_ieeeAdd(CONSTANT,26)
    cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q <= "11111111";

    -- expXIsMax_uid47_fpAddSubTest_ieeeAdd(LOGICAL,46)@1 + 1
    expXIsMax_uid47_fpAddSubTest_ieeeAdd_qi <= "1" WHEN exp_bSig_uid44_fpAddSubTest_ieeeAdd_b = cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q ELSE "0";
    expXIsMax_uid47_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid47_fpAddSubTest_ieeeAdd_qi, xout => expXIsMax_uid47_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist24_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_7(DELAY,289)
    redist24_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid47_fpAddSubTest_ieeeAdd_q, xout => redist24_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_7_q, ena => en(0), clk => clk, aclr => areset );

    -- invExpXIsMax_uid52_fpAddSubTest_ieeeAdd(LOGICAL,51)@8
    invExpXIsMax_uid52_fpAddSubTest_ieeeAdd_q <= not (redist24_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_7_q);

    -- redist20_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_6(DELAY,285)
    redist20_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q, xout => redist20_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_6_q, ena => en(0), clk => clk, aclr => areset );

    -- excR_bSig_uid54_fpAddSubTest_ieeeAdd(LOGICAL,53)@8
    excR_bSig_uid54_fpAddSubTest_ieeeAdd_q <= redist20_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_6_q and invExpXIsMax_uid52_fpAddSubTest_ieeeAdd_q;

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_notEnable(LOGICAL,311)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_nor(LOGICAL,312)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_nor_q <= not (redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_notEnable_q or redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_sticky_ena_q);

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_last(CONSTANT,308)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_last_q <= "010";

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmp(LOGICAL,309)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmp_b <= STD_LOGIC_VECTOR("0" & redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_q);
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmp_q <= "1" WHEN redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_last_q = redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmp_b ELSE "0";

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmpReg(REG,310)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmpReg_q <= STD_LOGIC_VECTOR(redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_sticky_ena(REG,313)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_nor_q = "1") THEN
                redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_sticky_ena_q <= STD_LOGIC_VECTOR(redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_enaAnd(LOGICAL,314)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_enaAnd_q <= redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_sticky_ena_q and en;

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt(COUNTER,305)
    -- low=0, high=3, step=1, init=0
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_i <= redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_i, 2)));

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux(MUX,306)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_s <= en;
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_combproc: PROCESS (redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_s, redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_wraddr_q, redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_q)
    BEGIN
        CASE (redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_s) IS
            WHEN "0" => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_q <= redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_wraddr_q;
            WHEN "1" => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_q <= redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdcnt_q;
            WHEN OTHERS => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_wraddr(REG,307)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_wraddr_q <= "11";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_wraddr_q <= STD_LOGIC_VECTOR(redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_q);
        END IF;
    END PROCESS;

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem(DUALMEM,304)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_ia <= STD_LOGIC_VECTOR(exp_aSig_uid30_fpAddSubTest_ieeeAdd_b);
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_aa <= redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_wraddr_q;
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_ab <= redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_rdmux_q;
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_reset0 <= areset;
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 8,
        widthad_b => 2,
        numwords_b => 4,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_reset0,
        clock1 => clk,
        address_a => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_aa,
        data_a => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_ia,
        wren_a => en(0),
        address_b => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_ab,
        q_b => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_iq
    );
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_q <= redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_iq(7 downto 0);

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_outputreg(DELAY,303)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_outputreg : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_mem_q, xout => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_outputreg_q, ena => en(0), clk => clk, aclr => areset );

    -- expXIsMax_uid33_fpAddSubTest_ieeeAdd(LOGICAL,32)@7 + 1
    expXIsMax_uid33_fpAddSubTest_ieeeAdd_qi <= "1" WHEN redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_outputreg_q = cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q ELSE "0";
    expXIsMax_uid33_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid33_fpAddSubTest_ieeeAdd_qi, xout => expXIsMax_uid33_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- invExpXIsMax_uid38_fpAddSubTest_ieeeAdd(LOGICAL,37)@8
    invExpXIsMax_uid38_fpAddSubTest_ieeeAdd_q <= not (expXIsMax_uid33_fpAddSubTest_ieeeAdd_q);

    -- excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd(LOGICAL,31)@7 + 1
    excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_qi <= "1" WHEN redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_outputreg_q = cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q ELSE "0";
    excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_qi, xout => excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- InvExpXIsZero_uid39_fpAddSubTest_ieeeAdd(LOGICAL,38)@8
    InvExpXIsZero_uid39_fpAddSubTest_ieeeAdd_q <= not (excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q);

    -- excR_aSig_uid40_fpAddSubTest_ieeeAdd(LOGICAL,39)@8
    excR_aSig_uid40_fpAddSubTest_ieeeAdd_q <= InvExpXIsZero_uid39_fpAddSubTest_ieeeAdd_q and invExpXIsMax_uid38_fpAddSubTest_ieeeAdd_q;

    -- signRReg_uid139_fpAddSubTest_ieeeAdd(LOGICAL,138)@8
    signRReg_uid139_fpAddSubTest_ieeeAdd_q <= excR_aSig_uid40_fpAddSubTest_ieeeAdd_q and excR_bSig_uid54_fpAddSubTest_ieeeAdd_q and redist19_sigA_uid59_fpAddSubTest_ieeeAdd_b_7_q and invAMinusA_uid138_fpAddSubTest_ieeeAdd_q;

    -- redist17_sigB_uid60_fpAddSubTest_ieeeAdd_b_7(DELAY,282)
    redist17_sigB_uid60_fpAddSubTest_ieeeAdd_b_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_2_q, xout => redist17_sigB_uid60_fpAddSubTest_ieeeAdd_b_7_q, ena => en(0), clk => clk, aclr => areset );

    -- redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_7(DELAY,290)
    redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q, xout => redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_7_q, ena => en(0), clk => clk, aclr => areset );

    -- excAZBZSigASigB_uid143_fpAddSubTest_ieeeAdd(LOGICAL,142)@8
    excAZBZSigASigB_uid143_fpAddSubTest_ieeeAdd_q <= excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q and redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_7_q and redist19_sigA_uid59_fpAddSubTest_ieeeAdd_b_7_q and redist17_sigB_uid60_fpAddSubTest_ieeeAdd_b_7_q;

    -- excBZARSigA_uid144_fpAddSubTest_ieeeAdd(LOGICAL,143)@8
    excBZARSigA_uid144_fpAddSubTest_ieeeAdd_q <= redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_7_q and excR_aSig_uid40_fpAddSubTest_ieeeAdd_q and redist19_sigA_uid59_fpAddSubTest_ieeeAdd_b_7_q;

    -- signRZero_uid145_fpAddSubTest_ieeeAdd(LOGICAL,144)@8
    signRZero_uid145_fpAddSubTest_ieeeAdd_q <= excBZARSigA_uid144_fpAddSubTest_ieeeAdd_q or excAZBZSigASigB_uid143_fpAddSubTest_ieeeAdd_q;

    -- fracXIsZero_uid48_fpAddSubTest_ieeeAdd(LOGICAL,47)@2 + 1
    fracXIsZero_uid48_fpAddSubTest_ieeeAdd_qi <= "1" WHEN cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q = redist27_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q ELSE "0";
    fracXIsZero_uid48_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid48_fpAddSubTest_ieeeAdd_qi, xout => fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist23_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_6(DELAY,288)
    redist23_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q, xout => redist23_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_6_q, ena => en(0), clk => clk, aclr => areset );

    -- excI_bSig_uid50_fpAddSubTest_ieeeAdd(LOGICAL,49)@8
    excI_bSig_uid50_fpAddSubTest_ieeeAdd_q <= redist24_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_7_q and redist23_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_6_q;

    -- sigBBInf_uid140_fpAddSubTest_ieeeAdd(LOGICAL,139)@8
    sigBBInf_uid140_fpAddSubTest_ieeeAdd_q <= redist17_sigB_uid60_fpAddSubTest_ieeeAdd_b_7_q and excI_bSig_uid50_fpAddSubTest_ieeeAdd_q;

    -- fracXIsZero_uid34_fpAddSubTest_ieeeAdd(LOGICAL,33)@4 + 1
    fracXIsZero_uid34_fpAddSubTest_ieeeAdd_qi <= "1" WHEN cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q = redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3_q ELSE "0";
    fracXIsZero_uid34_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid34_fpAddSubTest_ieeeAdd_qi, xout => fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_4(DELAY,295)
    redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q, xout => redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_4_q, ena => en(0), clk => clk, aclr => areset );

    -- excI_aSig_uid36_fpAddSubTest_ieeeAdd(LOGICAL,35)@8
    excI_aSig_uid36_fpAddSubTest_ieeeAdd_q <= expXIsMax_uid33_fpAddSubTest_ieeeAdd_q and redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_4_q;

    -- sigAAInf_uid141_fpAddSubTest_ieeeAdd(LOGICAL,140)@8
    sigAAInf_uid141_fpAddSubTest_ieeeAdd_q <= redist19_sigA_uid59_fpAddSubTest_ieeeAdd_b_7_q and excI_aSig_uid36_fpAddSubTest_ieeeAdd_q;

    -- signRInf_uid142_fpAddSubTest_ieeeAdd(LOGICAL,141)@8
    signRInf_uid142_fpAddSubTest_ieeeAdd_q <= sigAAInf_uid141_fpAddSubTest_ieeeAdd_q or sigBBInf_uid140_fpAddSubTest_ieeeAdd_q;

    -- signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd(LOGICAL,145)@8 + 1
    signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_qi <= signRInf_uid142_fpAddSubTest_ieeeAdd_q or signRZero_uid145_fpAddSubTest_ieeeAdd_q or signRReg_uid139_fpAddSubTest_ieeeAdd_q;
    signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_qi, xout => signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist6_signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_q_3(DELAY,271)
    redist6_signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_q, xout => redist6_signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- fracXIsNotZero_uid49_fpAddSubTest_ieeeAdd(LOGICAL,48)@8
    fracXIsNotZero_uid49_fpAddSubTest_ieeeAdd_q <= not (redist23_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_6_q);

    -- excN_bSig_uid51_fpAddSubTest_ieeeAdd(LOGICAL,50)@8 + 1
    excN_bSig_uid51_fpAddSubTest_ieeeAdd_qi <= redist24_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_7_q and fracXIsNotZero_uid49_fpAddSubTest_ieeeAdd_q;
    excN_bSig_uid51_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excN_bSig_uid51_fpAddSubTest_ieeeAdd_qi, xout => excN_bSig_uid51_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist21_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_3(DELAY,286)
    redist21_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => excN_bSig_uid51_fpAddSubTest_ieeeAdd_q, xout => redist21_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- fracXIsNotZero_uid35_fpAddSubTest_ieeeAdd(LOGICAL,34)@8
    fracXIsNotZero_uid35_fpAddSubTest_ieeeAdd_q <= not (redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_4_q);

    -- excN_aSig_uid37_fpAddSubTest_ieeeAdd(LOGICAL,36)@8 + 1
    excN_aSig_uid37_fpAddSubTest_ieeeAdd_qi <= expXIsMax_uid33_fpAddSubTest_ieeeAdd_q and fracXIsNotZero_uid35_fpAddSubTest_ieeeAdd_q;
    excN_aSig_uid37_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excN_aSig_uid37_fpAddSubTest_ieeeAdd_qi, xout => excN_aSig_uid37_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_3(DELAY,293)
    redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => excN_aSig_uid37_fpAddSubTest_ieeeAdd_q, xout => redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- excRNaN2_uid133_fpAddSubTest_ieeeAdd(LOGICAL,132)@11
    excRNaN2_uid133_fpAddSubTest_ieeeAdd_q <= redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_3_q or redist21_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_3_q;

    -- redist15_effSub_uid61_fpAddSubTest_ieeeAdd_q_8(DELAY,280)
    redist15_effSub_uid61_fpAddSubTest_ieeeAdd_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => effSub_uid61_fpAddSubTest_ieeeAdd_q, xout => redist15_effSub_uid61_fpAddSubTest_ieeeAdd_q_8_q, ena => en(0), clk => clk, aclr => areset );

    -- redist22_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_3(DELAY,287)
    redist22_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => excI_bSig_uid50_fpAddSubTest_ieeeAdd_q, xout => redist22_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_3(DELAY,294)
    redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => excI_aSig_uid36_fpAddSubTest_ieeeAdd_q, xout => redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- excAIBISub_uid134_fpAddSubTest_ieeeAdd(LOGICAL,133)@11
    excAIBISub_uid134_fpAddSubTest_ieeeAdd_q <= redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_3_q and redist22_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_3_q and redist15_effSub_uid61_fpAddSubTest_ieeeAdd_q_8_q;

    -- excRNaN_uid135_fpAddSubTest_ieeeAdd(LOGICAL,134)@11
    excRNaN_uid135_fpAddSubTest_ieeeAdd_q <= excAIBISub_uid134_fpAddSubTest_ieeeAdd_q or excRNaN2_uid133_fpAddSubTest_ieeeAdd_q;

    -- invExcRNaN_uid147_fpAddSubTest_ieeeAdd(LOGICAL,146)@11
    invExcRNaN_uid147_fpAddSubTest_ieeeAdd_q <= not (excRNaN_uid135_fpAddSubTest_ieeeAdd_q);

    -- signRPostExc_uid148_fpAddSubTest_ieeeAdd(LOGICAL,147)@11
    signRPostExc_uid148_fpAddSubTest_ieeeAdd_q <= invExcRNaN_uid147_fpAddSubTest_ieeeAdd_q and redist6_signRInfRZRReg_uid146_fpAddSubTest_ieeeAdd_q_3_q;

    -- cRBit_uid108_fpAddSubTest_ieeeAdd(CONSTANT,107)
    cRBit_uid108_fpAddSubTest_ieeeAdd_q <= "01000";

    -- leftShiftStage2Idx1Rng1_uid255_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,254)@8
    leftShiftStage2Idx1Rng1_uid255_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(26 downto 0);
    leftShiftStage2Idx1Rng1_uid255_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage2Idx1Rng1_uid255_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(26 downto 0);

    -- leftShiftStage2Idx1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,255)@8
    leftShiftStage2Idx1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage2Idx1Rng1_uid255_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & GND_q;

    -- leftShiftStage1Idx3Rng6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,249)@8
    leftShiftStage1Idx3Rng6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(21 downto 0);
    leftShiftStage1Idx3Rng6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage1Idx3Rng6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(21 downto 0);

    -- leftShiftStage1Idx3Pad6_uid249_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(CONSTANT,248)
    leftShiftStage1Idx3Pad6_uid249_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= "000000";

    -- leftShiftStage1Idx3_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,250)@8
    leftShiftStage1Idx3_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx3Rng6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & leftShiftStage1Idx3Pad6_uid249_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;

    -- leftShiftStage1Idx2Rng4_uid247_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,246)@8
    leftShiftStage1Idx2Rng4_uid247_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(23 downto 0);
    leftShiftStage1Idx2Rng4_uid247_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage1Idx2Rng4_uid247_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(23 downto 0);

    -- leftShiftStage1Idx2_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,247)@8
    leftShiftStage1Idx2_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx2Rng4_uid247_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & zs_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- leftShiftStage1Idx1Rng2_uid244_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,243)@8
    leftShiftStage1Idx1Rng2_uid244_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(25 downto 0);
    leftShiftStage1Idx1Rng2_uid244_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage1Idx1Rng2_uid244_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(25 downto 0);

    -- leftShiftStage1Idx1_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,244)@8
    leftShiftStage1Idx1_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx1Rng2_uid244_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & zs_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- leftShiftStage0Idx3Rng24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,238)@8
    leftShiftStage0Idx3Rng24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_3_q(3 downto 0);
    leftShiftStage0Idx3Rng24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage0Idx3Rng24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(3 downto 0);

    -- leftShiftStage0Idx3Pad24_uid238_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(CONSTANT,237)
    leftShiftStage0Idx3Pad24_uid238_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= "000000000000000000000000";

    -- leftShiftStage0Idx3_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,239)@8
    leftShiftStage0Idx3_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx3Rng24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & leftShiftStage0Idx3Pad24_uid238_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;

    -- redist3_vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_2(DELAY,268)
    redist3_vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_2 : dspba_delay
    GENERIC MAP ( width => 12, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b, xout => redist3_vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- leftShiftStage0Idx2_uid237_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,236)@8
    leftShiftStage0Idx2_uid237_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= redist3_vStage_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_2_q & zs_uid159_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- leftShiftStage0Idx1Rng8_uid233_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,232)@8
    leftShiftStage0Idx1Rng8_uid233_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_3_q(19 downto 0);
    leftShiftStage0Idx1Rng8_uid233_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage0Idx1Rng8_uid233_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(19 downto 0);

    -- leftShiftStage0Idx1_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,233)@8
    leftShiftStage0Idx1_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx1Rng8_uid233_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q;

    -- redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_3(DELAY,278)
    redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_3 : dspba_delay
    GENERIC MAP ( width => 28, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1_q, xout => redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(MUX,241)@8
    leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s <= leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_b;
    leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_combproc: PROCESS (leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s, en, redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_3_q, leftShiftStage0Idx1_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage0Idx2_uid237_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage0Idx3_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_3_q;
            WHEN "01" => leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx1_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "10" => leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx2_uid237_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx3_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(MUX,252)@8
    leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s <= leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_c;
    leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_combproc: PROCESS (leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s, en, leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage1Idx1_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage1Idx2_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage1Idx3_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx1_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "10" => leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx2_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx3_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,264)@8
    leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_b <= redist1_r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q(4 downto 3);
    leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_c <= redist1_r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q(2 downto 1);
    leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_d <= redist1_r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q(0 downto 0);

    -- leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(MUX,257)@8
    leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s <= leftShiftStageSel4Dto3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_d;
    leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_combproc: PROCESS (leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s, en, leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage2Idx1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1_uid253_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "1" => leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage2Idx1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- LSB_uid106_fpAddSubTest_ieeeAdd(BITSELECT,105)@8
    LSB_uid106_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(4 downto 0));
    LSB_uid106_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(LSB_uid106_fpAddSubTest_ieeeAdd_in(4 downto 4));

    -- Guard_uid105_fpAddSubTest_ieeeAdd(BITSELECT,104)@8
    Guard_uid105_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(3 downto 0));
    Guard_uid105_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(Guard_uid105_fpAddSubTest_ieeeAdd_in(3 downto 3));

    -- Round_uid104_fpAddSubTest_ieeeAdd(BITSELECT,103)@8
    Round_uid104_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(2 downto 0));
    Round_uid104_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(Round_uid104_fpAddSubTest_ieeeAdd_in(2 downto 2));

    -- Sticky1_uid103_fpAddSubTest_ieeeAdd(BITSELECT,102)@8
    Sticky1_uid103_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(1 downto 0));
    Sticky1_uid103_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(Sticky1_uid103_fpAddSubTest_ieeeAdd_in(1 downto 1));

    -- Sticky0_uid102_fpAddSubTest_ieeeAdd(BITSELECT,101)@8
    Sticky0_uid102_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(0 downto 0));
    Sticky0_uid102_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(Sticky0_uid102_fpAddSubTest_ieeeAdd_in(0 downto 0));

    -- rndBitCond_uid107_fpAddSubTest_ieeeAdd(BITJOIN,106)@8
    rndBitCond_uid107_fpAddSubTest_ieeeAdd_q <= LSB_uid106_fpAddSubTest_ieeeAdd_b & Guard_uid105_fpAddSubTest_ieeeAdd_b & Round_uid104_fpAddSubTest_ieeeAdd_b & Sticky1_uid103_fpAddSubTest_ieeeAdd_b & Sticky0_uid102_fpAddSubTest_ieeeAdd_b;

    -- rBi_uid109_fpAddSubTest_ieeeAdd(LOGICAL,108)@8 + 1
    rBi_uid109_fpAddSubTest_ieeeAdd_qi <= "1" WHEN rndBitCond_uid107_fpAddSubTest_ieeeAdd_q = cRBit_uid108_fpAddSubTest_ieeeAdd_q ELSE "0";
    rBi_uid109_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rBi_uid109_fpAddSubTest_ieeeAdd_qi, xout => rBi_uid109_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- roundBit_uid110_fpAddSubTest_ieeeAdd(LOGICAL,109)@9
    roundBit_uid110_fpAddSubTest_ieeeAdd_q <= not (rBi_uid109_fpAddSubTest_ieeeAdd_q);

    -- oneCST_uid99_fpAddSubTest_ieeeAdd(CONSTANT,98)
    oneCST_uid99_fpAddSubTest_ieeeAdd_q <= "00000001";

    -- expInc_uid100_fpAddSubTest_ieeeAdd(ADD,99)@7 + 1
    expInc_uid100_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_6_outputreg_q);
    expInc_uid100_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("0" & oneCST_uid99_fpAddSubTest_ieeeAdd_q);
    expInc_uid100_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expInc_uid100_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expInc_uid100_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(expInc_uid100_fpAddSubTest_ieeeAdd_a) + UNSIGNED(expInc_uid100_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    expInc_uid100_fpAddSubTest_ieeeAdd_q <= expInc_uid100_fpAddSubTest_ieeeAdd_o(8 downto 0);

    -- expPostNorm_uid101_fpAddSubTest_ieeeAdd(SUB,100)@8 + 1
    expPostNorm_uid101_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & expInc_uid100_fpAddSubTest_ieeeAdd_q);
    expPostNorm_uid101_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("00000" & redist1_r_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q);
    expPostNorm_uid101_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expPostNorm_uid101_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expPostNorm_uid101_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(expPostNorm_uid101_fpAddSubTest_ieeeAdd_a) - UNSIGNED(expPostNorm_uid101_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    expPostNorm_uid101_fpAddSubTest_ieeeAdd_q <= expPostNorm_uid101_fpAddSubTest_ieeeAdd_o(9 downto 0);

    -- fracPostNorm_uid98_fpAddSubTest_ieeeAdd(BITSELECT,97)@8
    fracPostNorm_uid98_fpAddSubTest_ieeeAdd_b <= leftShiftStage2_uid258_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(27 downto 1);

    -- fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd(BITSELECT,110)@8
    fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_in <= fracPostNorm_uid98_fpAddSubTest_ieeeAdd_b(25 downto 0);
    fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b <= fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_in(25 downto 2);

    -- redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1(DELAY,275)
    redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b, xout => redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- expFracR_uid112_fpAddSubTest_ieeeAdd(BITJOIN,111)@9
    expFracR_uid112_fpAddSubTest_ieeeAdd_q <= expPostNorm_uid101_fpAddSubTest_ieeeAdd_q & redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1_q;

    -- rndExpFrac_uid113_fpAddSubTest_ieeeAdd(ADD,112)@9 + 1
    rndExpFrac_uid113_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & expFracR_uid112_fpAddSubTest_ieeeAdd_q);
    rndExpFrac_uid113_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000" & roundBit_uid110_fpAddSubTest_ieeeAdd_q);
    rndExpFrac_uid113_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rndExpFrac_uid113_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                rndExpFrac_uid113_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(rndExpFrac_uid113_fpAddSubTest_ieeeAdd_a) + UNSIGNED(rndExpFrac_uid113_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_o(34 downto 0);

    -- expRPreExc_uid126_fpAddSubTest_ieeeAdd(BITSELECT,125)@10
    expRPreExc_uid126_fpAddSubTest_ieeeAdd_in <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(31 downto 0);
    expRPreExc_uid126_fpAddSubTest_ieeeAdd_b <= expRPreExc_uid126_fpAddSubTest_ieeeAdd_in(31 downto 24);

    -- redist8_expRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1(DELAY,273)
    redist8_expRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExc_uid126_fpAddSubTest_ieeeAdd_b, xout => redist8_expRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd(BITSELECT,117)@10
    rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_in <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(33 downto 0);
    rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_b <= rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_in(33 downto 32);

    -- rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd(LOGICAL,118)@10
    rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_q <= "1" WHEN rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_b = zocst_uid85_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- wEP2AllOwE_uid114_fpAddSubTest_ieeeAdd(CONSTANT,113)
    wEP2AllOwE_uid114_fpAddSubTest_ieeeAdd_q <= "0011111111";

    -- rndExp_uid115_fpAddSubTest_ieeeAdd(BITSELECT,114)@10
    rndExp_uid115_fpAddSubTest_ieeeAdd_in <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(33 downto 0);
    rndExp_uid115_fpAddSubTest_ieeeAdd_b <= rndExp_uid115_fpAddSubTest_ieeeAdd_in(33 downto 24);

    -- rOvfEQMax_uid116_fpAddSubTest_ieeeAdd(LOGICAL,115)@10
    rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_q <= "1" WHEN rndExp_uid115_fpAddSubTest_ieeeAdd_b = wEP2AllOwE_uid114_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- rOvf_uid120_fpAddSubTest_ieeeAdd(LOGICAL,119)@10
    rOvf_uid120_fpAddSubTest_ieeeAdd_q <= rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_q or rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_q;

    -- regInputs_uid127_fpAddSubTest_ieeeAdd(LOGICAL,126)@8 + 1
    regInputs_uid127_fpAddSubTest_ieeeAdd_qi <= excR_aSig_uid40_fpAddSubTest_ieeeAdd_q and excR_bSig_uid54_fpAddSubTest_ieeeAdd_q;
    regInputs_uid127_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => regInputs_uid127_fpAddSubTest_ieeeAdd_qi, xout => regInputs_uid127_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist7_regInputs_uid127_fpAddSubTest_ieeeAdd_q_2(DELAY,272)
    redist7_regInputs_uid127_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => regInputs_uid127_fpAddSubTest_ieeeAdd_q, xout => redist7_regInputs_uid127_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- rInfOvf_uid130_fpAddSubTest_ieeeAdd(LOGICAL,129)@10 + 1
    rInfOvf_uid130_fpAddSubTest_ieeeAdd_qi <= redist7_regInputs_uid127_fpAddSubTest_ieeeAdd_q_2_q and rOvf_uid120_fpAddSubTest_ieeeAdd_q;
    rInfOvf_uid130_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rInfOvf_uid130_fpAddSubTest_ieeeAdd_qi, xout => rInfOvf_uid130_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- excRInfVInC_uid131_fpAddSubTest_ieeeAdd(BITJOIN,130)@11
    excRInfVInC_uid131_fpAddSubTest_ieeeAdd_q <= rInfOvf_uid130_fpAddSubTest_ieeeAdd_q & redist21_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_3_q & redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_3_q & redist22_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_3_q & redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_3_q & redist15_effSub_uid61_fpAddSubTest_ieeeAdd_q_8_q;

    -- excRInf_uid132_fpAddSubTest_ieeeAdd(LOOKUP,131)@11
    excRInf_uid132_fpAddSubTest_ieeeAdd_combproc: PROCESS (excRInfVInC_uid131_fpAddSubTest_ieeeAdd_q)
    BEGIN
        -- Begin reserved scope level
        CASE (excRInfVInC_uid131_fpAddSubTest_ieeeAdd_q) IS
            WHEN "000000" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "000001" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "000010" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000011" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000100" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000101" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000110" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000111" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001000" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001001" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001010" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001011" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001100" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001101" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001110" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001111" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010000" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010001" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010010" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010011" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010100" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010101" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010110" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010111" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011000" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011001" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011010" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011011" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011100" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011101" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011110" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011111" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100000" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "100001" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100010" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100011" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100100" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100101" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100110" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100111" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101000" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101001" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101010" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101011" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101100" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101101" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101110" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101111" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110000" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110001" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110010" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110011" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110100" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110101" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110110" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110111" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111000" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111001" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111010" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111011" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111100" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111101" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111110" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111111" => excRInf_uid132_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN OTHERS => -- unreachable
                           excRInf_uid132_fpAddSubTest_ieeeAdd_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2(DELAY,276)
    redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => aMinusA_uid96_fpAddSubTest_ieeeAdd_q, xout => redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- rUdfExtraBit_uid123_fpAddSubTest_ieeeAdd(BITSELECT,122)@10
    rUdfExtraBit_uid123_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(33 downto 0));
    rUdfExtraBit_uid123_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(rUdfExtraBit_uid123_fpAddSubTest_ieeeAdd_in(33 downto 33));

    -- wEP2AllZ_uid121_fpAddSubTest_ieeeAdd(CONSTANT,120)
    wEP2AllZ_uid121_fpAddSubTest_ieeeAdd_q <= "0000000000";

    -- rUdfEQMin_uid122_fpAddSubTest_ieeeAdd(LOGICAL,121)@10
    rUdfEQMin_uid122_fpAddSubTest_ieeeAdd_q <= "1" WHEN rndExp_uid115_fpAddSubTest_ieeeAdd_b = wEP2AllZ_uid121_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- rUdf_uid124_fpAddSubTest_ieeeAdd(LOGICAL,123)@10
    rUdf_uid124_fpAddSubTest_ieeeAdd_q <= rUdfEQMin_uid122_fpAddSubTest_ieeeAdd_q or rUdfExtraBit_uid123_fpAddSubTest_ieeeAdd_b;

    -- redist26_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_9(DELAY,291)
    redist26_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_7_q, xout => redist26_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_9_q, ena => en(0), clk => clk, aclr => areset );

    -- redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_3(DELAY,296)
    redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q, xout => redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- excRZeroVInC_uid128_fpAddSubTest_ieeeAdd(BITJOIN,127)@10
    excRZeroVInC_uid128_fpAddSubTest_ieeeAdd_q <= redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2_q & rUdf_uid124_fpAddSubTest_ieeeAdd_q & redist7_regInputs_uid127_fpAddSubTest_ieeeAdd_q_2_q & redist26_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_9_q & redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_3_q;

    -- excRZero_uid129_fpAddSubTest_ieeeAdd(LOOKUP,128)@10 + 1
    excRZero_uid129_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (excRZeroVInC_uid128_fpAddSubTest_ieeeAdd_q) IS
                    WHEN "00000" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "00001" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "00010" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "00011" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "1";
                    WHEN "00100" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "00101" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "00110" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "00111" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "01000" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "01001" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "01010" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "01011" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "1";
                    WHEN "01100" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "1";
                    WHEN "01101" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "01110" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "01111" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "10000" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "10001" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "10010" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "10011" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "1";
                    WHEN "10100" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "1";
                    WHEN "10101" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "10110" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "10111" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "11000" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "11001" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "11010" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "11011" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "1";
                    WHEN "11100" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "1";
                    WHEN "11101" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "11110" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN "11111" => excRZero_uid129_fpAddSubTest_ieeeAdd_q <= "0";
                    WHEN OTHERS => -- unreachable
                                   excRZero_uid129_fpAddSubTest_ieeeAdd_q <= (others => '-');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- concExc_uid136_fpAddSubTest_ieeeAdd(BITJOIN,135)@11
    concExc_uid136_fpAddSubTest_ieeeAdd_q <= excRNaN_uid135_fpAddSubTest_ieeeAdd_q & excRInf_uid132_fpAddSubTest_ieeeAdd_q & excRZero_uid129_fpAddSubTest_ieeeAdd_q;

    -- excREnc_uid137_fpAddSubTest_ieeeAdd(LOOKUP,136)@11
    excREnc_uid137_fpAddSubTest_ieeeAdd_combproc: PROCESS (concExc_uid136_fpAddSubTest_ieeeAdd_q)
    BEGIN
        -- Begin reserved scope level
        CASE (concExc_uid136_fpAddSubTest_ieeeAdd_q) IS
            WHEN "000" => excREnc_uid137_fpAddSubTest_ieeeAdd_q <= "01";
            WHEN "001" => excREnc_uid137_fpAddSubTest_ieeeAdd_q <= "00";
            WHEN "010" => excREnc_uid137_fpAddSubTest_ieeeAdd_q <= "10";
            WHEN "011" => excREnc_uid137_fpAddSubTest_ieeeAdd_q <= "10";
            WHEN "100" => excREnc_uid137_fpAddSubTest_ieeeAdd_q <= "11";
            WHEN "101" => excREnc_uid137_fpAddSubTest_ieeeAdd_q <= "11";
            WHEN "110" => excREnc_uid137_fpAddSubTest_ieeeAdd_q <= "11";
            WHEN "111" => excREnc_uid137_fpAddSubTest_ieeeAdd_q <= "11";
            WHEN OTHERS => -- unreachable
                           excREnc_uid137_fpAddSubTest_ieeeAdd_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- expRPostExc_uid156_fpAddSubTest_ieeeAdd(MUX,155)@11
    expRPostExc_uid156_fpAddSubTest_ieeeAdd_s <= excREnc_uid137_fpAddSubTest_ieeeAdd_q;
    expRPostExc_uid156_fpAddSubTest_ieeeAdd_combproc: PROCESS (expRPostExc_uid156_fpAddSubTest_ieeeAdd_s, en, cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q, redist8_expRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1_q, cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (expRPostExc_uid156_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => expRPostExc_uid156_fpAddSubTest_ieeeAdd_q <= cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => expRPostExc_uid156_fpAddSubTest_ieeeAdd_q <= redist8_expRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1_q;
            WHEN "10" => expRPostExc_uid156_fpAddSubTest_ieeeAdd_q <= cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => expRPostExc_uid156_fpAddSubTest_ieeeAdd_q <= cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => expRPostExc_uid156_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid149_fpAddSubTest_ieeeAdd(CONSTANT,148)
    oneFracRPostExc2_uid149_fpAddSubTest_ieeeAdd_q <= "00000000000000000000001";

    -- fracRPreExc_uid125_fpAddSubTest_ieeeAdd(BITSELECT,124)@10
    fracRPreExc_uid125_fpAddSubTest_ieeeAdd_in <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(23 downto 0);
    fracRPreExc_uid125_fpAddSubTest_ieeeAdd_b <= fracRPreExc_uid125_fpAddSubTest_ieeeAdd_in(23 downto 1);

    -- redist9_fracRPreExc_uid125_fpAddSubTest_ieeeAdd_b_1(DELAY,274)
    redist9_fracRPreExc_uid125_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPreExc_uid125_fpAddSubTest_ieeeAdd_b, xout => redist9_fracRPreExc_uid125_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- fracRPostExc_uid152_fpAddSubTest_ieeeAdd(MUX,151)@11
    fracRPostExc_uid152_fpAddSubTest_ieeeAdd_s <= excREnc_uid137_fpAddSubTest_ieeeAdd_q;
    fracRPostExc_uid152_fpAddSubTest_ieeeAdd_combproc: PROCESS (fracRPostExc_uid152_fpAddSubTest_ieeeAdd_s, en, cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q, redist9_fracRPreExc_uid125_fpAddSubTest_ieeeAdd_b_1_q, oneFracRPostExc2_uid149_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (fracRPostExc_uid152_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => fracRPostExc_uid152_fpAddSubTest_ieeeAdd_q <= cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => fracRPostExc_uid152_fpAddSubTest_ieeeAdd_q <= redist9_fracRPreExc_uid125_fpAddSubTest_ieeeAdd_b_1_q;
            WHEN "10" => fracRPostExc_uid152_fpAddSubTest_ieeeAdd_q <= cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => fracRPostExc_uid152_fpAddSubTest_ieeeAdd_q <= oneFracRPostExc2_uid149_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => fracRPostExc_uid152_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- R_uid157_fpAddSubTest_ieeeAdd(BITJOIN,156)@11
    R_uid157_fpAddSubTest_ieeeAdd_q <= signRPostExc_uid148_fpAddSubTest_ieeeAdd_q & expRPostExc_uid156_fpAddSubTest_ieeeAdd_q & fracRPostExc_uid152_fpAddSubTest_ieeeAdd_q;

    -- xOut(GPOUT,4)@11
    q <= R_uid157_fpAddSubTest_ieeeAdd_q;

END normal;
