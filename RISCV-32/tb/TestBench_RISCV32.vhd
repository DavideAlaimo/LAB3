library ieee;
use ieee.std_logic_1164.all;

ENTITY TB_RISCV IS
END ENTITY;

ARCHITECTURE BEH OF TB_RISCV IS

COMPONENT RISC_V IS
PORT(INSTRUCTION : IN STD_LOGIC_VECTOR(31 DOWNTO 0); --DATA OUTPUT MEMORY INSTRUCTION
     DATA_OUT_MEM_DATA : IN STD_LOGIC_VECTOR(63 DOWNTO 0); -- DATA OUTPUT MEMORY DATA
     CLK, RST : IN STD_LOGIC;
     ADDRESS_MEM_INSTR, ADDRESS_MEM_DATA : OUT STD_LOGIC_VECTOR(63 DOWNTO 0); --ADDRESSES DATA AND INSTRUCTION MEMORY
     DATA_TOWRITE_MEM_DATA : OUT STD_LOGIC_VECTOR(63 DOWNTO 0); --DATA TO WRITE IN MEMORY DATA
     READ_MEM_DATA, WRITE_MEM_DATA,EN_ISTR_MEM : OUT STD_LOGIC);
END COMPONENT;

COMPONENT InstructionMemory IS
PORT(ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     CLK,EN_ISTR_MEM : IN STD_LOGIC;
     INSTRUCTION : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;

COMPONENT DataMemory IS
PORT(ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     WriteData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     CLK, RST, MemWrite, MemRead : IN STD_LOGIC;
     ReadData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;


---SIGNALS DATAPATH

SIGNAL INSTRUCTION : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL DATA_OUT_MEM_DATA, ADDRESS_MEM_INSTR, ADDRESS_MEM_DATA, DATA_TOWRITE_MEM_DATA : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL CLK,RST,  READ_MEM_DATA, WRITE_MEM_DATA : STD_LOGIC;
SIGNAL EN_IF_ID: STD_LOGIC;

--SIGNALS INSTRUCTION MEMORY

SIGNAL ADDRESS_INSTR_MEM_32 : STD_LOGIC_VECTOR(31 DOWNTO 0);

--SIGNALS DATA MEMORY

SIGNAL ADDRESS_MEM_DATA_32 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL READ_DATA_MEM_32, WRITE_DATA_MEM_32 : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN


ADDRESS_INSTR_MEM_32 <= ADDRESS_MEM_INSTR(31 DOWNTO 0);

ADDRESS_MEM_DATA_32 <= ADDRESS_MEM_DATA(31 DOWNTO 0);

WRITE_DATA_MEM_32 <= DATA_TOWRITE_MEM_DATA(31 DOWNTO 0);

DATA_OUT_MEM_DATA(31 DOWNTO 0) <= READ_DATA_MEM_32;
DATA_OUT_MEM_DATA(63 DOWNTO 32) <= (OTHERS=>READ_DATA_MEM_32(31));

INSTRUCTION_MEMORY : InstructionMemory PORT MAP(ADDRESS_INSTR_MEM_32, CLK,EN_IF_ID, INSTRUCTION);

PROCESSOR_DATAPATH : RISC_V PORT MAP(INSTRUCTION, DATA_OUT_MEM_DATA, CLK, RST, ADDRESS_MEM_INSTR, ADDRESS_MEM_DATA, DATA_TOWRITE_MEM_DATA, READ_MEM_DATA, WRITE_MEM_DATA,EN_IF_ID);

DATA_MEMORY : DataMemory PORT MAP (ADDRESS_MEM_DATA_32, WRITE_DATA_MEM_32, CLK, RST, WRITE_MEM_DATA, READ_MEM_DATA,
READ_DATA_MEM_32);

RST <= '1', '0' AFTER 8 NS;
process
  begin  
        CLK <= '1';
        wait for 5 NS;  
        CLK <= '0';
        wait for 5 NS;
  end process;

END ARCHITECTURE;
