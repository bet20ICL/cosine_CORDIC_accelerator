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

-- VHDL created from flt2fxd_0002
-- VHDL created on Sun Mar 12 20:48:03 2023


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

entity flt2fxd_0002 is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        q : out std_logic_vector(20 downto 0);  -- ufix21_en20
        clk : in std_logic;
        areset : in std_logic
    );
end flt2fxd_0002;

architecture normal of flt2fxd_0002 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstAllOWE_uid6_fpToFxPTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWF_uid7_fpToFxPTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal cstAllZWE_uid8_fpToFxPTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal exp_x_uid9_fpToFxPTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_x_uid10_fpToFxPTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_x_uid11_fpToFxPTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid12_fpToFxPTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid12_fpToFxPTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid13_fpToFxPTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid13_fpToFxPTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid14_fpToFxPTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid15_fpToFxPTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid16_fpToFxPTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcXZ_uid22_fpToFxPTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracX_uid23_fpToFxPTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal signX_uid25_fpToFxPTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ovfExpVal_uid26_fpToFxPTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal ovf_uid27_fpToFxPTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal ovf_uid27_fpToFxPTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal ovf_uid27_fpToFxPTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal ovf_uid27_fpToFxPTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal negOrOvf_uid28_fpToFxPTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal udfExpVal_uid29_fpToFxPTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal udf_uid30_fpToFxPTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal udf_uid30_fpToFxPTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal udf_uid30_fpToFxPTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal udf_uid30_fpToFxPTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal ovfExpVal_uid31_fpToFxPTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal shiftValE_uid32_fpToFxPTest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftValE_uid32_fpToFxPTest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftValE_uid32_fpToFxPTest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftValE_uid32_fpToFxPTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal shiftValRaw_uid33_fpToFxPTest_in : STD_LOGIC_VECTOR (4 downto 0);
    signal shiftValRaw_uid33_fpToFxPTest_b : STD_LOGIC_VECTOR (4 downto 0);
    signal maxShiftCst_uid34_fpToFxPTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal shiftOutOfRange_uid35_fpToFxPTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftOutOfRange_uid35_fpToFxPTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftOutOfRange_uid35_fpToFxPTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftOutOfRange_uid35_fpToFxPTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftVal_uid36_fpToFxPTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftVal_uid36_fpToFxPTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal shifterIn_uid37_fpToFxPTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal maxPosValueU_uid39_fpToFxPTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal maxNegValueU_uid40_fpToFxPTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal zRightShiferNoStickyOut_uid42_fpToFxPTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal sPostRndFull_uid43_fpToFxPTest_a : STD_LOGIC_VECTOR (23 downto 0);
    signal sPostRndFull_uid43_fpToFxPTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal sPostRndFull_uid43_fpToFxPTest_o : STD_LOGIC_VECTOR (23 downto 0);
    signal sPostRndFull_uid43_fpToFxPTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal sPostRnd_uid44_fpToFxPTest_in : STD_LOGIC_VECTOR (21 downto 0);
    signal sPostRnd_uid44_fpToFxPTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal sPostRndFullMSBU_uid45_fpToFxPTest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal sPostRndFullMSBU_uid45_fpToFxPTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ovfPostRnd_uid46_fpToFxPTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal ovfPostRnd_uid46_fpToFxPTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxSelConc_uid47_fpToFxPTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal muxSel_uid48_fpToFxPTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal finalOut_uid50_fpToFxPTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal finalOut_uid50_fpToFxPTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal rightShiftStage0Idx1Rng8_uid54_rightShiferNoStickyOut_uid38_fpToFxPTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal rightShiftStage0Idx1_uid56_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage0Idx2Rng16_uid57_rightShiferNoStickyOut_uid38_fpToFxPTest_b : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage0Idx2Pad16_uid58_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStage0Idx2_uid59_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage0Idx3_uid60_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage1Idx1Rng2_uid63_rightShiferNoStickyOut_uid38_fpToFxPTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal rightShiftStage1Idx1Pad2_uid64_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1Idx1_uid65_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage1Idx2Rng4_uid66_rightShiferNoStickyOut_uid38_fpToFxPTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal rightShiftStage1Idx2Pad4_uid67_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal rightShiftStage1Idx2_uid68_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage1Idx3Rng6_uid69_rightShiferNoStickyOut_uid38_fpToFxPTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStage1Idx3Pad6_uid70_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage1Idx3_uid71_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage2Idx1Rng1_uid74_rightShiferNoStickyOut_uid38_fpToFxPTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal rightShiftStage2Idx1_uid76_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_d : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist1_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_d_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_sPostRnd_uid44_fpToFxPTest_b_1_q : STD_LOGIC_VECTOR (20 downto 0);
    signal redist3_shifterIn_uid37_fpToFxPTest_b_1_q : STD_LOGIC_VECTOR (21 downto 0);
    signal redist4_udf_uid30_fpToFxPTest_n_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ovf_uid27_fpToFxPTest_n_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_signX_uid25_fpToFxPTest_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_signX_uid25_fpToFxPTest_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_fracXIsZero_uid13_fpToFxPTest_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_expXIsMax_uid12_fpToFxPTest_q_3_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- maxNegValueU_uid40_fpToFxPTest(CONSTANT,39)
    maxNegValueU_uid40_fpToFxPTest_q <= "000000000000000000000";

    -- maxPosValueU_uid39_fpToFxPTest(CONSTANT,38)
    maxPosValueU_uid39_fpToFxPTest_q <= "111111111111111111111";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- rightShiftStage2Idx1Rng1_uid74_rightShiferNoStickyOut_uid38_fpToFxPTest(BITSELECT,73)@2
    rightShiftStage2Idx1Rng1_uid74_rightShiferNoStickyOut_uid38_fpToFxPTest_b <= rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_q(21 downto 1);

    -- rightShiftStage2Idx1_uid76_rightShiferNoStickyOut_uid38_fpToFxPTest(BITJOIN,75)@2
    rightShiftStage2Idx1_uid76_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= GND_q & rightShiftStage2Idx1Rng1_uid74_rightShiferNoStickyOut_uid38_fpToFxPTest_b;

    -- rightShiftStage1Idx3Pad6_uid70_rightShiferNoStickyOut_uid38_fpToFxPTest(CONSTANT,69)
    rightShiftStage1Idx3Pad6_uid70_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= "000000";

    -- rightShiftStage1Idx3Rng6_uid69_rightShiferNoStickyOut_uid38_fpToFxPTest(BITSELECT,68)@2
    rightShiftStage1Idx3Rng6_uid69_rightShiferNoStickyOut_uid38_fpToFxPTest_b <= rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q(21 downto 6);

    -- rightShiftStage1Idx3_uid71_rightShiferNoStickyOut_uid38_fpToFxPTest(BITJOIN,70)@2
    rightShiftStage1Idx3_uid71_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage1Idx3Pad6_uid70_rightShiferNoStickyOut_uid38_fpToFxPTest_q & rightShiftStage1Idx3Rng6_uid69_rightShiferNoStickyOut_uid38_fpToFxPTest_b;

    -- rightShiftStage1Idx2Pad4_uid67_rightShiferNoStickyOut_uid38_fpToFxPTest(CONSTANT,66)
    rightShiftStage1Idx2Pad4_uid67_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= "0000";

    -- rightShiftStage1Idx2Rng4_uid66_rightShiferNoStickyOut_uid38_fpToFxPTest(BITSELECT,65)@2
    rightShiftStage1Idx2Rng4_uid66_rightShiferNoStickyOut_uid38_fpToFxPTest_b <= rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q(21 downto 4);

    -- rightShiftStage1Idx2_uid68_rightShiferNoStickyOut_uid38_fpToFxPTest(BITJOIN,67)@2
    rightShiftStage1Idx2_uid68_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage1Idx2Pad4_uid67_rightShiferNoStickyOut_uid38_fpToFxPTest_q & rightShiftStage1Idx2Rng4_uid66_rightShiferNoStickyOut_uid38_fpToFxPTest_b;

    -- rightShiftStage1Idx1Pad2_uid64_rightShiferNoStickyOut_uid38_fpToFxPTest(CONSTANT,63)
    rightShiftStage1Idx1Pad2_uid64_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= "00";

    -- rightShiftStage1Idx1Rng2_uid63_rightShiferNoStickyOut_uid38_fpToFxPTest(BITSELECT,62)@2
    rightShiftStage1Idx1Rng2_uid63_rightShiferNoStickyOut_uid38_fpToFxPTest_b <= rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q(21 downto 2);

    -- rightShiftStage1Idx1_uid65_rightShiferNoStickyOut_uid38_fpToFxPTest(BITJOIN,64)@2
    rightShiftStage1Idx1_uid65_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage1Idx1Pad2_uid64_rightShiferNoStickyOut_uid38_fpToFxPTest_q & rightShiftStage1Idx1Rng2_uid63_rightShiferNoStickyOut_uid38_fpToFxPTest_b;

    -- rightShiftStage0Idx3_uid60_rightShiferNoStickyOut_uid38_fpToFxPTest(CONSTANT,59)
    rightShiftStage0Idx3_uid60_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= "0000000000000000000000";

    -- rightShiftStage0Idx2Pad16_uid58_rightShiferNoStickyOut_uid38_fpToFxPTest(CONSTANT,57)
    rightShiftStage0Idx2Pad16_uid58_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= "0000000000000000";

    -- rightShiftStage0Idx2Rng16_uid57_rightShiferNoStickyOut_uid38_fpToFxPTest(BITSELECT,56)@1
    rightShiftStage0Idx2Rng16_uid57_rightShiferNoStickyOut_uid38_fpToFxPTest_b <= redist3_shifterIn_uid37_fpToFxPTest_b_1_q(21 downto 16);

    -- rightShiftStage0Idx2_uid59_rightShiferNoStickyOut_uid38_fpToFxPTest(BITJOIN,58)@1
    rightShiftStage0Idx2_uid59_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage0Idx2Pad16_uid58_rightShiferNoStickyOut_uid38_fpToFxPTest_q & rightShiftStage0Idx2Rng16_uid57_rightShiferNoStickyOut_uid38_fpToFxPTest_b;

    -- cstAllZWE_uid8_fpToFxPTest(CONSTANT,7)
    cstAllZWE_uid8_fpToFxPTest_q <= "00000000";

    -- rightShiftStage0Idx1Rng8_uid54_rightShiferNoStickyOut_uid38_fpToFxPTest(BITSELECT,53)@1
    rightShiftStage0Idx1Rng8_uid54_rightShiferNoStickyOut_uid38_fpToFxPTest_b <= redist3_shifterIn_uid37_fpToFxPTest_b_1_q(21 downto 8);

    -- rightShiftStage0Idx1_uid56_rightShiferNoStickyOut_uid38_fpToFxPTest(BITJOIN,55)@1
    rightShiftStage0Idx1_uid56_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= cstAllZWE_uid8_fpToFxPTest_q & rightShiftStage0Idx1Rng8_uid54_rightShiferNoStickyOut_uid38_fpToFxPTest_b;

    -- exp_x_uid9_fpToFxPTest(BITSELECT,8)@0
    exp_x_uid9_fpToFxPTest_b <= a(30 downto 23);

    -- excZ_x_uid11_fpToFxPTest(LOGICAL,10)@0
    excZ_x_uid11_fpToFxPTest_q <= "1" WHEN exp_x_uid9_fpToFxPTest_b = cstAllZWE_uid8_fpToFxPTest_q ELSE "0";

    -- invExcXZ_uid22_fpToFxPTest(LOGICAL,21)@0
    invExcXZ_uid22_fpToFxPTest_q <= not (excZ_x_uid11_fpToFxPTest_q);

    -- frac_x_uid10_fpToFxPTest(BITSELECT,9)@0
    frac_x_uid10_fpToFxPTest_b <= a(22 downto 0);

    -- oFracX_uid23_fpToFxPTest(BITJOIN,22)@0
    oFracX_uid23_fpToFxPTest_q <= invExcXZ_uid22_fpToFxPTest_q & frac_x_uid10_fpToFxPTest_b;

    -- shifterIn_uid37_fpToFxPTest(BITSELECT,36)@0
    shifterIn_uid37_fpToFxPTest_b <= oFracX_uid23_fpToFxPTest_q(23 downto 2);

    -- redist3_shifterIn_uid37_fpToFxPTest_b_1(DELAY,83)
    redist3_shifterIn_uid37_fpToFxPTest_b_1 : dspba_delay
    GENERIC MAP ( width => 22, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => shifterIn_uid37_fpToFxPTest_b, xout => redist3_shifterIn_uid37_fpToFxPTest_b_1_q, clk => clk, aclr => areset );

    -- maxShiftCst_uid34_fpToFxPTest(CONSTANT,33)
    maxShiftCst_uid34_fpToFxPTest_q <= "10110";

    -- ovfExpVal_uid31_fpToFxPTest(CONSTANT,30)
    ovfExpVal_uid31_fpToFxPTest_q <= "01111111";

    -- shiftValE_uid32_fpToFxPTest(SUB,31)@0 + 1
    shiftValE_uid32_fpToFxPTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 8 => ovfExpVal_uid31_fpToFxPTest_q(7)) & ovfExpVal_uid31_fpToFxPTest_q));
    shiftValE_uid32_fpToFxPTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & exp_x_uid9_fpToFxPTest_b));
    shiftValE_uid32_fpToFxPTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftValE_uid32_fpToFxPTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            shiftValE_uid32_fpToFxPTest_o <= STD_LOGIC_VECTOR(SIGNED(shiftValE_uid32_fpToFxPTest_a) - SIGNED(shiftValE_uid32_fpToFxPTest_b));
        END IF;
    END PROCESS;
    shiftValE_uid32_fpToFxPTest_q <= shiftValE_uid32_fpToFxPTest_o(9 downto 0);

    -- shiftValRaw_uid33_fpToFxPTest(BITSELECT,32)@1
    shiftValRaw_uid33_fpToFxPTest_in <= shiftValE_uid32_fpToFxPTest_q(4 downto 0);
    shiftValRaw_uid33_fpToFxPTest_b <= shiftValRaw_uid33_fpToFxPTest_in(4 downto 0);

    -- shiftOutOfRange_uid35_fpToFxPTest(COMPARE,34)@1
    shiftOutOfRange_uid35_fpToFxPTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 10 => shiftValE_uid32_fpToFxPTest_q(9)) & shiftValE_uid32_fpToFxPTest_q));
    shiftOutOfRange_uid35_fpToFxPTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000000" & maxShiftCst_uid34_fpToFxPTest_q));
    shiftOutOfRange_uid35_fpToFxPTest_o <= STD_LOGIC_VECTOR(SIGNED(shiftOutOfRange_uid35_fpToFxPTest_a) - SIGNED(shiftOutOfRange_uid35_fpToFxPTest_b));
    shiftOutOfRange_uid35_fpToFxPTest_n(0) <= not (shiftOutOfRange_uid35_fpToFxPTest_o(11));

    -- shiftVal_uid36_fpToFxPTest(MUX,35)@1
    shiftVal_uid36_fpToFxPTest_s <= shiftOutOfRange_uid35_fpToFxPTest_n;
    shiftVal_uid36_fpToFxPTest_combproc: PROCESS (shiftVal_uid36_fpToFxPTest_s, shiftValRaw_uid33_fpToFxPTest_b, maxShiftCst_uid34_fpToFxPTest_q)
    BEGIN
        CASE (shiftVal_uid36_fpToFxPTest_s) IS
            WHEN "0" => shiftVal_uid36_fpToFxPTest_q <= shiftValRaw_uid33_fpToFxPTest_b;
            WHEN "1" => shiftVal_uid36_fpToFxPTest_q <= maxShiftCst_uid34_fpToFxPTest_q;
            WHEN OTHERS => shiftVal_uid36_fpToFxPTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select(BITSELECT,79)@1
    rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_b <= shiftVal_uid36_fpToFxPTest_q(4 downto 3);
    rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_c <= shiftVal_uid36_fpToFxPTest_q(2 downto 1);
    rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_d <= shiftVal_uid36_fpToFxPTest_q(0 downto 0);

    -- rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest(MUX,61)@1 + 1
    rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_s <= rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_b;
    rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_s) IS
                WHEN "00" => rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= redist3_shifterIn_uid37_fpToFxPTest_b_1_q;
                WHEN "01" => rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage0Idx1_uid56_rightShiferNoStickyOut_uid38_fpToFxPTest_q;
                WHEN "10" => rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage0Idx2_uid59_rightShiferNoStickyOut_uid38_fpToFxPTest_q;
                WHEN "11" => rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage0Idx3_uid60_rightShiferNoStickyOut_uid38_fpToFxPTest_q;
                WHEN OTHERS => rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist0_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_c_1(DELAY,80)
    redist0_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_c, xout => redist0_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest(MUX,72)@2
    rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_s <= redist0_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_c_1_q;
    rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_combproc: PROCESS (rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_s, rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q, rightShiftStage1Idx1_uid65_rightShiferNoStickyOut_uid38_fpToFxPTest_q, rightShiftStage1Idx2_uid68_rightShiferNoStickyOut_uid38_fpToFxPTest_q, rightShiftStage1Idx3_uid71_rightShiferNoStickyOut_uid38_fpToFxPTest_q)
    BEGIN
        CASE (rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_s) IS
            WHEN "00" => rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage0_uid62_rightShiferNoStickyOut_uid38_fpToFxPTest_q;
            WHEN "01" => rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage1Idx1_uid65_rightShiferNoStickyOut_uid38_fpToFxPTest_q;
            WHEN "10" => rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage1Idx2_uid68_rightShiferNoStickyOut_uid38_fpToFxPTest_q;
            WHEN "11" => rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage1Idx3_uid71_rightShiferNoStickyOut_uid38_fpToFxPTest_q;
            WHEN OTHERS => rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist1_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_d_1(DELAY,81)
    redist1_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_d_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_d, xout => redist1_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_d_1_q, clk => clk, aclr => areset );

    -- rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest(MUX,77)@2 + 1
    rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_s <= redist1_rightShiftStageSel4Dto3_uid61_rightShiferNoStickyOut_uid38_fpToFxPTest_merged_bit_select_d_1_q;
    rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_s) IS
                WHEN "0" => rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage1_uid73_rightShiferNoStickyOut_uid38_fpToFxPTest_q;
                WHEN "1" => rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= rightShiftStage2Idx1_uid76_rightShiferNoStickyOut_uid38_fpToFxPTest_q;
                WHEN OTHERS => rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- zRightShiferNoStickyOut_uid42_fpToFxPTest(BITJOIN,41)@3
    zRightShiferNoStickyOut_uid42_fpToFxPTest_q <= GND_q & rightShiftStage2_uid78_rightShiferNoStickyOut_uid38_fpToFxPTest_q;

    -- sPostRndFull_uid43_fpToFxPTest(ADD,42)@3
    sPostRndFull_uid43_fpToFxPTest_a <= STD_LOGIC_VECTOR("0" & zRightShiferNoStickyOut_uid42_fpToFxPTest_q);
    sPostRndFull_uid43_fpToFxPTest_b <= STD_LOGIC_VECTOR("00000000000000000000000" & VCC_q);
    sPostRndFull_uid43_fpToFxPTest_o <= STD_LOGIC_VECTOR(UNSIGNED(sPostRndFull_uid43_fpToFxPTest_a) + UNSIGNED(sPostRndFull_uid43_fpToFxPTest_b));
    sPostRndFull_uid43_fpToFxPTest_q <= sPostRndFull_uid43_fpToFxPTest_o(23 downto 0);

    -- sPostRnd_uid44_fpToFxPTest(BITSELECT,43)@3
    sPostRnd_uid44_fpToFxPTest_in <= sPostRndFull_uid43_fpToFxPTest_q(21 downto 0);
    sPostRnd_uid44_fpToFxPTest_b <= sPostRnd_uid44_fpToFxPTest_in(21 downto 1);

    -- redist2_sPostRnd_uid44_fpToFxPTest_b_1(DELAY,82)
    redist2_sPostRnd_uid44_fpToFxPTest_b_1 : dspba_delay
    GENERIC MAP ( width => 21, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => sPostRnd_uid44_fpToFxPTest_b, xout => redist2_sPostRnd_uid44_fpToFxPTest_b_1_q, clk => clk, aclr => areset );

    -- signX_uid25_fpToFxPTest(BITSELECT,24)@0
    signX_uid25_fpToFxPTest_b <= STD_LOGIC_VECTOR(a(31 downto 31));

    -- redist6_signX_uid25_fpToFxPTest_b_3(DELAY,86)
    redist6_signX_uid25_fpToFxPTest_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => signX_uid25_fpToFxPTest_b, xout => redist6_signX_uid25_fpToFxPTest_b_3_q, clk => clk, aclr => areset );

    -- redist7_signX_uid25_fpToFxPTest_b_4(DELAY,87)
    redist7_signX_uid25_fpToFxPTest_b_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist6_signX_uid25_fpToFxPTest_b_3_q, xout => redist7_signX_uid25_fpToFxPTest_b_4_q, clk => clk, aclr => areset );

    -- udfExpVal_uid29_fpToFxPTest(CONSTANT,28)
    udfExpVal_uid29_fpToFxPTest_q <= "01101001";

    -- udf_uid30_fpToFxPTest(COMPARE,29)@0 + 1
    udf_uid30_fpToFxPTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 8 => udfExpVal_uid29_fpToFxPTest_q(7)) & udfExpVal_uid29_fpToFxPTest_q));
    udf_uid30_fpToFxPTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & exp_x_uid9_fpToFxPTest_b));
    udf_uid30_fpToFxPTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            udf_uid30_fpToFxPTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            udf_uid30_fpToFxPTest_o <= STD_LOGIC_VECTOR(SIGNED(udf_uid30_fpToFxPTest_a) - SIGNED(udf_uid30_fpToFxPTest_b));
        END IF;
    END PROCESS;
    udf_uid30_fpToFxPTest_n(0) <= not (udf_uid30_fpToFxPTest_o(10));

    -- redist4_udf_uid30_fpToFxPTest_n_4(DELAY,84)
    redist4_udf_uid30_fpToFxPTest_n_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => udf_uid30_fpToFxPTest_n, xout => redist4_udf_uid30_fpToFxPTest_n_4_q, clk => clk, aclr => areset );

    -- sPostRndFullMSBU_uid45_fpToFxPTest(BITSELECT,44)@3
    sPostRndFullMSBU_uid45_fpToFxPTest_in <= STD_LOGIC_VECTOR(sPostRndFull_uid43_fpToFxPTest_q(22 downto 0));
    sPostRndFullMSBU_uid45_fpToFxPTest_b <= STD_LOGIC_VECTOR(sPostRndFullMSBU_uid45_fpToFxPTest_in(22 downto 22));

    -- ovfExpVal_uid26_fpToFxPTest(CONSTANT,25)
    ovfExpVal_uid26_fpToFxPTest_q <= "010000000";

    -- ovf_uid27_fpToFxPTest(COMPARE,26)@0 + 1
    ovf_uid27_fpToFxPTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & exp_x_uid9_fpToFxPTest_b));
    ovf_uid27_fpToFxPTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 9 => ovfExpVal_uid26_fpToFxPTest_q(8)) & ovfExpVal_uid26_fpToFxPTest_q));
    ovf_uid27_fpToFxPTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ovf_uid27_fpToFxPTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            ovf_uid27_fpToFxPTest_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid27_fpToFxPTest_a) - SIGNED(ovf_uid27_fpToFxPTest_b));
        END IF;
    END PROCESS;
    ovf_uid27_fpToFxPTest_n(0) <= not (ovf_uid27_fpToFxPTest_o(10));

    -- redist5_ovf_uid27_fpToFxPTest_n_3(DELAY,85)
    redist5_ovf_uid27_fpToFxPTest_n_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => ovf_uid27_fpToFxPTest_n, xout => redist5_ovf_uid27_fpToFxPTest_n_3_q, clk => clk, aclr => areset );

    -- negOrOvf_uid28_fpToFxPTest(LOGICAL,27)@3
    negOrOvf_uid28_fpToFxPTest_q <= redist6_signX_uid25_fpToFxPTest_b_3_q or redist5_ovf_uid27_fpToFxPTest_n_3_q;

    -- cstZeroWF_uid7_fpToFxPTest(CONSTANT,6)
    cstZeroWF_uid7_fpToFxPTest_q <= "00000000000000000000000";

    -- fracXIsZero_uid13_fpToFxPTest(LOGICAL,12)@0 + 1
    fracXIsZero_uid13_fpToFxPTest_qi <= "1" WHEN cstZeroWF_uid7_fpToFxPTest_q = frac_x_uid10_fpToFxPTest_b ELSE "0";
    fracXIsZero_uid13_fpToFxPTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid13_fpToFxPTest_qi, xout => fracXIsZero_uid13_fpToFxPTest_q, clk => clk, aclr => areset );

    -- redist8_fracXIsZero_uid13_fpToFxPTest_q_3(DELAY,88)
    redist8_fracXIsZero_uid13_fpToFxPTest_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid13_fpToFxPTest_q, xout => redist8_fracXIsZero_uid13_fpToFxPTest_q_3_q, clk => clk, aclr => areset );

    -- cstAllOWE_uid6_fpToFxPTest(CONSTANT,5)
    cstAllOWE_uid6_fpToFxPTest_q <= "11111111";

    -- expXIsMax_uid12_fpToFxPTest(LOGICAL,11)@0 + 1
    expXIsMax_uid12_fpToFxPTest_qi <= "1" WHEN exp_x_uid9_fpToFxPTest_b = cstAllOWE_uid6_fpToFxPTest_q ELSE "0";
    expXIsMax_uid12_fpToFxPTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid12_fpToFxPTest_qi, xout => expXIsMax_uid12_fpToFxPTest_q, clk => clk, aclr => areset );

    -- redist9_expXIsMax_uid12_fpToFxPTest_q_3(DELAY,89)
    redist9_expXIsMax_uid12_fpToFxPTest_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid12_fpToFxPTest_q, xout => redist9_expXIsMax_uid12_fpToFxPTest_q_3_q, clk => clk, aclr => areset );

    -- excI_x_uid15_fpToFxPTest(LOGICAL,14)@3
    excI_x_uid15_fpToFxPTest_q <= redist9_expXIsMax_uid12_fpToFxPTest_q_3_q and redist8_fracXIsZero_uid13_fpToFxPTest_q_3_q;

    -- fracXIsNotZero_uid14_fpToFxPTest(LOGICAL,13)@3
    fracXIsNotZero_uid14_fpToFxPTest_q <= not (redist8_fracXIsZero_uid13_fpToFxPTest_q_3_q);

    -- excN_x_uid16_fpToFxPTest(LOGICAL,15)@3
    excN_x_uid16_fpToFxPTest_q <= redist9_expXIsMax_uid12_fpToFxPTest_q_3_q and fracXIsNotZero_uid14_fpToFxPTest_q;

    -- ovfPostRnd_uid46_fpToFxPTest(LOGICAL,45)@3 + 1
    ovfPostRnd_uid46_fpToFxPTest_qi <= excN_x_uid16_fpToFxPTest_q or excI_x_uid15_fpToFxPTest_q or negOrOvf_uid28_fpToFxPTest_q or sPostRndFullMSBU_uid45_fpToFxPTest_b;
    ovfPostRnd_uid46_fpToFxPTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => ovfPostRnd_uid46_fpToFxPTest_qi, xout => ovfPostRnd_uid46_fpToFxPTest_q, clk => clk, aclr => areset );

    -- muxSelConc_uid47_fpToFxPTest(BITJOIN,46)@4
    muxSelConc_uid47_fpToFxPTest_q <= redist7_signX_uid25_fpToFxPTest_b_4_q & redist4_udf_uid30_fpToFxPTest_n_4_q & ovfPostRnd_uid46_fpToFxPTest_q;

    -- muxSel_uid48_fpToFxPTest(LOOKUP,47)@4
    muxSel_uid48_fpToFxPTest_combproc: PROCESS (muxSelConc_uid47_fpToFxPTest_q)
    BEGIN
        -- Begin reserved scope level
        CASE (muxSelConc_uid47_fpToFxPTest_q) IS
            WHEN "000" => muxSel_uid48_fpToFxPTest_q <= "00";
            WHEN "001" => muxSel_uid48_fpToFxPTest_q <= "01";
            WHEN "010" => muxSel_uid48_fpToFxPTest_q <= "11";
            WHEN "011" => muxSel_uid48_fpToFxPTest_q <= "00";
            WHEN "100" => muxSel_uid48_fpToFxPTest_q <= "10";
            WHEN "101" => muxSel_uid48_fpToFxPTest_q <= "10";
            WHEN "110" => muxSel_uid48_fpToFxPTest_q <= "10";
            WHEN "111" => muxSel_uid48_fpToFxPTest_q <= "10";
            WHEN OTHERS => -- unreachable
                           muxSel_uid48_fpToFxPTest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- finalOut_uid50_fpToFxPTest(MUX,49)@4
    finalOut_uid50_fpToFxPTest_s <= muxSel_uid48_fpToFxPTest_q;
    finalOut_uid50_fpToFxPTest_combproc: PROCESS (finalOut_uid50_fpToFxPTest_s, redist2_sPostRnd_uid44_fpToFxPTest_b_1_q, maxPosValueU_uid39_fpToFxPTest_q, maxNegValueU_uid40_fpToFxPTest_q)
    BEGIN
        CASE (finalOut_uid50_fpToFxPTest_s) IS
            WHEN "00" => finalOut_uid50_fpToFxPTest_q <= redist2_sPostRnd_uid44_fpToFxPTest_b_1_q;
            WHEN "01" => finalOut_uid50_fpToFxPTest_q <= maxPosValueU_uid39_fpToFxPTest_q;
            WHEN "10" => finalOut_uid50_fpToFxPTest_q <= maxNegValueU_uid40_fpToFxPTest_q;
            WHEN "11" => finalOut_uid50_fpToFxPTest_q <= maxNegValueU_uid40_fpToFxPTest_q;
            WHEN OTHERS => finalOut_uid50_fpToFxPTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- xOut(GPOUT,4)@4
    q <= finalOut_uid50_fpToFxPTest_q;

END normal;
