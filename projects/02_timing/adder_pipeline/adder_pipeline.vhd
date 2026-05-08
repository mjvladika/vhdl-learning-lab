library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_pipeline is
    port(
        clock      : in std_logic;
        first_num  : in std_logic_vector(7 downto 0);
        second_num : in std_logic_vector(7 downto 0);
        sum        : out std_logic_vector(8 downto 0) := "000000000"
    );
end entity;

architecture rtl of adder_pipeline is
    signal stage_one_first_num_remaining  : std_logic_vector(5 downto 0) := "000000";
    signal stage_one_second_num_remaining : std_logic_vector(5 downto 0) := "000000";
    signal stage_one_sum                  : std_logic_vector(1 downto 0) := "00";
    signal stage_one_carry                : std_logic := '0';
    signal stage_one_result               : std_logic_vector(2 downto 0) := "000";

    signal stage_two_first_num_remaining  : std_logic_vector(3 downto 0) := "0000";
    signal stage_two_second_num_remaining : std_logic_vector(3 downto 0) := "0000";
    signal stage_two_sum                  : std_logic_vector(1 downto 0) := "00";
    signal stage_two_carry                : std_logic := '0';
    signal stage_two_result               : std_logic_vector(2 downto 0) := "000";

    signal stage_three_first_num_remaining  : std_logic_vector(1 downto 0) := "00";
    signal stage_three_second_num_remaining : std_logic_vector(1 downto 0) := "00";
    signal stage_three_sum                  : std_logic_vector(1 downto 0) := "00";
    signal stage_three_carry                : std_logic := '0';
    signal stage_three_result               : std_logic_vector(2 downto 0) := "000";

    signal stage_four_sum    : std_logic_vector(1 downto 0) := "00";
    signal final_carry       : std_logic := '0';
    signal stage_four_result : std_logic_vector(2 downto 0) := "000";

    function two_bit_binary_add(num_one : std_logic_vector(1 downto 0); num_two : std_logic_vector(1 downto 0); carry : std_logic := 'U') return std_logic_vector is
        variable result      : std_logic_vector(2 downto 0);
        variable first_carry : std_logic;
    begin
        if(carry /= 'U') then
            result(0)   := num_one(0) xor num_two(0) xor carry;
            first_carry := (num_one(0) and num_two(0)) or (carry and (num_one(0) xor num_two(0)));
        else
            result(0)   := num_one(0) xor num_two(0);
            first_carry := num_one(0) and num_two(0);
        end if;

        result(1) := (num_one(1) xor num_two(1)) xor first_carry;
        result(2) := (num_one(1) and num_two(1)) or (first_carry and (num_one(1) xor num_two(1)));

        return result;
    end function;
begin
    process(clock)
    begin
        if(rising_edge(clock)) then

            -- Stage 4 looks at the Stage 3 registers and finishes the math. (Full-Adder, has carry)
            stage_four_result <= two_bit_binary_add(stage_three_first_num_remaining(1 downto 0), stage_three_second_num_remaining(1 downto 0), stage_three_carry);
            stage_four_sum    <= stage_four_result(1 downto 0);
            final_carry       <= stage_four_result(2);

            sum(8)          <= final_carry;
            sum(7 downto 6) <= stage_four_sum;

            --Stage 3 looks at the Stage 2 registers and does its math. (Full-Adder, has carry)
            stage_three_first_num_remaining  <= stage_two_first_num_remaining(3 downto 2);
            stage_three_second_num_remaining <= stage_two_second_num_remaining(3 downto 2);
            stage_three_result               <= two_bit_binary_add(stage_two_first_num_remaining(1 downto 0), stage_two_second_num_remaining(1 downto 0), stage_two_carry);
            stage_three_sum                  <= stage_three_result(1 downto 0);
            stage_three_carry                <= stage_three_result(2);

            sum(5 downto 4) <= stage_three_sum;

            -- Stage 2 looks at the Stage 1 registers and does its math. (Full-Adder, has carry)
            stage_two_first_num_remaining  <= stage_one_first_num_remaining(5 downto 2);
            stage_two_second_num_remaining <= stage_one_second_num_remaining(5 downto 2);
            stage_two_result               <= two_bit_binary_add(stage_one_first_num_remaining(1 downto 0), stage_one_second_num_remaining(1 downto 0), stage_one_carry);
            stage_two_sum                  <= stage_two_result(1 downto 0);
            stage_two_carry                <= stage_two_result(2);

            sum(3 downto 2) <= stage_two_sum;

            -- Stage 1 looks at the inputs and starts new math. (Half-Adder, no carry)
            stage_one_first_num_remaining  <= first_num(7 downto 2);
            stage_one_second_num_remaining <= second_num(7 downto 2);
            stage_one_result               <= two_bit_binary_add(first_num(1 downto 0), second_num(1 downto 0));            
            stage_one_sum                  <= stage_one_result(1 downto 0);
            stage_one_carry                <= stage_one_result(2);

            sum(1 downto 0) <= stage_one_sum;
        end if;
    end process;
end architecture;