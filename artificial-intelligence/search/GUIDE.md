#Introdução
O projeto Pac-Man foi desenvolvido na Universidade de Berkeley para a disciplina de Introdução à Inteligência Artificial. A ideia do projeto é aplicar algumas técnicas clássicas de IA para jogar Pac-Man. O foco do projeto não é desenvolver IA para vídeo games, mas servir como ferramenta de apoio para o ensino e aprendizagem de conceitos fundamentais de IA. Esses conceitos são amplamente usados para resolver problemas no mundo real, tais como processamento de língua natural, visão computacional, aprendizagem automática e robótica.

Neste trabalho, o agente Pacman tem que encontrar caminhos no labirinto, tanto para chegar a um destino quanto para coletar comida eficientemente. O objetivo do trabalho será programar algoritmos de busca e aplicá-los ao cenário do Pacman.

##Arquivos que devem ser editados:

- `search.py`: onde ficam os algoritmos de busca.
- `searchAgents.py`: onde ficam os agentes baseados em busca.

## Arquivos que devem ser lidos:

- `pacman.py`: o arquivo principal que roda jogos de Pacman. Esse arquivo também descreve o tipo GameState, que será amplamente usado nesse trabalho.
- `game.py`: a lógica do mundo do Pacman. Este arquivo descreve vários tipos auxiliares como AgentState, Agent, Direction e Grid.
- `util.py`: estruturas de dados úteis para implementar algoritmos de busca.

## Arquivos que podem ser ignorados:

- `graphicsDisplay.py`: visualização gráfica do Pacman
- `graphicsUtils.py`: funções auxiliares para visualização gráfica do Pacman
- `textDisplay.py`: visualização gráfica em ASCII para o Pacman
- `ghostAgents.py`: agentes para controlar fantasmas
- `keyboardAgents.py`: interfaces de controle do Pacman a partir do teclado
- `layout.py`: código para ler arquivos de layout e guardar seu conteúdo

Nessa primeira aula prática vamos implementar três algoritmos de busca não informada (**busca em profundidade, busca em largura e busca de custo uniforme**).

## Encontrando comida em um ponto fixo usando algoritmos de busca

Passo 1 (2 pontos) Implemente o algoritmo de busca em profundidade (DFS) na função depthFirstSearch do arquivo search.py. Para que a busca seja completa complete, implemente a versão de DFS que não expande estados repetidos (seção 3.5 do livro).

Teste seu código executando:

python pacman.py -l tinyMaze -p SearchAgent
python pacman.py -l mediumMaze -p SearchAgent
python pacman.py -l bigMaze -z .5 -p SearchAgent
A saída do Pacman irá mostrar os estados explorados e a ordem em que eles foram explorados (vermelho mais forte significa que o estado foi explorado antes). (Pergunta 1)A ordem de exploração foi de acordo com o esperado? O Pacman realmente passa por todos os estados explorados no seu caminho para o objetivo?

Dica: Se você usar a pilha Stack como estrutura de dados, a solução encontrada pelo algoritmo DFS para o mediumMaze deve ter comprimento 130 (se os sucessores forem colocados na pilha na ordem dada por getSuccessors; pode ter comprimento 246 se forem colocados na ordem reversa). (Pergunta 2) Essa é uma solução ótima? Senão, o que a busca em profundidade está fazendo de errado?

Passo 2 (2 pontos) Implemente o algoritmo de busca em extensão (BFS) na função breadthFirstSearch do arquivo search.py. De novo, implemente a versão que não expande estados que já foram visitados. Teste seu código executando:

python pacman.py -l mediumMaze -p SearchAgent -a fn=bfs
python pacman.py -l bigMaze -p SearchAgent -a fn=bfs -z .5
(Pergunta 3) A busca BFS encontra a solução ótima? Senão, verifique a sua implementação. Se o seu código foi escrito de maneira correta, ele deve funcionar também para o quebra-cabeças de 8 peças (seção 3.2 do livro-texto) sem modificações.

python eightpuzzle.py
## Variando a função de custo
A busca BFS vai encontrar o caminho com o menor número de ações até o objetivo. Porém, podemos querer encontrar caminhos que sejam melhores de acordo com outros critérios. Considere o labirinto mediumDottedMaze e o labirinto mediumScaryMaze. Mudando a função de custo, podemos fazer o Pacman encontrar caminhos diferentes. Por exemplo, podemos ter custos maiores para passar por áreas com fantasmas e custos menores para passar em áreas com comida, e um agente Pacman racional deve poder ajustar o seu comportamento.

Passo 3 (2 pontos) Implemente o algoritmo de busca de custo uniforme (checando estados repetidos) na função uniformCostSearch do arquivo search.py. Teste seu código executando os comandos a seguir, onde os agentes têm diferentes funções de custo (os agentes e as funções são dados):

python pacman.py -l mediumMaze -p SearchAgent -a fn=ucs
python pacman.py -l mediumDottedMaze -p StayEastSearchAgent
python pacman.py -l mediumScaryMaze -p StayWestSearchAgent
## A* search
Passo 4 (2 pontos) Implemente a busca A* (com checagem de estados repetidos) na função aStarSearch do arquivo search.py. A busca A* recebe uma heurística como parâmetro. Heurísticas têm dois parâmetros: um estado do problema de busca (o parâmetro principal), e o próprio problema. A heurística implementada na função nullHeuristic do arquivo search.py é um exemplo trivial.

Teste sua implementação de A* no problema original de encontrar um caminho através de um labirinto para uma posição fixa usando a heurística de distância Manhattan (implementada na função manhattanHeuristic do arquivo searchAgents.py).

python pacman.py -l bigMaze -z .5 -p SearchAgent -a fn=astar,heuristic=manhattanHeuristic
A busca A* deve achar a solução ótima um pouco mais rapidamente que a busca de custo uniforme (549 vs. 621 nós de busca expandidos na nossa implementação). (Pergunta 4) O que acontece em openMaze para as várias estratégias de busca?

Coletando comida
Agora iremos atacar um problema mais difícil: fazer o Pacman comer toda a comida no menor número de passos possível. Para isso, usaremos uma nova definição de problema de busca que formaliza esse problema: FoodSearchProblem no arquivo searchAgents.py (já implementado). Uma solução é um caminho que coleta toda a comida no mundo do Pacman. A solução não será modificada se houverem fantasmas no caminho; ela só depende do posicionamento das paredes, da comida e do Pacman. Se os seus algoritmos de busca estiverem corretos, A* com uma heurística nula (equivalente a busca de custo uniforme) deve encontrar uma solução para o problema testSearch sem nenhuma mudança no código (custo total de 7).

python pacman.py -l testSearch -p AStarFoodSearchAgent
Nota: AStarFoodSearchAgent é um atalho para -p SearchAgent -a fn=astar,prob=FoodSearchProblem,heuristic=foodHeuristic.

Porém, a busca de custo uniforme fica lenta até para problemas simples como tinySearch.

Passo 5 (2 pontos) Implemente uma heurística admissível foodHeuristic no arquivo searchAgents.py para o problema FoodSearchProblem. Teste seu agente no problema trickySearch:

python pacman.py -l trickySearch -p AStarFoodSearchAgent
Glossário de Objetos
Este é um glossário dos objetos principais na base de código relacionada a problemas de busca:

SearchProblem (search.py)

Um SearchProblem é um objeto abstrato que representa o espaço de estados, função sucessora, custos, e estado objetivo de um problema. Você vai interagir com objetos do tipo SearchProblem somente através dos métodos definidos no topo de search.py

PositionSearchProblem (searchAgents.py)

Um tipo específico de SearchProblem --- corresponde a procurar por uma única comida no labirinto.

FoodSearchProblem (searchAgents.py)

Um tipo específico de SearchProblem --- corresponde a procurar um caminho para comer toda a comida em um labirinto.

Função de Busca

Uma função de busca é uma função que recebe como entrada uma instância de SearchProblem, roda algum algoritmo, e retorna a sequência de ações que levam ao objetivo. Exemplos de função de busca são depthFirstSearch e breadthFirstSearch, que deverão ser escritas pelo grupo. A função de busca dada tinyMazeSearch é uma função muito ruim que só funciona para o labirinto tinyMaze

SearchAgent

SearchAgent é uma classe que implementa um agente (um objeto que interage com o mundo) e faz seu planejamento de acordo com uma função de busca. SearchAgent primeiro usa uma função de busca para encontrar uma sequência de ações que levem ao estado objetivo, e depois executa as ações uma por vez.