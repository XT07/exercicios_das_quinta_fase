# Versão QUEBRADA — Aula 11

⚠️ Este app foi feito propositalmente errado.

Problemas intencionais:
- Column + SingleChildScrollView
- GridView(children)
- Image.network sem cache
- Imagens grandes
- Rebuilds desnecessários
- Tema exagerado

🎯 Missão dos alunos:
- Aplicar ListView.builder / GridView.builder
- Usar cached_network_image
- Reduzir rebuilds
- Melhorar FPS
- Justificar melhorias com DevTools
---

## O que foi corrigido (Aula 11)

1. **Column + SingleChildScrollView → ListView.builder**
   Renderizava os 200 itens de uma vez, mesmo fora da tela. `ListView.builder` constrói só o que está visível (+ margem), sob demanda.

2. **GridView(children: [...]) → GridView.builder**
   Mesmo problema do item 1, mas no grid.

3. **Image.network sem cache → CachedNetworkImage**
   Antes, toda vez que o widget reconstruía, a imagem era baixada de novo. Agora ela é salva em cache (memória/disco) e reaproveitada.

4. **Imagens grandes → memCacheWidth / URLs redimensionadas**
   As imagens agora pedem/decodificam no tamanho real exibido em tela (300–400px), não 800x600 para um espaço pequeno.

5. **Rebuilds desnecessários → MyApp virou StatelessWidget**
   Havia um `counter` no estado que não aparecia em lugar nenhum da UI, mas todo `setState()` reconstruía a árvore inteira. Sem uso real do estado, a tela virou stateless.

6. **Tema exagerado → tema sóbrio**
   Removido o `fontSize: 20` fixo no `bodyMedium` e o `primarySwatch` berrante; usado `colorSchemeSeed` com Material 3.

Bônus: o `onTap` das opções chamava `runApp()` de novo (reiniciava o app inteiro) em vez de `Navigator.push` (navegação real).

### Como medir a melhoria no DevTools
- Abra a aba **Performance** e ligue o **Track widget builds**.
- Compare o número de widgets construídos ao abrir a tela: antes, ~200 de cada vez; depois, só os visíveis.
- Na aba **Memory**, veja o uso de imagem: antes cada imagem 800x600 decodificada ocupa muito mais RAM que a versão redimensionada.
- No overlay de **Performance (FPS)**, o scroll deve ficar consistentemente perto de 60fps na versão otimizada, com quedas visíveis na versão quebrada.
