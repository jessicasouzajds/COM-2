function [seq] = gerador(taps,estado)
  % chama-se (ex.): gerador([3 1],[1 0 0])
  % taps = local onde estao as derivacoes de realimentacao
  % estado = estado inicial (ex. 001, com tamanho m=3)

  m = length(estado);  % numero de flip flops
  pos = taps(2:end);   % posicao onde serao inseridos os registradores de deslocamento
  x=length(pos);       % Numero total de registradores de deslocamento
  T_max = 2^m -1;      % Periodo maximo, apos isso o valor da saida se repete
  c(1,:)=estado;       % Coloca na primeira linha de c o estado inicial do LFSR
   
  % varia k de acordo com o periodo maximo
  for k=1:T_max-1; 

      % faz sempre o primeiro xor, pois 1 é o minimo de registradores
      aux(1)=xor(estado(taps(1)), estado(taps(2)));
      if x>2;
          for i=1:x-1;
            aux(i+1)=xor(estado(pos(i+1)), aux(i));
          end
      end
      % A cada variacao, faz o deslocamento (shift circular) do resultado do xor para a entrada
      j=1:m-1;
      estado(m+1-j)=estado(m-j);
      estado(1)=aux(x);
      c(k+1,:)=estado;
  end
  seq=c(:,m)';   %pega só a ultima coluna com todas as linhas, que é a saida

end