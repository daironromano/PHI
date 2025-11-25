library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistema_top is
    Port ( 
        A, B   : in  STD_LOGIC_VECTOR (7 downto 0); -- Entradas dos dados [cite: 27]
        SEL    : in  STD_LOGIC;                     -- Seletor de troca [cite: 28]
        S1, S2 : out STD_LOGIC_VECTOR (6 downto 0)  -- Saídas para os displays [cite: 27]
    );
end sistema_top;

architecture Estrutural of sistema_top is

    -- Declaração do componente que criamos na Fase 1
    component conversor_7seg
        Port ( 
            dado_in : in  STD_LOGIC_VECTOR (7 downto 0);
            seg_out : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    -- Sinais internos para guardar o resultado da conversão antes de enviar para a saída
    signal conv_A : STD_LOGIC_VECTOR (6 downto 0);
    signal conv_B : STD_LOGIC_VECTOR (6 downto 0);

begin

    -- Instância 1: Converte a entrada A
    U1: conversor_7seg port map (
        dado_in => A,
        seg_out => conv_A
    );

    -- Instância 2: Converte a entrada B [cite: 26]
    U2: conversor_7seg port map (
        dado_in => B,
        seg_out => conv_B
    );

    -- Lógica de Multiplexação (SWAP) [cite: 29]
    -- Se SEL = 0: S1 mostra A, S2 mostra B
    -- Se SEL = 1: S1 mostra B, S2 mostra A
    S1 <= conv_A when SEL = '0' else conv_B;
    S2 <= conv_B when SEL = '0' else conv_A;

end Estrutural;