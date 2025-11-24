library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade: Define a "caixa preta"
entity conversor_7seg is
    Port ( 
        dado_in : in  STD_LOGIC_VECTOR (3 downto 0); -- Entrada de 4 bits (0-F)
        seg_out : out STD_LOGIC_VECTOR (6 downto 0)  -- Saída gfedcba (7 segmentos)
    );
end conversor_7seg;

architecture Comportamental of conversor_7seg is
begin
    process(dado_in)
    begin
        case dado_in is
            -- Preencham a tabela com a lógica do display (0 aceso, 1 apagado ou vice-versa dependendo da placa)
            -- Exemplo para display anodo comum (0 acende): "gfedcba"
            when "0000" => seg_out <= "1000000"; -- 0 (g apagado)
            when "0001" => seg_out <= "1111001"; -- 1 (b,c acesos)
            when "0010" => seg_out <= "0100100"; -- 2 (a,b,d,e,g acesos)
            when "0011" => seg_out <= "0110000"; -- 3 (a,b,c,d,g acesos)
            when "0100" => seg_out <= "0011001"; -- 4 (b,c,f,g acesos)
            when "0101" => seg_out <= "0010010"; -- 5 (a,c,d,f,g acesos)
            when "0110" => seg_out <= "0000010"; -- 6 (tudo menos b)
            when "0111" => seg_out <= "1111000"; -- 7 (a,b,c acesos)
            when "1000" => seg_out <= "0000000"; -- 8 (todos acesos)
            when "1001" => seg_out <= "0010000"; -- 9 (tudo menos e)
            
            -- Letras Hexadecimais (A-F)
            when "1010" => seg_out <= "0001000"; -- A (tudo menos d)
            when "1011" => seg_out <= "0000011"; -- b (minúsculo, para diferenciar do 8)
            when "1100" => seg_out <= "1000110"; -- C (a,d,e,f acesos)
            when "1101" => seg_out <= "0100001"; -- d (minúsculo, para diferenciar do 0)
            when "1110" => seg_out <= "0000110"; -- E (a,d,e,f,g acesos)
            when "1111" => seg_out <= "0001110"; -- F (a,e,f,g acesos)
				
            when others => seg_out <= "1111111"; -- Apaga tudo (erro)
        end case;
    end process;
end Comportamental;