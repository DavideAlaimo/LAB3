/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP4
// Date      : Thu Feb  3 18:37:36 2022
/////////////////////////////////////////////////////////////


module ControlHazardUnit ( OPCODE, OPCODE_1, ZERO_ALU, CLK, RST, SEL_MUX_PC, 
        SEL_MUX_INSTR );
  input [6:0] OPCODE;
  input [6:0] OPCODE_1;
  input ZERO_ALU, CLK, RST;
  output SEL_MUX_PC, SEL_MUX_INSTR;
  wire   MUX_PC1, CONTROL_HAZARD_JAL_n3, CONTROL_HAZARD_JAL_n2,
         CONTROL_HAZARD_JAL_n1, CONTROL_HAZARD_JAL_N16,
         CONTROL_HAZARD_JAL_PSTATE, CONTROL_HAZARD_JAL_PSTATE_REGISTER_n1,
         CONTROL_HAZARD_BEQ_n4, CONTROL_HAZARD_BEQ_n3, CONTROL_HAZARD_BEQ_n2,
         CONTROL_HAZARD_BEQ_n1, CONTROL_HAZARD_BEQ_N15,
         CONTROL_HAZARD_BEQ_PSTATE, CONTROL_HAZARD_BEQ_PSTATE_REGISTER_n2;

  OR2_X1 U2 ( .A1(MUX_PC1), .A2(SEL_MUX_INSTR), .ZN(SEL_MUX_PC) );
  INV_X1 CONTROL_HAZARD_JAL_U6 ( .A(OPCODE[4]), .ZN(CONTROL_HAZARD_JAL_n3) );
  AND4_X1 CONTROL_HAZARD_JAL_U5 ( .A1(OPCODE[2]), .A2(OPCODE[1]), .A3(
        OPCODE[0]), .A4(CONTROL_HAZARD_JAL_n3), .ZN(CONTROL_HAZARD_JAL_n2) );
  NAND4_X1 CONTROL_HAZARD_JAL_U4 ( .A1(OPCODE[5]), .A2(OPCODE[3]), .A3(
        OPCODE[6]), .A4(CONTROL_HAZARD_JAL_n2), .ZN(CONTROL_HAZARD_JAL_n1) );
  NOR2_X1 CONTROL_HAZARD_JAL_U3 ( .A1(CONTROL_HAZARD_JAL_PSTATE), .A2(
        CONTROL_HAZARD_JAL_n1), .ZN(CONTROL_HAZARD_JAL_N16) );
  INV_X1 CONTROL_HAZARD_JAL_U2 ( .A(CONTROL_HAZARD_JAL_n1), .ZN(MUX_PC1) );
  INV_X1 CONTROL_HAZARD_JAL_PSTATE_REGISTER_U3 ( .A(RST), .ZN(
        CONTROL_HAZARD_JAL_PSTATE_REGISTER_n1) );
  DFFR_X1 CONTROL_HAZARD_JAL_PSTATE_REGISTER_DATA_OUT_reg ( .D(
        CONTROL_HAZARD_JAL_N16), .CK(CLK), .RN(
        CONTROL_HAZARD_JAL_PSTATE_REGISTER_n1), .Q(CONTROL_HAZARD_JAL_PSTATE)
         );
  INV_X1 CONTROL_HAZARD_BEQ_U7 ( .A(OPCODE_1[2]), .ZN(CONTROL_HAZARD_BEQ_n2)
         );
  NOR2_X1 CONTROL_HAZARD_BEQ_U6 ( .A1(OPCODE_1[4]), .A2(OPCODE_1[3]), .ZN(
        CONTROL_HAZARD_BEQ_n3) );
  AND4_X1 CONTROL_HAZARD_BEQ_U5 ( .A1(ZERO_ALU), .A2(OPCODE_1[6]), .A3(
        OPCODE_1[5]), .A4(OPCODE_1[1]), .ZN(CONTROL_HAZARD_BEQ_n4) );
  NAND4_X1 CONTROL_HAZARD_BEQ_U4 ( .A1(OPCODE_1[0]), .A2(CONTROL_HAZARD_BEQ_n2), .A3(CONTROL_HAZARD_BEQ_n3), .A4(CONTROL_HAZARD_BEQ_n4), .ZN(
        CONTROL_HAZARD_BEQ_n1) );
  NOR2_X1 CONTROL_HAZARD_BEQ_U3 ( .A1(CONTROL_HAZARD_BEQ_PSTATE), .A2(
        CONTROL_HAZARD_BEQ_n1), .ZN(CONTROL_HAZARD_BEQ_N15) );
  INV_X1 CONTROL_HAZARD_BEQ_U2 ( .A(CONTROL_HAZARD_BEQ_n1), .ZN(SEL_MUX_INSTR)
         );
  INV_X1 CONTROL_HAZARD_BEQ_PSTATE_REGISTER_U3 ( .A(RST), .ZN(
        CONTROL_HAZARD_BEQ_PSTATE_REGISTER_n2) );
  DFFR_X1 CONTROL_HAZARD_BEQ_PSTATE_REGISTER_DATA_OUT_reg ( .D(
        CONTROL_HAZARD_BEQ_N15), .CK(CLK), .RN(
        CONTROL_HAZARD_BEQ_PSTATE_REGISTER_n2), .Q(CONTROL_HAZARD_BEQ_PSTATE)
         );
endmodule
