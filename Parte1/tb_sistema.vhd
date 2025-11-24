library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;             -- Biblioteca para ler arquivos
use IEEE.STD_LOGIC_TEXTIO.ALL;  -- Biblioteca para manipular std_logic em arquivos

entity tb_sistema is
end tb_sistema;

architecture Sim of tb_sistema is

    -- Declaração do componente a ser testado (DUT)
    component sistema_top
        Port ( 
            A, B   : in  STD_LOGIC_VECTOR(3 downto 0);
            SEL    : in  STD_LOGIC;
            S1, S2 : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    -- Sinais para conectar no componente
    signal t_A, t_B   : STD_LOGIC_VECTOR(3 downto 0);
    signal t_SEL      : STD_LOGIC;
    signal t_S1, t_S2 : STD_LOGIC_VECTOR(6 downto 0);

    -- Definição dos arquivos de entrada e saída
    -- O arquivo entradas.txt deve estar na pasta do projeto!
    file arquivo_entrada : text open read_mode is "entradas.txt";
    file arquivo_saida   : text open write_mode is "resultados.txt";

begin

    -- Conecta os sinais do teste (t_...) às portas do sistema
    DUT: sistema_top port map (
        A   => t_A, 
        B   => t_B, 
        SEL => t_SEL, 
        S1  => t_S1, 
        S2  => t_S2
    );

    process
        variable linha_leitura : line;
        variable linha_escrita : line;
        variable var_A, var_B  : STD_LOGIC_VECTOR(3 downto 0);
        variable var_SEL       : STD_LOGIC;
    begin
        -- Loop que roda enquanto houver linhas no arquivo de texto
        while not endfile(arquivo_entrada) loop
            readline(arquivo_entrada, linha_leitura);
            
            -- Lê os valores da linha do arquivo
            read(linha_leitura, var_A);
            read(linha_leitura, var_B);
            read(linha_leitura, var_SEL);

            -- Aplica os valores no circuito
            t_A   <= var_A;
            t_B   <= var_B;
            t_SEL <= var_SEL;

            -- Espera o circuito processar a resposta
            wait for 10 ns;

            -- Prepara a linha para escrever no arquivo de resultados
            write(linha_escrita, string'("Entradas A="));
            write(linha_escrita, var_A);
            write(linha_escrita, string'(" B="));
            write(linha_escrita, var_B);
            write(linha_escrita, string'(" SEL="));
            write(linha_escrita, var_SEL);
            write(linha_escrita, string'(" | Saidas S1="));
            write(linha_escrita, t_S1);
            write(linha_escrita, string'(" S2="));
            write(linha_escrita, t_S2);
            
            -- Grava a linha no arquivo final
            writeline(arquivo_saida, linha_escrita);
        end loop;

        wait; -- Encerra a simulação
    end process;

end Sim;