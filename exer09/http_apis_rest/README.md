# HTTP e Consumo de APIs REST

App Flutter que consome duas APIs públicas:

- **ViaCEP** — consulta de endereço a partir do CEP, com preenchimento automático.
- **PokeAPI** — consulta de dados de um Pokémon pelo nome.

## Como rodar

```bash
flutter pub get
flutter run
```

## Permissão de internet (Android)

Adicione a linha abaixo em `android/app/src/main/AndroidManifest.xml`,
como filho direto da tag `<manifest>` (fora da tag `<application>`):

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

## Estrutura

```
lib/
  main.dart                 # App + navegação em abas (CEP / Pokémon)
  models/
    endereco.dart           # Modelo ViaCEP com fromJson
    pokemon.dart             # Modelo PokeAPI com fromJson
  services/
    api_service.dart        # Requisições HTTP, timeout de 10s, tratamento de erros
    api_exceptions.dart     # Exceptions customizadas (timeout, sem conexão, servidor, não encontrado)
  screens/
    cep_screen.dart         # Tela de consulta de CEP
    pokemon_screen.dart     # Tela de consulta de Pokémon
```

## Testando o tratamento de erros

- **CEP inválido**: digite menos de 8 dígitos, ou letras -> erro de validação local, sem chamar a API.
- **CEP inexistente**: digite 8 dígitos que não correspondem a nenhum CEP real (ex: `99999999`) -> "CEP não encontrado".
- **Pokémon inexistente**: digite um nome que não existe (ex: `pokemonfake`) -> "Pokémon não encontrado".
- **SocketException**: ative o modo avião e tente buscar -> "Sem conexão com a internet".
- **TimeoutException**: mais difícil de simular manualmente; pode-se reduzir o timeout no código para 1ms temporariamente e testar contra uma API real, ou usar um proxy que atrase a resposta.

## Relatório

Veja `RELATORIO.md` para a análise do tratamento de erros (Parte 2 da atividade).
