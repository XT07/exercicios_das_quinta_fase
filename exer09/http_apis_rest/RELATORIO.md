# Relatório de Tratamento de Erros

**App:** Consumo de APIs REST (ViaCEP + PokeAPI)

## 1. Erros tratados e sua importância

O app trata quatro categorias de erro na camada `ApiService`, cada uma
convertida em uma exceção customizada (`ApiException`) com mensagem
amigável, para que a interface não precise conhecer detalhes de rede.

### TimeoutException
Ocorre quando a requisição não recebe resposta dentro do limite de
10 segundos definido com `.timeout(Duration(seconds: 10))`. É importante
tratar esse caso porque, em uma rede lenta ou instável, uma requisição
pode nunca terminar. Sem um timeout explícito, o app ficaria esperando
indefinidamente, travando a experiência do usuário.

### SocketException
Ocorre quando o dispositivo não consegue nem estabelecer conexão com o
servidor — por exemplo, sem Wi-Fi, sem dados móveis, ou em modo avião.
É um dos erros mais comuns em uso real de um app mobile, já que o
usuário está constantemente entrando e saindo de áreas com cobertura.

### Status HTTP diferente de 200
Mesmo quando a conexão funciona, o servidor pode responder com um erro
(ex: 500 Internal Server Error, 503 Service Unavailable) ou, no caso da
PokeAPI, 404 quando o recurso não existe. Tratar isso evita que o app
tente processar como sucesso uma resposta que na verdade é uma falha,
o que causaria erros de parsing mais adiante.

### Caso especial: CEP/Pokémon não encontrado
A API ViaCEP tem uma particularidade: quando o CEP não existe, ela
responde com status HTTP 200, mas com o corpo `{"erro": true}`. Por
isso essa checagem é feita manualmente após o parse do JSON, e não
apenas pelo status code. Já a PokeAPI segue o padrão REST e retorna
404 para Pokémon inexistente.

## 2. Como o usuário é informado

Todas as telas seguem o mesmo padrão de feedback:

- Durante a requisição, um `CircularProgressIndicator` é exibido e o
  botão de busca fica desabilitado, deixando claro que algo está
  em andamento e evitando múltiplos cliques.
- Se a requisição falhar, um card vermelho com ícone de erro e a
  mensagem específica da exceção é exibido no lugar do resultado
  (ex: "Sem conexão com a internet. Verifique sua rede e tente
  novamente.").
- Se a requisição tiver sucesso, o card de erro desaparece e os
  dados (endereço ou Pokémon) são exibidos.
- A validação do CEP (8 dígitos numéricos) acontece antes de qualquer
  chamada de rede, evitando requisições desnecessárias e dando
  feedback imediato ao usuário.

## 3. Situações reais para cada erro

- **Timeout**: usuário em uma área com sinal de celular fraco (ex:
  dentro de um elevador ou subsolo) tenta consultar um CEP.
- **SocketException**: usuário ativa o modo avião durante um voo e
  esquece de desativar ao tentar usar o app depois.
- **Status HTTP de erro**: a PokeAPI está passando por manutenção ou
  sofre uma instabilidade temporária e responde com 503.
- **CEP/Pokémon não encontrado**: usuário digita um CEP com um dígito
  errado, ou o nome de um Pokémon com erro de digitação.

## 4. Comportamento sem o tratamento

Sem os `try-catch` e o `timeout`, os seguintes problemas ocorreriam:

- Uma `TimeoutException` ou `SocketException` não capturada subiria
  como exceção não tratada, derrubando a tela com um erro vermelho
  do Flutter (ou, em release, fechando o app de forma abrupta), sem
  nenhuma explicação para o usuário sobre o que aconteceu.
- Sem timeout definido, uma requisição travada deixaria o
  `CircularProgressIndicator` girando para sempre, dando a impressão
  de que o app "travou".
- Sem checar o status HTTP, o app tentaria fazer `jsonDecode` em um
  corpo de erro (ou em um HTML de página de erro genérica), lançando
  uma exceção de parsing confusa e sem relação aparente com o
  problema real (rede, servidor).
- No caso específico do ViaCEP, sem checar o campo `"erro": true`, o
  app tentaria exibir um endereço com todos os campos vazios,
  fazendo parecer que a busca funcionou quando na verdade o CEP
  não existe — um erro silencioso, mais perigoso que uma falha
  visível, porque o usuário não percebe que algo deu errado.
