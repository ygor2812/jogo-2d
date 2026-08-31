
Aluno: Ygor de Andrade
Jogos Digitais II — Aula 04

## 1. As duas fases

Descreva cada fase em ~3 linhas: o tema, o que o jogador faz nela, e uma decisão de desenho que você tomou e o motivo.

Fase 0- Atividade anterior tema Inverno, o jogador tem que chegar ate o topo atravessando desafios de subida e pulos longos, escolhi esse tema por conta das 4 estações (Verão, Primavera, Outono e Inverno)

Fase 1 — tema Tropical, o jogador tem que atravessar alguns desafios de escalada e plataforma pra chegar no destino, escolhi esse tema por conta das 4 estações (Verão, Primavera, Outono e Inverno)

Fase 2 —Tema Verao/campo, o jogador tem que atravessar desafios de escalada ganhando altura ate chegar no destino final, escolhi o tema por conta das 4 estações (Verão, Primavera, Outono e Inverno)

## 2. O parallax
_Quais valores de `motion_scale` você usou em cada camada, e como chegou neles? O que mudou entre a primeira tentativa e a versão final?_

| Camada | motion_scale | Por que esse valor |
|--------|--------------|--------------------|
| (mais distante) x:0.3 y:0.0 porque eu achei mais agradavel
| (meio) x:0.5 y:0.1 porque eu achei mais agradavel
| (perto) x: 0.85 y:1.0 porque eu achei mais agradavel

Primeira tentativa: parallax nao subia junto com a camera e o motion ficava rapido demais
Atual:Funcional

## 3. A área secreta
_Onde está a pista, onde está a entrada, e por que você as separou desse jeito?_

- Pista : 2 flores (o mapa nao tinha flores ate entao)
- Entrada: parede falsa (sem fisica)
- Fiz Assim por ser mais facil e ser uma sala secreta classica
- O que tem lá dentro que justifica a procura: Uma maquina de refrigerante e uma cadeira

## 4. A câmera

_Qual das duas formas você escolheu (cena própria que acha o player pelo grupo, ou câmera filha do personagem), e o que perderia com a outra?_

- Forma escolhida: Cena Propria que acha o player pelo grupo
- Por quê:a ideia central é que ela nao fique "grudada" no player, assim podendo trocar de alvo no futuro.
- O que eu perderia com a outra: Flexibilidade da troca de alvo

## 5. A transição
Não dá pra trocar a cena no meio da detecção de colisão porque, nesse momento, o motor ainda está usando os nós da cena pra terminar o cálculo de física. Se você destrói a cena ali, causa um crash o motor.
## 6. O que travou

_A pergunta mais importante. Aponte um momento em que algo não funcionou: o que você achou que era a causa, o que era de verdade, e como descobriu. Se as duas coincidirem, diga isso — mas descreva o caminho.

- O que aconteceu: Parallax não seguia a camera.
- O que eu achei que era a causa: alguma configuração de repeat
- O que era de verdade: eu estava usando Parallax2D ao inves do parallaxBackground e parallaxLayer e o parallax2D tinha opções diferentes nas configurações dele.
- Como descobri: Assistindo um tutorial no youtube e lendo no PDF da Atividade.
