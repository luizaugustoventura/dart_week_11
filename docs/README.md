## Informações prévias

1. Para que seja possível executar as funcionalidades do aplicativo corretamente, é necessário ter o **Json Rest Server** na versão **1.5.10** ou mais recente. O Json Rest Server vai simular um backend trabalhando com as operações de CRUD sobre arquivos *.json*.
Para instalar o Json Rest Server como um pacote global, execute o seguinte comando:
`dart pub global activate json_rest_server`
*Obs.: Caso você tenha o Json Rest Server em uma versão mais antiga, basta executar o seguinte comando:*
`jsr upgrade`
ou
`json_rest_server upgrade`
2. Com o Json Rest Server instalado globalmente, é necessário criar um projeto. Para criar o projeto, execute o seguinte comando juntamente com o diretório onde o projeto será criado (no meu caso: "."):
`json_rest_server create .`
3. Por fim, para executar o Json Rest Server, basta navegar até a pasta do projeto e executar o seguinte comando:
`json_rest_server run`

## Executando aplicação

1. Execute o backend com o **Json Rest Server**
2. Para que o aplicativo consiga acessar o backend do **Json Rest Server**, certifique-se de que o IP utilizado no arquivo do REST Client em *dw_barbershop/lib/src/core/restClient/rest_client.dart* seja igual ao da sua máquina, uma vez que o emulador Android faz parte de outra rede
3. Antes de executar a aplicação de fato, é necessário executar o **build_runner**, já que o **Riverpod** faz uso de geração de código. Para executar o build_runner, basta entrar na pasta do projeto (*dw_barbershop*) e executar o seguinte comando:
`dart run build_runner watch -d`
4. Agora chegou a hora de executar a aplicação

## SDK e versões

No decorrer deste projeto, foram utilizados:
* Dart 3.1.0
* Flutter 3.13.0