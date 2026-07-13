## Descrição

Este projeto consiste no exame da disciplina de Sistemas de Controle Contínuos e Discretos (CMC-12) do Instituto Tecnológico de Aeronáutica (ITA), ministrada pelo Prof. Marcos Máximo. O objetivo do projeto foi implementar o algoritmno CMA-ES para otimizar os ganhos do projeto do controlador de um multicóptero 3-DoF.

O projeto reaproveitou a dinâmica do sistema proposta pelo Prof. Marcos Máximo em um laboratório de sua disciplina, bem como arquivos base de implementação do sistema de controle e da simulação da dinâmica não-linear.

## Separação de arquivos

- `baseline`: arquivos reaproveitados do laboratório da disciplina para obter os ganhos analíticos projetados para cumprir requisitos das malhas consideradas desacopladas
- `cmaws`: implementação do algoritmo CMA-ES, baseada no artigo [The CMA Evolution Strategy: A Tutorial](https://arxiv.org/pdf/1604.00772), e modelagem da função de custo
- `planta`: parâmetros da planta e dos requisitos do sistema, aproveitados do laboratório da disciplina
- `simulacao`: Simulink com a simulação da dinâmica não-linear e definição de cenários de trajetórias de voo do multicóptero
- `utils`: funções auxiliares para gerar gráficos e animações das trajetórias de voo do multicóptero
- `otimizarControlador.m`: função principal para iniciar a execução do algoritmo e encontrar os ganhos ótimos do controlador

## Instruções de uso

Execute o script `otimizarControlador.m` para iniciar a execução do algoritmo CMA-ES e realizar simulações com os ganhos encontrados. Você pode alterar hiperparâmetros do algoritmo, como $$\sigma_0$$ e número máximo de iterações, e alterar os cenários de voo do multicóptero para analisaar cada simulação individualmente.

## Autores

**Alunos**: Arthur de Sousa Vianna, Matheus Lima Reis e João Victor Canedo Paranhos  
**Professor**: Prof. Marcos Máximo
