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

-- VHDL created from fp_acc
-- VHDL created on Thu Mar 16 02:38:23 2023


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

entity fp_acc is
    port (
        x : in std_logic_vector(31 downto 0);  -- float32_m23
        n : in std_logic_vector(0 downto 0);  -- ufix1
        en : in std_logic_vector(0 downto 0);  -- ufix1
        r : out std_logic_vector(31 downto 0);  -- float32_m23
        xo : out std_logic_vector(0 downto 0);  -- ufix1
        xu : out std_logic_vector(0 downto 0);  -- ufix1
        ao : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end fp_acc;

architecture normal of fp_acc is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expX_uid6_fpAccTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracX_uid7_fpAccTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signX_uid8_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracX_uid10_fpAccTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expLTLSBA_uid11_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal expGTMaxMSBX_uid13_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rShiftConstant_uid15_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal rightShiftValue_uid16_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftValue_uid16_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftValue_uid16_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftValue_uid16_fpAccTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal padConst_uid17_fpAccTest_q : STD_LOGIC_VECTOR (55 downto 0);
    signal rightPaddedIn_uid18_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal shiftedFracUpper_uid20_fpAccTest_b : STD_LOGIC_VECTOR (55 downto 0);
    signal extendedAlignedShiftedFrac_uid21_fpAccTest_q : STD_LOGIC_VECTOR (56 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_b : STD_LOGIC_VECTOR (56 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_q : STD_LOGIC_VECTOR (56 downto 0);
    signal accumulator_uid24_fpAccTest_a : STD_LOGIC_VECTOR (79 downto 0);
    signal accumulator_uid24_fpAccTest_b : STD_LOGIC_VECTOR (79 downto 0);
    signal accumulator_uid24_fpAccTest_i : STD_LOGIC_VECTOR (79 downto 0);
    signal accumulator_uid24_fpAccTest_o : STD_LOGIC_VECTOR (79 downto 0);
    signal accumulator_uid24_fpAccTest_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_q : STD_LOGIC_VECTOR (77 downto 0);
    signal os_uid25_fpAccTest_q : STD_LOGIC_VECTOR (78 downto 0);
    signal osr_uid26_fpAccTest_in : STD_LOGIC_VECTOR (77 downto 0);
    signal osr_uid26_fpAccTest_b : STD_LOGIC_VECTOR (77 downto 0);
    signal sum_uid27_fpAccTest_in : STD_LOGIC_VECTOR (76 downto 0);
    signal sum_uid27_fpAccTest_b : STD_LOGIC_VECTOR (76 downto 0);
    signal accumulatorSign_uid29_fpAccTest_in : STD_LOGIC_VECTOR (75 downto 0);
    signal accumulatorSign_uid29_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflowBitMSB_uid30_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflow_uid32_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal accValidRange_uid33_fpAccTest_in : STD_LOGIC_VECTOR (75 downto 0);
    signal accValidRange_uid33_fpAccTest_b : STD_LOGIC_VECTOR (75 downto 0);
    signal accOnesComplement_uid34_fpAccTest_b : STD_LOGIC_VECTOR (75 downto 0);
    signal accOnesComplement_uid34_fpAccTest_q : STD_LOGIC_VECTOR (75 downto 0);
    signal accValuePositive_uid35_fpAccTest_a : STD_LOGIC_VECTOR (76 downto 0);
    signal accValuePositive_uid35_fpAccTest_b : STD_LOGIC_VECTOR (76 downto 0);
    signal accValuePositive_uid35_fpAccTest_o : STD_LOGIC_VECTOR (76 downto 0);
    signal accValuePositive_uid35_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_in : STD_LOGIC_VECTOR (74 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_b : STD_LOGIC_VECTOR (74 downto 0);
    signal ShiftedOutComparator_uid38_fpAccTest_q : STD_LOGIC_VECTOR (6 downto 0);
    signal accResOutOfExpRange_uid39_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expRBias_uid41_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal zeroExponent_uid42_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal resExpSub_uid43_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal finalExponent_uid44_fpAccTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal finalExponent_uid44_fpAccTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal finalExpUpdated_uid45_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal finalExpUpdated_uid45_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fracR_uid46_fpAccTest_in : STD_LOGIC_VECTOR (73 downto 0);
    signal fracR_uid46_fpAccTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal R_uid47_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal muxXOverflowFeedbackSignal_uid51_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXOverflowFeedbackSignal_uid51_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXOverflowFlagFeedback_uid52_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXOverflowFlagFeedback_uid52_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid55_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid55_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expNotZero_uid56_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal underflowCond_uid57_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXUnderflowFlagFeedback_uid58_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXUnderflowFlagFeedback_uid58_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid61_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid61_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRAccOverflowFlagFeedback_uid62_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oRAccOverflowFlagFeedback_uid62_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal zs_uid66_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (63 downto 0);
    signal vCount_uid68_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid69_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (52 downto 0);
    signal cStage_uid71_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (63 downto 0);
    signal vStagei_uid73_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid73_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (63 downto 0);
    signal zs_uid74_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vCount_uid76_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid79_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid79_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid80_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid82_zeroCounter_uid37_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid82_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid85_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid85_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid88_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid91_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid91_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid92_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid94_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid98_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid100_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid105_zeroCounter_uid37_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid106_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid107_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (6 downto 0);
    signal wIntCst_uid111_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng32_uid113_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0Idx1_uid115_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage0Idx2Rng64_uid116_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStage0Idx2_uid118_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage0Idx3_uid119_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage1Idx1Rng8_uid122_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (71 downto 0);
    signal rightShiftStage1Idx1_uid124_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage1Idx2Rng16_uid125_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (63 downto 0);
    signal rightShiftStage1Idx2_uid127_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage1Idx3Rng24_uid128_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (55 downto 0);
    signal rightShiftStage1Idx3Pad24_uid129_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal rightShiftStage1Idx3_uid130_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage2Idx1Rng2_uid133_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (77 downto 0);
    signal rightShiftStage2Idx1_uid135_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage2Idx2Rng4_uid136_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (75 downto 0);
    signal rightShiftStage2Idx2_uid138_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage2Idx3Rng6_uid139_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (73 downto 0);
    signal rightShiftStage2Idx3Pad6_uid140_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage2Idx3_uid141_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage3Idx1Rng1_uid144_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (78 downto 0);
    signal rightShiftStage3Idx1_uid146_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal r_uid150_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid150_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (79 downto 0);
    signal leftShiftStage0Idx1Rng32_uid155_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (44 downto 0);
    signal leftShiftStage0Idx1Rng32_uid155_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (44 downto 0);
    signal leftShiftStage0Idx1_uid156_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage0Idx2Rng64_uid158_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (12 downto 0);
    signal leftShiftStage0Idx2Rng64_uid158_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal leftShiftStage0Idx2_uid159_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage0Idx3_uid160_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage1Idx1Rng8_uid164_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (68 downto 0);
    signal leftShiftStage1Idx1Rng8_uid164_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (68 downto 0);
    signal leftShiftStage1Idx1_uid165_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage1Idx2Rng16_uid167_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (60 downto 0);
    signal leftShiftStage1Idx2Rng16_uid167_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (60 downto 0);
    signal leftShiftStage1Idx2_uid168_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage1Idx3Rng24_uid170_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (52 downto 0);
    signal leftShiftStage1Idx3Rng24_uid170_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal leftShiftStage1Idx3_uid171_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage2Idx1Rng2_uid175_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (74 downto 0);
    signal leftShiftStage2Idx1Rng2_uid175_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (74 downto 0);
    signal leftShiftStage2Idx1_uid176_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage2Idx2Rng4_uid178_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (72 downto 0);
    signal leftShiftStage2Idx2Rng4_uid178_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (72 downto 0);
    signal leftShiftStage2Idx2_uid179_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage2Idx3Rng6_uid181_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (70 downto 0);
    signal leftShiftStage2Idx3Rng6_uid181_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (70 downto 0);
    signal leftShiftStage2Idx3_uid182_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage3Idx1Rng1_uid186_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (75 downto 0);
    signal leftShiftStage3Idx1Rng1_uid186_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (75 downto 0);
    signal leftShiftStage3Idx1_uid187_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (76 downto 0);
    signal rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_in : STD_LOGIC_VECTOR (6 downto 0);
    signal rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_e : STD_LOGIC_VECTOR (0 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (63 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (10 downto 0);
    signal rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_e : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist1_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist2_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist3_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist4_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist7_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_vCount_uid82_zeroCounter_uid37_fpAccTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_vCount_uid68_zeroCounter_uid37_fpAccTest_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_accumulatorSign_uid29_fpAccTest_b_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_shiftedFracUpper_uid20_fpAccTest_b_1_q : STD_LOGIC_VECTOR (55 downto 0);
    signal redist17_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_signX_uid8_fpAccTest_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist19_fracX_uid7_fpAccTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist20_xIn_n_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_xIn_n_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_outputreg_q : STD_LOGIC_VECTOR (76 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_mem_reset0 : std_logic;
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_mem_ia : STD_LOGIC_VECTOR (76 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_mem_iq : STD_LOGIC_VECTOR (76 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_mem_q : STD_LOGIC_VECTOR (76 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve : boolean;
    attribute preserve of redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_i : signal is true;
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist14_accValuePositive_uid35_fpAccTest_q_5_sticky_ena_q : signal is true;
    signal redist14_accValuePositive_uid35_fpAccTest_q_5_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- signX_uid8_fpAccTest(BITSELECT,7)@0
    signX_uid8_fpAccTest_b <= STD_LOGIC_VECTOR(x(31 downto 31));

    -- redist18_signX_uid8_fpAccTest_b_2(DELAY,216)
    redist18_signX_uid8_fpAccTest_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => signX_uid8_fpAccTest_b, xout => redist18_signX_uid8_fpAccTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- redist20_xIn_n_2(DELAY,218)
    redist20_xIn_n_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => n, xout => redist20_xIn_n_2_q, ena => en(0), clk => clk, aclr => areset );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- rightShiftStage0Idx3_uid119_alignmentShifter_uid17_fpAccTest(CONSTANT,118)
    rightShiftStage0Idx3_uid119_alignmentShifter_uid17_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage3Idx1Rng1_uid144_alignmentShifter_uid17_fpAccTest(BITSELECT,143)@1
    rightShiftStage3Idx1Rng1_uid144_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_q(79 downto 1);

    -- rightShiftStage3Idx1_uid146_alignmentShifter_uid17_fpAccTest(BITJOIN,145)@1
    rightShiftStage3Idx1_uid146_alignmentShifter_uid17_fpAccTest_q <= GND_q & rightShiftStage3Idx1Rng1_uid144_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage2Idx3Pad6_uid140_alignmentShifter_uid17_fpAccTest(CONSTANT,139)
    rightShiftStage2Idx3Pad6_uid140_alignmentShifter_uid17_fpAccTest_q <= "000000";

    -- rightShiftStage2Idx3Rng6_uid139_alignmentShifter_uid17_fpAccTest(BITSELECT,138)@1
    rightShiftStage2Idx3Rng6_uid139_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q(79 downto 6);

    -- rightShiftStage2Idx3_uid141_alignmentShifter_uid17_fpAccTest(BITJOIN,140)@1
    rightShiftStage2Idx3_uid141_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx3Pad6_uid140_alignmentShifter_uid17_fpAccTest_q & rightShiftStage2Idx3Rng6_uid139_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid92_zeroCounter_uid37_fpAccTest(CONSTANT,91)
    zs_uid92_zeroCounter_uid37_fpAccTest_q <= "0000";

    -- rightShiftStage2Idx2Rng4_uid136_alignmentShifter_uid17_fpAccTest(BITSELECT,135)@1
    rightShiftStage2Idx2Rng4_uid136_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q(79 downto 4);

    -- rightShiftStage2Idx2_uid138_alignmentShifter_uid17_fpAccTest(BITJOIN,137)@1
    rightShiftStage2Idx2_uid138_alignmentShifter_uid17_fpAccTest_q <= zs_uid92_zeroCounter_uid37_fpAccTest_q & rightShiftStage2Idx2Rng4_uid136_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid98_zeroCounter_uid37_fpAccTest(CONSTANT,97)
    zs_uid98_zeroCounter_uid37_fpAccTest_q <= "00";

    -- rightShiftStage2Idx1Rng2_uid133_alignmentShifter_uid17_fpAccTest(BITSELECT,132)@1
    rightShiftStage2Idx1Rng2_uid133_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q(79 downto 2);

    -- rightShiftStage2Idx1_uid135_alignmentShifter_uid17_fpAccTest(BITJOIN,134)@1
    rightShiftStage2Idx1_uid135_alignmentShifter_uid17_fpAccTest_q <= zs_uid98_zeroCounter_uid37_fpAccTest_q & rightShiftStage2Idx1Rng2_uid133_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage1Idx3Pad24_uid129_alignmentShifter_uid17_fpAccTest(CONSTANT,128)
    rightShiftStage1Idx3Pad24_uid129_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000";

    -- rightShiftStage1Idx3Rng24_uid128_alignmentShifter_uid17_fpAccTest(BITSELECT,127)@1
    rightShiftStage1Idx3Rng24_uid128_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q(79 downto 24);

    -- rightShiftStage1Idx3_uid130_alignmentShifter_uid17_fpAccTest(BITJOIN,129)@1
    rightShiftStage1Idx3_uid130_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx3Pad24_uid129_alignmentShifter_uid17_fpAccTest_q & rightShiftStage1Idx3Rng24_uid128_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid80_zeroCounter_uid37_fpAccTest(CONSTANT,79)
    zs_uid80_zeroCounter_uid37_fpAccTest_q <= "0000000000000000";

    -- rightShiftStage1Idx2Rng16_uid125_alignmentShifter_uid17_fpAccTest(BITSELECT,124)@1
    rightShiftStage1Idx2Rng16_uid125_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q(79 downto 16);

    -- rightShiftStage1Idx2_uid127_alignmentShifter_uid17_fpAccTest(BITJOIN,126)@1
    rightShiftStage1Idx2_uid127_alignmentShifter_uid17_fpAccTest_q <= zs_uid80_zeroCounter_uid37_fpAccTest_q & rightShiftStage1Idx2Rng16_uid125_alignmentShifter_uid17_fpAccTest_b;

    -- zeroExponent_uid42_fpAccTest(CONSTANT,41)
    zeroExponent_uid42_fpAccTest_q <= "00000000";

    -- rightShiftStage1Idx1Rng8_uid122_alignmentShifter_uid17_fpAccTest(BITSELECT,121)@1
    rightShiftStage1Idx1Rng8_uid122_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q(79 downto 8);

    -- rightShiftStage1Idx1_uid124_alignmentShifter_uid17_fpAccTest(BITJOIN,123)@1
    rightShiftStage1Idx1_uid124_alignmentShifter_uid17_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q & rightShiftStage1Idx1Rng8_uid122_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid66_zeroCounter_uid37_fpAccTest(CONSTANT,65)
    zs_uid66_zeroCounter_uid37_fpAccTest_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx2Rng64_uid116_alignmentShifter_uid17_fpAccTest(BITSELECT,115)@1
    rightShiftStage0Idx2Rng64_uid116_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(79 downto 64);

    -- rightShiftStage0Idx2_uid118_alignmentShifter_uid17_fpAccTest(BITJOIN,117)@1
    rightShiftStage0Idx2_uid118_alignmentShifter_uid17_fpAccTest_q <= zs_uid66_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx2Rng64_uid116_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid74_zeroCounter_uid37_fpAccTest(CONSTANT,73)
    zs_uid74_zeroCounter_uid37_fpAccTest_q <= "00000000000000000000000000000000";

    -- rightShiftStage0Idx1Rng32_uid113_alignmentShifter_uid17_fpAccTest(BITSELECT,112)@1
    rightShiftStage0Idx1Rng32_uid113_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(79 downto 32);

    -- rightShiftStage0Idx1_uid115_alignmentShifter_uid17_fpAccTest(BITJOIN,114)@1
    rightShiftStage0Idx1_uid115_alignmentShifter_uid17_fpAccTest_q <= zs_uid74_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx1Rng32_uid113_alignmentShifter_uid17_fpAccTest_b;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- fracX_uid7_fpAccTest(BITSELECT,6)@0
    fracX_uid7_fpAccTest_b <= x(22 downto 0);

    -- redist19_fracX_uid7_fpAccTest_b_1(DELAY,217)
    redist19_fracX_uid7_fpAccTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracX_uid7_fpAccTest_b, xout => redist19_fracX_uid7_fpAccTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- oFracX_uid10_fpAccTest(BITJOIN,9)@1
    oFracX_uid10_fpAccTest_q <= VCC_q & redist19_fracX_uid7_fpAccTest_b_1_q;

    -- padConst_uid17_fpAccTest(CONSTANT,16)
    padConst_uid17_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000";

    -- rightPaddedIn_uid18_fpAccTest(BITJOIN,17)@1
    rightPaddedIn_uid18_fpAccTest_q <= oFracX_uid10_fpAccTest_q & padConst_uid17_fpAccTest_q;

    -- expX_uid6_fpAccTest(BITSELECT,5)@0
    expX_uid6_fpAccTest_b <= x(30 downto 23);

    -- rShiftConstant_uid15_fpAccTest(CONSTANT,14)
    rShiftConstant_uid15_fpAccTest_q <= "010001111";

    -- rightShiftValue_uid16_fpAccTest(SUB,15)@0
    rightShiftValue_uid16_fpAccTest_a <= STD_LOGIC_VECTOR("0" & rShiftConstant_uid15_fpAccTest_q);
    rightShiftValue_uid16_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    rightShiftValue_uid16_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(rightShiftValue_uid16_fpAccTest_a) - UNSIGNED(rightShiftValue_uid16_fpAccTest_b));
    rightShiftValue_uid16_fpAccTest_q <= rightShiftValue_uid16_fpAccTest_o(9 downto 0);

    -- rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select(BITSELECT,190)@0
    rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_in <= rightShiftValue_uid16_fpAccTest_q(6 downto 0);
    rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_b <= rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(6 downto 5);
    rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_c <= rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(4 downto 3);
    rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_d <= rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(2 downto 1);
    rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_e <= rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(0 downto 0);

    -- redist2_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1(DELAY,200)
    redist2_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_b, xout => redist2_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest(MUX,120)@1
    rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_s <= redist2_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1_q;
    rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_s, en, rightPaddedIn_uid18_fpAccTest_q, rightShiftStage0Idx1_uid115_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx2_uid118_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx3_uid119_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q <= rightPaddedIn_uid18_fpAccTest_q;
            WHEN "01" => rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx1_uid115_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx2_uid118_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx3_uid119_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist3_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1(DELAY,201)
    redist3_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_c, xout => redist3_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest(MUX,131)@1
    rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_s <= redist3_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1_q;
    rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx1_uid124_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx2_uid127_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx3_uid130_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0_uid121_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx1_uid124_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx2_uid127_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx3_uid130_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist4_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1(DELAY,202)
    redist4_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_d, xout => redist4_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest(MUX,142)@1
    rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_s <= redist4_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1_q;
    rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx1_uid135_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx2_uid138_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx3_uid141_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1_uid132_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx1_uid135_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx2_uid138_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx3_uid141_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist5_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1(DELAY,203)
    redist5_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_e, xout => redist5_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest(MUX,147)@1
    rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_s <= redist5_rightShiftStageSel6Dto5_uid120_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1_q;
    rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_q, rightShiftStage3Idx1_uid146_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "0" => rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2_uid143_alignmentShifter_uid17_fpAccTest_q;
            WHEN "1" => rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx1_uid146_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- wIntCst_uid111_alignmentShifter_uid17_fpAccTest(CONSTANT,110)
    wIntCst_uid111_alignmentShifter_uid17_fpAccTest_q <= "1010000";

    -- shiftedOut_uid112_alignmentShifter_uid17_fpAccTest(COMPARE,111)@0 + 1
    shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_a <= STD_LOGIC_VECTOR("00" & rightShiftValue_uid16_fpAccTest_q);
    shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_b <= STD_LOGIC_VECTOR("00000" & wIntCst_uid111_alignmentShifter_uid17_fpAccTest_q);
    shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_a) - UNSIGNED(shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_b));
            END IF;
        END IF;
    END PROCESS;
    shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_n(0) <= not (shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_o(11));

    -- r_uid150_alignmentShifter_uid17_fpAccTest(MUX,149)@1
    r_uid150_alignmentShifter_uid17_fpAccTest_s <= shiftedOut_uid112_alignmentShifter_uid17_fpAccTest_n;
    r_uid150_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (r_uid150_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx3_uid119_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (r_uid150_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "0" => r_uid150_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3_uid148_alignmentShifter_uid17_fpAccTest_q;
            WHEN "1" => r_uid150_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx3_uid119_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => r_uid150_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- shiftedFracUpper_uid20_fpAccTest(BITSELECT,19)@1
    shiftedFracUpper_uid20_fpAccTest_b <= r_uid150_alignmentShifter_uid17_fpAccTest_q(79 downto 24);

    -- redist16_shiftedFracUpper_uid20_fpAccTest_b_1(DELAY,214)
    redist16_shiftedFracUpper_uid20_fpAccTest_b_1 : dspba_delay
    GENERIC MAP ( width => 56, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => shiftedFracUpper_uid20_fpAccTest_b, xout => redist16_shiftedFracUpper_uid20_fpAccTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- extendedAlignedShiftedFrac_uid21_fpAccTest(BITJOIN,20)@2
    extendedAlignedShiftedFrac_uid21_fpAccTest_q <= GND_q & redist16_shiftedFracUpper_uid20_fpAccTest_b_1_q;

    -- onesComplementExtendedFrac_uid22_fpAccTest(LOGICAL,21)@2
    onesComplementExtendedFrac_uid22_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((56 downto 1 => redist18_signX_uid8_fpAccTest_b_2_q(0)) & redist18_signX_uid8_fpAccTest_b_2_q));
    onesComplementExtendedFrac_uid22_fpAccTest_q <= extendedAlignedShiftedFrac_uid21_fpAccTest_q xor onesComplementExtendedFrac_uid22_fpAccTest_b;

    -- accumulator_uid24_fpAccTest(ADD,23)@2 + 1
    accumulator_uid24_fpAccTest_cin <= redist18_signX_uid8_fpAccTest_b_2_q;
    accumulator_uid24_fpAccTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((78 downto 77 => sum_uid27_fpAccTest_b(76)) & sum_uid27_fpAccTest_b) & '1');
    accumulator_uid24_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((78 downto 57 => onesComplementExtendedFrac_uid22_fpAccTest_q(56)) & onesComplementExtendedFrac_uid22_fpAccTest_q) & accumulator_uid24_fpAccTest_cin(0));
    accumulator_uid24_fpAccTest_i <= accumulator_uid24_fpAccTest_b;
    accumulator_uid24_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accumulator_uid24_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (redist20_xIn_n_2_q = "1") THEN
                    accumulator_uid24_fpAccTest_o <= accumulator_uid24_fpAccTest_i;
                ELSE
                    accumulator_uid24_fpAccTest_o <= STD_LOGIC_VECTOR(SIGNED(accumulator_uid24_fpAccTest_a) + SIGNED(accumulator_uid24_fpAccTest_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    accumulator_uid24_fpAccTest_c(0) <= accumulator_uid24_fpAccTest_o(79);
    accumulator_uid24_fpAccTest_q <= accumulator_uid24_fpAccTest_o(78 downto 1);

    -- os_uid25_fpAccTest(BITJOIN,24)@3
    os_uid25_fpAccTest_q <= accumulator_uid24_fpAccTest_c & accumulator_uid24_fpAccTest_q;

    -- osr_uid26_fpAccTest(BITSELECT,25)@3
    osr_uid26_fpAccTest_in <= STD_LOGIC_VECTOR(os_uid25_fpAccTest_q(77 downto 0));
    osr_uid26_fpAccTest_b <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_in(77 downto 0));

    -- sum_uid27_fpAccTest(BITSELECT,26)@3
    sum_uid27_fpAccTest_in <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_b(76 downto 0));
    sum_uid27_fpAccTest_b <= STD_LOGIC_VECTOR(sum_uid27_fpAccTest_in(76 downto 0));

    -- accumulatorSign_uid29_fpAccTest(BITSELECT,28)@3
    accumulatorSign_uid29_fpAccTest_in <= sum_uid27_fpAccTest_b(75 downto 0);
    accumulatorSign_uid29_fpAccTest_b <= accumulatorSign_uid29_fpAccTest_in(75 downto 75);

    -- accOverflowBitMSB_uid30_fpAccTest(BITSELECT,29)@3
    accOverflowBitMSB_uid30_fpAccTest_b <= sum_uid27_fpAccTest_b(76 downto 76);

    -- accOverflow_uid32_fpAccTest(LOGICAL,31)@3
    accOverflow_uid32_fpAccTest_q <= accOverflowBitMSB_uid30_fpAccTest_b xor accumulatorSign_uid29_fpAccTest_b;

    -- redist21_xIn_n_3(DELAY,219)
    redist21_xIn_n_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist20_xIn_n_2_q, xout => redist21_xIn_n_3_q, ena => en(0), clk => clk, aclr => areset );

    -- muxAccOverflowFeedbackSignal_uid61_fpAccTest(MUX,60)@3
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_s <= redist21_xIn_n_3_q;
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_combproc: PROCESS (muxAccOverflowFeedbackSignal_uid61_fpAccTest_s, en, oRAccOverflowFlagFeedback_uid62_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxAccOverflowFeedbackSignal_uid61_fpAccTest_s) IS
            WHEN "0" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= oRAccOverflowFlagFeedback_uid62_fpAccTest_q;
            WHEN "1" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRAccOverflowFlagFeedback_uid62_fpAccTest(LOGICAL,61)@3 + 1
    oRAccOverflowFlagFeedback_uid62_fpAccTest_qi <= muxAccOverflowFeedbackSignal_uid61_fpAccTest_q or accOverflow_uid32_fpAccTest_q;
    oRAccOverflowFlagFeedback_uid62_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRAccOverflowFlagFeedback_uid62_fpAccTest_qi, xout => oRAccOverflowFlagFeedback_uid62_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist11_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_5(DELAY,209)
    redist11_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRAccOverflowFlagFeedback_uid62_fpAccTest_q, xout => redist11_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_5_q, ena => en(0), clk => clk, aclr => areset );

    -- expNotZero_uid56_fpAccTest(LOGICAL,55)@0
    expNotZero_uid56_fpAccTest_q <= "1" WHEN expX_uid6_fpAccTest_b /= "00000000" ELSE "0";

    -- expLTLSBA_uid11_fpAccTest(CONSTANT,10)
    expLTLSBA_uid11_fpAccTest_q <= "01010111";

    -- cmpLT_expX_expLTLSBA_uid12_fpAccTest(COMPARE,11)@0
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_a <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expLTLSBA_uid11_fpAccTest_q);
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpLT_expX_expLTLSBA_uid12_fpAccTest_a) - UNSIGNED(cmpLT_expX_expLTLSBA_uid12_fpAccTest_b));
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_c(0) <= cmpLT_expX_expLTLSBA_uid12_fpAccTest_o(9);

    -- underflowCond_uid57_fpAccTest(LOGICAL,56)@0
    underflowCond_uid57_fpAccTest_q <= cmpLT_expX_expLTLSBA_uid12_fpAccTest_c and expNotZero_uid56_fpAccTest_q;

    -- muxXUnderflowFeedbackSignal_uid55_fpAccTest(MUX,54)@0
    muxXUnderflowFeedbackSignal_uid55_fpAccTest_s <= n;
    muxXUnderflowFeedbackSignal_uid55_fpAccTest_combproc: PROCESS (muxXUnderflowFeedbackSignal_uid55_fpAccTest_s, en, oRXUnderflowFlagFeedback_uid58_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxXUnderflowFeedbackSignal_uid55_fpAccTest_s) IS
            WHEN "0" => muxXUnderflowFeedbackSignal_uid55_fpAccTest_q <= oRXUnderflowFlagFeedback_uid58_fpAccTest_q;
            WHEN "1" => muxXUnderflowFeedbackSignal_uid55_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxXUnderflowFeedbackSignal_uid55_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRXUnderflowFlagFeedback_uid58_fpAccTest(LOGICAL,57)@0 + 1
    oRXUnderflowFlagFeedback_uid58_fpAccTest_qi <= muxXUnderflowFeedbackSignal_uid55_fpAccTest_q or underflowCond_uid57_fpAccTest_q;
    oRXUnderflowFlagFeedback_uid58_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXUnderflowFlagFeedback_uid58_fpAccTest_qi, xout => oRXUnderflowFlagFeedback_uid58_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist12_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_8(DELAY,210)
    redist12_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXUnderflowFlagFeedback_uid58_fpAccTest_q, xout => redist12_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_8_q, ena => en(0), clk => clk, aclr => areset );

    -- expGTMaxMSBX_uid13_fpAccTest(CONSTANT,12)
    expGTMaxMSBX_uid13_fpAccTest_q <= "10001111";

    -- cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest(COMPARE,13)@0 + 1
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_a <= STD_LOGIC_VECTOR("00" & expGTMaxMSBX_uid13_fpAccTest_q);
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_a) - UNSIGNED(cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_b));
            END IF;
        END IF;
    END PROCESS;
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c(0) <= cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o(9);

    -- redist17_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_3(DELAY,215)
    redist17_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c, xout => redist17_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_3_q, ena => en(0), clk => clk, aclr => areset );

    -- muxXOverflowFeedbackSignal_uid51_fpAccTest(MUX,50)@3
    muxXOverflowFeedbackSignal_uid51_fpAccTest_s <= redist21_xIn_n_3_q;
    muxXOverflowFeedbackSignal_uid51_fpAccTest_combproc: PROCESS (muxXOverflowFeedbackSignal_uid51_fpAccTest_s, en, oRXOverflowFlagFeedback_uid52_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxXOverflowFeedbackSignal_uid51_fpAccTest_s) IS
            WHEN "0" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= oRXOverflowFlagFeedback_uid52_fpAccTest_q;
            WHEN "1" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRXOverflowFlagFeedback_uid52_fpAccTest(LOGICAL,51)@3 + 1
    oRXOverflowFlagFeedback_uid52_fpAccTest_qi <= muxXOverflowFeedbackSignal_uid51_fpAccTest_q or redist17_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_3_q;
    oRXOverflowFlagFeedback_uid52_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_qi, xout => oRXOverflowFlagFeedback_uid52_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist13_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5(DELAY,211)
    redist13_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_q, xout => redist13_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5_q, ena => en(0), clk => clk, aclr => areset );

    -- redist15_accumulatorSign_uid29_fpAccTest_b_5(DELAY,213)
    redist15_accumulatorSign_uid29_fpAccTest_b_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => accumulatorSign_uid29_fpAccTest_b, xout => redist15_accumulatorSign_uid29_fpAccTest_b_5_q, ena => en(0), clk => clk, aclr => areset );

    -- accValidRange_uid33_fpAccTest(BITSELECT,32)@3
    accValidRange_uid33_fpAccTest_in <= sum_uid27_fpAccTest_b(75 downto 0);
    accValidRange_uid33_fpAccTest_b <= accValidRange_uid33_fpAccTest_in(75 downto 0);

    -- accOnesComplement_uid34_fpAccTest(LOGICAL,33)@3
    accOnesComplement_uid34_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((75 downto 1 => accumulatorSign_uid29_fpAccTest_b(0)) & accumulatorSign_uid29_fpAccTest_b));
    accOnesComplement_uid34_fpAccTest_q <= accValidRange_uid33_fpAccTest_b xor accOnesComplement_uid34_fpAccTest_b;

    -- accValuePositive_uid35_fpAccTest(ADD,34)@3 + 1
    accValuePositive_uid35_fpAccTest_a <= STD_LOGIC_VECTOR("0" & accOnesComplement_uid34_fpAccTest_q);
    accValuePositive_uid35_fpAccTest_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000000000000000000000000000000000000000000000" & accumulatorSign_uid29_fpAccTest_b);
    accValuePositive_uid35_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accValuePositive_uid35_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                accValuePositive_uid35_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(accValuePositive_uid35_fpAccTest_a) + UNSIGNED(accValuePositive_uid35_fpAccTest_b));
            END IF;
        END IF;
    END PROCESS;
    accValuePositive_uid35_fpAccTest_q <= accValuePositive_uid35_fpAccTest_o(76 downto 0);

    -- posAccWoLeadingZeroBit_uid36_fpAccTest(BITSELECT,35)@4
    posAccWoLeadingZeroBit_uid36_fpAccTest_in <= accValuePositive_uid35_fpAccTest_q(74 downto 0);
    posAccWoLeadingZeroBit_uid36_fpAccTest_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_in(74 downto 0);

    -- rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,191)@4
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(74 downto 11);
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(10 downto 0);

    -- vCount_uid68_zeroCounter_uid37_fpAccTest(LOGICAL,67)@4
    vCount_uid68_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid66_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist10_vCount_uid68_zeroCounter_uid37_fpAccTest_q_3(DELAY,208)
    redist10_vCount_uid68_zeroCounter_uid37_fpAccTest_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid68_zeroCounter_uid37_fpAccTest_q, xout => redist10_vCount_uid68_zeroCounter_uid37_fpAccTest_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- mO_uid69_zeroCounter_uid37_fpAccTest(CONSTANT,68)
    mO_uid69_zeroCounter_uid37_fpAccTest_q <= "11111111111111111111111111111111111111111111111111111";

    -- cStage_uid71_zeroCounter_uid37_fpAccTest(BITJOIN,70)@4
    cStage_uid71_zeroCounter_uid37_fpAccTest_q <= rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c & mO_uid69_zeroCounter_uid37_fpAccTest_q;

    -- vStagei_uid73_zeroCounter_uid37_fpAccTest(MUX,72)@4 + 1
    vStagei_uid73_zeroCounter_uid37_fpAccTest_s <= vCount_uid68_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid73_zeroCounter_uid37_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (vStagei_uid73_zeroCounter_uid37_fpAccTest_s) IS
                    WHEN "0" => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
                    WHEN "1" => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= cStage_uid71_zeroCounter_uid37_fpAccTest_q;
                    WHEN OTHERS => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,192)@5
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(63 downto 32);
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(31 downto 0);

    -- vCount_uid76_zeroCounter_uid37_fpAccTest(LOGICAL,75)@5
    vCount_uid76_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid74_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist9_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2(DELAY,207)
    redist9_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid76_zeroCounter_uid37_fpAccTest_q, xout => redist9_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid79_zeroCounter_uid37_fpAccTest(MUX,78)@5
    vStagei_uid79_zeroCounter_uid37_fpAccTest_s <= vCount_uid76_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid79_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid79_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid79_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,193)@5
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(31 downto 16);
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(15 downto 0);

    -- vCount_uid82_zeroCounter_uid37_fpAccTest(LOGICAL,81)@5 + 1
    vCount_uid82_zeroCounter_uid37_fpAccTest_qi <= "1" WHEN rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid80_zeroCounter_uid37_fpAccTest_q ELSE "0";
    vCount_uid82_zeroCounter_uid37_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid82_zeroCounter_uid37_fpAccTest_qi, xout => vCount_uid82_zeroCounter_uid37_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist8_vCount_uid82_zeroCounter_uid37_fpAccTest_q_2(DELAY,206)
    redist8_vCount_uid82_zeroCounter_uid37_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid82_zeroCounter_uid37_fpAccTest_q, xout => redist8_vCount_uid82_zeroCounter_uid37_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- redist1_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1(DELAY,199)
    redist1_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c, xout => redist1_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => areset );

    -- redist0_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1(DELAY,198)
    redist0_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b, xout => redist0_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid85_zeroCounter_uid37_fpAccTest(MUX,84)@6
    vStagei_uid85_zeroCounter_uid37_fpAccTest_s <= vCount_uid82_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid85_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid85_zeroCounter_uid37_fpAccTest_s, en, redist0_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q, redist1_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q)
    BEGIN
        CASE (vStagei_uid85_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= redist0_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q;
            WHEN "1" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= redist1_rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q;
            WHEN OTHERS => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,194)@6
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(15 downto 8);
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(7 downto 0);

    -- vCount_uid88_zeroCounter_uid37_fpAccTest(LOGICAL,87)@6
    vCount_uid88_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zeroExponent_uid42_fpAccTest_q ELSE "0";

    -- redist7_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1(DELAY,205)
    redist7_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid88_zeroCounter_uid37_fpAccTest_q, xout => redist7_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid91_zeroCounter_uid37_fpAccTest(MUX,90)@6 + 1
    vStagei_uid91_zeroCounter_uid37_fpAccTest_s <= vCount_uid88_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid91_zeroCounter_uid37_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (vStagei_uid91_zeroCounter_uid37_fpAccTest_s) IS
                    WHEN "0" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
                    WHEN "1" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
                    WHEN OTHERS => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,195)@7
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(7 downto 4);
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(3 downto 0);

    -- vCount_uid94_zeroCounter_uid37_fpAccTest(LOGICAL,93)@7
    vCount_uid94_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid92_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid97_zeroCounter_uid37_fpAccTest(MUX,96)@7
    vStagei_uid97_zeroCounter_uid37_fpAccTest_s <= vCount_uid94_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid97_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid97_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid97_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,196)@7
    rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid97_zeroCounter_uid37_fpAccTest_q(3 downto 2);
    rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid97_zeroCounter_uid37_fpAccTest_q(1 downto 0);

    -- vCount_uid100_zeroCounter_uid37_fpAccTest(LOGICAL,99)@7
    vCount_uid100_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid98_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid103_zeroCounter_uid37_fpAccTest(MUX,102)@7
    vStagei_uid103_zeroCounter_uid37_fpAccTest_s <= vCount_uid100_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid103_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid103_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid103_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid105_zeroCounter_uid37_fpAccTest(BITSELECT,104)@7
    rVStage_uid105_zeroCounter_uid37_fpAccTest_b <= vStagei_uid103_zeroCounter_uid37_fpAccTest_q(1 downto 1);

    -- vCount_uid106_zeroCounter_uid37_fpAccTest(LOGICAL,105)@7
    vCount_uid106_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid105_zeroCounter_uid37_fpAccTest_b = GND_q ELSE "0";

    -- r_uid107_zeroCounter_uid37_fpAccTest(BITJOIN,106)@7
    r_uid107_zeroCounter_uid37_fpAccTest_q <= redist10_vCount_uid68_zeroCounter_uid37_fpAccTest_q_3_q & redist9_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2_q & redist8_vCount_uid82_zeroCounter_uid37_fpAccTest_q_2_q & redist7_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q & vCount_uid94_zeroCounter_uid37_fpAccTest_q & vCount_uid100_zeroCounter_uid37_fpAccTest_q & vCount_uid106_zeroCounter_uid37_fpAccTest_q;

    -- redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1(DELAY,204)
    redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 7, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => r_uid107_zeroCounter_uid37_fpAccTest_q, xout => redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- expRBias_uid41_fpAccTest(CONSTANT,40)
    expRBias_uid41_fpAccTest_q <= "010100010";

    -- resExpSub_uid43_fpAccTest(SUB,42)@8
    resExpSub_uid43_fpAccTest_a <= STD_LOGIC_VECTOR("0" & expRBias_uid41_fpAccTest_q);
    resExpSub_uid43_fpAccTest_b <= STD_LOGIC_VECTOR("000" & redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1_q);
    resExpSub_uid43_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(resExpSub_uid43_fpAccTest_a) - UNSIGNED(resExpSub_uid43_fpAccTest_b));
    resExpSub_uid43_fpAccTest_q <= resExpSub_uid43_fpAccTest_o(9 downto 0);

    -- finalExponent_uid44_fpAccTest(BITSELECT,43)@8
    finalExponent_uid44_fpAccTest_in <= resExpSub_uid43_fpAccTest_q(7 downto 0);
    finalExponent_uid44_fpAccTest_b <= finalExponent_uid44_fpAccTest_in(7 downto 0);

    -- ShiftedOutComparator_uid38_fpAccTest(CONSTANT,37)
    ShiftedOutComparator_uid38_fpAccTest_q <= "1001011";

    -- accResOutOfExpRange_uid39_fpAccTest(LOGICAL,38)@8
    accResOutOfExpRange_uid39_fpAccTest_q <= "1" WHEN ShiftedOutComparator_uid38_fpAccTest_q = redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1_q ELSE "0";

    -- finalExpUpdated_uid45_fpAccTest(MUX,44)@8
    finalExpUpdated_uid45_fpAccTest_s <= accResOutOfExpRange_uid39_fpAccTest_q;
    finalExpUpdated_uid45_fpAccTest_combproc: PROCESS (finalExpUpdated_uid45_fpAccTest_s, en, finalExponent_uid44_fpAccTest_b, zeroExponent_uid42_fpAccTest_q)
    BEGIN
        CASE (finalExpUpdated_uid45_fpAccTest_s) IS
            WHEN "0" => finalExpUpdated_uid45_fpAccTest_q <= finalExponent_uid44_fpAccTest_b;
            WHEN "1" => finalExpUpdated_uid45_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q;
            WHEN OTHERS => finalExpUpdated_uid45_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage3Idx1Rng1_uid186_normalizationShifter_uid40_fpAccTest(BITSELECT,185)@8
    leftShiftStage3Idx1Rng1_uid186_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_q(75 downto 0);
    leftShiftStage3Idx1Rng1_uid186_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx1Rng1_uid186_normalizationShifter_uid40_fpAccTest_in(75 downto 0);

    -- leftShiftStage3Idx1_uid187_normalizationShifter_uid40_fpAccTest(BITJOIN,186)@8
    leftShiftStage3Idx1_uid187_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx1Rng1_uid186_normalizationShifter_uid40_fpAccTest_b & GND_q;

    -- leftShiftStage2Idx3Rng6_uid181_normalizationShifter_uid40_fpAccTest(BITSELECT,180)@8
    leftShiftStage2Idx3Rng6_uid181_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q(70 downto 0);
    leftShiftStage2Idx3Rng6_uid181_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx3Rng6_uid181_normalizationShifter_uid40_fpAccTest_in(70 downto 0);

    -- leftShiftStage2Idx3_uid182_normalizationShifter_uid40_fpAccTest(BITJOIN,181)@8
    leftShiftStage2Idx3_uid182_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx3Rng6_uid181_normalizationShifter_uid40_fpAccTest_b & rightShiftStage2Idx3Pad6_uid140_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage2Idx2Rng4_uid178_normalizationShifter_uid40_fpAccTest(BITSELECT,177)@8
    leftShiftStage2Idx2Rng4_uid178_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q(72 downto 0);
    leftShiftStage2Idx2Rng4_uid178_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx2Rng4_uid178_normalizationShifter_uid40_fpAccTest_in(72 downto 0);

    -- leftShiftStage2Idx2_uid179_normalizationShifter_uid40_fpAccTest(BITJOIN,178)@8
    leftShiftStage2Idx2_uid179_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx2Rng4_uid178_normalizationShifter_uid40_fpAccTest_b & zs_uid92_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage2Idx1Rng2_uid175_normalizationShifter_uid40_fpAccTest(BITSELECT,174)@8
    leftShiftStage2Idx1Rng2_uid175_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q(74 downto 0);
    leftShiftStage2Idx1Rng2_uid175_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx1Rng2_uid175_normalizationShifter_uid40_fpAccTest_in(74 downto 0);

    -- leftShiftStage2Idx1_uid176_normalizationShifter_uid40_fpAccTest(BITJOIN,175)@8
    leftShiftStage2Idx1_uid176_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx1Rng2_uid175_normalizationShifter_uid40_fpAccTest_b & zs_uid98_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage1Idx3Rng24_uid170_normalizationShifter_uid40_fpAccTest(BITSELECT,169)@8
    leftShiftStage1Idx3Rng24_uid170_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q(52 downto 0);
    leftShiftStage1Idx3Rng24_uid170_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx3Rng24_uid170_normalizationShifter_uid40_fpAccTest_in(52 downto 0);

    -- leftShiftStage1Idx3_uid171_normalizationShifter_uid40_fpAccTest(BITJOIN,170)@8
    leftShiftStage1Idx3_uid171_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx3Rng24_uid170_normalizationShifter_uid40_fpAccTest_b & rightShiftStage1Idx3Pad24_uid129_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage1Idx2Rng16_uid167_normalizationShifter_uid40_fpAccTest(BITSELECT,166)@8
    leftShiftStage1Idx2Rng16_uid167_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q(60 downto 0);
    leftShiftStage1Idx2Rng16_uid167_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx2Rng16_uid167_normalizationShifter_uid40_fpAccTest_in(60 downto 0);

    -- leftShiftStage1Idx2_uid168_normalizationShifter_uid40_fpAccTest(BITJOIN,167)@8
    leftShiftStage1Idx2_uid168_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx2Rng16_uid167_normalizationShifter_uid40_fpAccTest_b & zs_uid80_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage1Idx1Rng8_uid164_normalizationShifter_uid40_fpAccTest(BITSELECT,163)@8
    leftShiftStage1Idx1Rng8_uid164_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q(68 downto 0);
    leftShiftStage1Idx1Rng8_uid164_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx1Rng8_uid164_normalizationShifter_uid40_fpAccTest_in(68 downto 0);

    -- leftShiftStage1Idx1_uid165_normalizationShifter_uid40_fpAccTest(BITJOIN,164)@8
    leftShiftStage1Idx1_uid165_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx1Rng8_uid164_normalizationShifter_uid40_fpAccTest_b & zeroExponent_uid42_fpAccTest_q;

    -- leftShiftStage0Idx3_uid160_normalizationShifter_uid40_fpAccTest(CONSTANT,159)
    leftShiftStage0Idx3_uid160_normalizationShifter_uid40_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- leftShiftStage0Idx2Rng64_uid158_normalizationShifter_uid40_fpAccTest(BITSELECT,157)@8
    leftShiftStage0Idx2Rng64_uid158_normalizationShifter_uid40_fpAccTest_in <= redist14_accValuePositive_uid35_fpAccTest_q_5_outputreg_q(12 downto 0);
    leftShiftStage0Idx2Rng64_uid158_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx2Rng64_uid158_normalizationShifter_uid40_fpAccTest_in(12 downto 0);

    -- leftShiftStage0Idx2_uid159_normalizationShifter_uid40_fpAccTest(BITJOIN,158)@8
    leftShiftStage0Idx2_uid159_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx2Rng64_uid158_normalizationShifter_uid40_fpAccTest_b & zs_uid66_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage0Idx1Rng32_uid155_normalizationShifter_uid40_fpAccTest(BITSELECT,154)@8
    leftShiftStage0Idx1Rng32_uid155_normalizationShifter_uid40_fpAccTest_in <= redist14_accValuePositive_uid35_fpAccTest_q_5_outputreg_q(44 downto 0);
    leftShiftStage0Idx1Rng32_uid155_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx1Rng32_uid155_normalizationShifter_uid40_fpAccTest_in(44 downto 0);

    -- leftShiftStage0Idx1_uid156_normalizationShifter_uid40_fpAccTest(BITJOIN,155)@8
    leftShiftStage0Idx1_uid156_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx1Rng32_uid155_normalizationShifter_uid40_fpAccTest_b & zs_uid74_zeroCounter_uid37_fpAccTest_q;

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_notEnable(LOGICAL,226)
    redist14_accValuePositive_uid35_fpAccTest_q_5_notEnable_q <= STD_LOGIC_VECTOR(not (en));

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_nor(LOGICAL,227)
    redist14_accValuePositive_uid35_fpAccTest_q_5_nor_q <= not (redist14_accValuePositive_uid35_fpAccTest_q_5_notEnable_q or redist14_accValuePositive_uid35_fpAccTest_q_5_sticky_ena_q);

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_cmpReg(REG,225)
    redist14_accValuePositive_uid35_fpAccTest_q_5_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_accValuePositive_uid35_fpAccTest_q_5_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist14_accValuePositive_uid35_fpAccTest_q_5_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_sticky_ena(REG,228)
    redist14_accValuePositive_uid35_fpAccTest_q_5_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_accValuePositive_uid35_fpAccTest_q_5_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist14_accValuePositive_uid35_fpAccTest_q_5_nor_q = "1") THEN
                redist14_accValuePositive_uid35_fpAccTest_q_5_sticky_ena_q <= STD_LOGIC_VECTOR(redist14_accValuePositive_uid35_fpAccTest_q_5_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_enaAnd(LOGICAL,229)
    redist14_accValuePositive_uid35_fpAccTest_q_5_enaAnd_q <= redist14_accValuePositive_uid35_fpAccTest_q_5_sticky_ena_q and en;

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt(COUNTER,222)
    -- low=0, high=1, step=1, init=0
    redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_i <= redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_i, 1)));

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux(MUX,223)
    redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_s <= en;
    redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_combproc: PROCESS (redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_s, redist14_accValuePositive_uid35_fpAccTest_q_5_wraddr_q, redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_q)
    BEGIN
        CASE (redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_s) IS
            WHEN "0" => redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_q <= redist14_accValuePositive_uid35_fpAccTest_q_5_wraddr_q;
            WHEN "1" => redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_q <= redist14_accValuePositive_uid35_fpAccTest_q_5_rdcnt_q;
            WHEN OTHERS => redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_wraddr(REG,224)
    redist14_accValuePositive_uid35_fpAccTest_q_5_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            redist14_accValuePositive_uid35_fpAccTest_q_5_wraddr_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist14_accValuePositive_uid35_fpAccTest_q_5_wraddr_q <= STD_LOGIC_VECTOR(redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_q);
        END IF;
    END PROCESS;

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_mem(DUALMEM,221)
    redist14_accValuePositive_uid35_fpAccTest_q_5_mem_ia <= STD_LOGIC_VECTOR(accValuePositive_uid35_fpAccTest_q);
    redist14_accValuePositive_uid35_fpAccTest_q_5_mem_aa <= redist14_accValuePositive_uid35_fpAccTest_q_5_wraddr_q;
    redist14_accValuePositive_uid35_fpAccTest_q_5_mem_ab <= redist14_accValuePositive_uid35_fpAccTest_q_5_rdmux_q;
    redist14_accValuePositive_uid35_fpAccTest_q_5_mem_reset0 <= areset;
    redist14_accValuePositive_uid35_fpAccTest_q_5_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 77,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 77,
        widthad_b => 1,
        numwords_b => 2,
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
        clocken1 => redist14_accValuePositive_uid35_fpAccTest_q_5_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist14_accValuePositive_uid35_fpAccTest_q_5_mem_reset0,
        clock1 => clk,
        address_a => redist14_accValuePositive_uid35_fpAccTest_q_5_mem_aa,
        data_a => redist14_accValuePositive_uid35_fpAccTest_q_5_mem_ia,
        wren_a => en(0),
        address_b => redist14_accValuePositive_uid35_fpAccTest_q_5_mem_ab,
        q_b => redist14_accValuePositive_uid35_fpAccTest_q_5_mem_iq
    );
    redist14_accValuePositive_uid35_fpAccTest_q_5_mem_q <= redist14_accValuePositive_uid35_fpAccTest_q_5_mem_iq(76 downto 0);

    -- redist14_accValuePositive_uid35_fpAccTest_q_5_outputreg(DELAY,220)
    redist14_accValuePositive_uid35_fpAccTest_q_5_outputreg : dspba_delay
    GENERIC MAP ( width => 77, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist14_accValuePositive_uid35_fpAccTest_q_5_mem_q, xout => redist14_accValuePositive_uid35_fpAccTest_q_5_outputreg_q, ena => en(0), clk => clk, aclr => areset );

    -- leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest(MUX,161)@8
    leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_b;
    leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_s, en, redist14_accValuePositive_uid35_fpAccTest_q_5_outputreg_q, leftShiftStage0Idx1_uid156_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx2_uid159_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx3_uid160_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q <= redist14_accValuePositive_uid35_fpAccTest_q_5_outputreg_q;
            WHEN "01" => leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx1_uid156_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx2_uid159_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx3_uid160_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest(MUX,172)@8
    leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_c;
    leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx1_uid165_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx2_uid168_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx3_uid171_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0_uid162_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx1_uid165_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx2_uid168_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx3_uid171_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest(MUX,183)@8
    leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_d;
    leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q, leftShiftStage2Idx1_uid176_normalizationShifter_uid40_fpAccTest_q, leftShiftStage2Idx2_uid179_normalizationShifter_uid40_fpAccTest_q, leftShiftStage2Idx3_uid182_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1_uid173_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx1_uid176_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx2_uid179_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx3_uid182_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select(BITSELECT,197)@8
    leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_b <= redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1_q(6 downto 5);
    leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_c <= redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1_q(4 downto 3);
    leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_d <= redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1_q(2 downto 1);
    leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_e <= redist6_r_uid107_zeroCounter_uid37_fpAccTest_q_1_q(0 downto 0);

    -- leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest(MUX,188)@8
    leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel6Dto5_uid161_normalizationShifter_uid40_fpAccTest_merged_bit_select_e;
    leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_q, leftShiftStage3Idx1_uid187_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "0" => leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2_uid184_normalizationShifter_uid40_fpAccTest_q;
            WHEN "1" => leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx1_uid187_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracR_uid46_fpAccTest(BITSELECT,45)@8
    fracR_uid46_fpAccTest_in <= leftShiftStage3_uid189_normalizationShifter_uid40_fpAccTest_q(73 downto 0);
    fracR_uid46_fpAccTest_b <= fracR_uid46_fpAccTest_in(73 downto 51);

    -- R_uid47_fpAccTest(BITJOIN,46)@8
    R_uid47_fpAccTest_q <= redist15_accumulatorSign_uid29_fpAccTest_b_5_q & finalExpUpdated_uid45_fpAccTest_q & fracR_uid46_fpAccTest_b;

    -- xOut(GPOUT,4)@8
    r <= R_uid47_fpAccTest_q;
    xo <= redist13_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5_q;
    xu <= redist12_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_8_q;
    ao <= redist11_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_5_q;

END normal;
