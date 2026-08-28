#!/usr/bin/env bash
set -euo pipefail

if [[ ! -d "framework" ]]; then
  echo "Execute este script na raiz do repositório Framework-product-with-AI." >&2
  exit 1
fi

echo "Atualizando framework..."

mkdir -p "$(dirname "framework/README.md")"
cat > framework/README.md <<'__FRAMEWORK_EOF__'
# AI-Assisted Product Engineering Framework

Um framework enxuto para estruturar, desenvolver e evoluir software com agentes de IA usando contexto, arquitetura e critérios claros.

A ideia central é simples: **não pedir para a IA "criar o projeto completo" nem improvisar a próxima etapa**. O produto mantém fontes canônicas versionadas, o escopo atual é decomposto em slices verticais e cada slice passa por especificação, plano, implementação e verificação.

## Fluxo

```text
Ideia / Necessidade / Evolução
      ↓
Pesquisa / Validação, quando necessária
      ↓
PRD principal e/ou PRDs especializados
      ↓
System Design
      ↓
ADRs
      ↓
Engineering Principles
      ↓
Design System / UX/UI
      ↓
AGENTS.md
      ↓
Slices Definition
      ↓
────────────────────────────
 LOOP DE ENTREGA POR SLICE
────────────────────────────
      ↓
SPEC
 ↓
PLAN
 ↓
Implementação
 ↓
Testes + Validação + Segurança
 ↓
Review
 ↓
Merge
      ↺ próximo Slice
────────────────────────────
      ↓
Deploy
      ↓
Observabilidade + Feedback
      ↓
Evolução do Produto
      ↺ novas necessidades atualizam as fontes adequadas
```

## Regra mais importante

As conversas, brainstorming e pesquisas existem para amadurecer decisões. As decisões que precisam sobreviver ao histórico devem terminar em fontes versionadas no repositório.

Em um produto novo, normalmente existe um PRD principal em `docs/product/PRD.md`.

Conforme o produto evolui, `docs/product/` pode conter PRDs especializados para domínios, capacidades, funcionalidades ou frentes específicas.

O PRD principal governa o contexto global. Os PRDs especializados refinam suas respectivas áreas.

Nenhuma etapa deve assumir que existe apenas um PRD.

## Como usar

### Produto novo

1. Entenda a ideia e pesquise/valide as hipóteses relevantes.
2. Crie e aprove o PRD principal.
3. Gere o System Design.
4. Registre ADRs somente para decisões arquiteturais relevantes.
5. Defina Engineering Principles.
6. Gere o Design System/UX quando aplicável.
7. Crie o `AGENTS.md` apontando para as fontes canônicas.
8. Defina os slices do escopo atual.
9. Para cada slice: `SPEC → PLAN → IMPLEMENT → TEST/VALIDATE/SECURITY → REVIEW → MERGE`.

### Produto existente

1. Leia `AGENTS.md` e as fontes canônicas.
2. Identifique o escopo da mudança.
3. Atualize ou crie PRD especializado somente quando a mudança funcional exigir.
4. Atualize System Design/ADR/Design apenas quando suas respectivas decisões mudarem.
5. Derive os slices necessários para o novo escopo.
6. Execute o mesmo loop por slice.

Não recrie documentos que continuam válidos apenas para reiniciar o processo.

Veja [QUICKSTART.md](QUICKSTART.md) para os pontos de entrada e [FRAMEWORK.md](FRAMEWORK.md) para a definição completa.

## Estrutura deste repositório

```text
docs/       explicação curta de cada etapa
templates/  modelos dos artefatos canônicos
prompts/    prompts prontos para executar cada etapa
```

## Filosofia

- simples por padrão;
- rigor somente onde reduz risco real;
- documentação serve ao desenvolvimento, não o contrário;
- produto antes de código;
- fontes canônicas são descobertas pelo agente, não presumidas por nome único;
- slices são verticais e orientados a comportamento observável;
- especificar somente o slice atual;
- agentes só concluem quando os gates de conclusão passam;
- decisões importantes ficam no repositório, não apenas no histórico do chat;
- o framework deve funcionar tanto na criação quanto na evolução contínua do produto.

## Status

`v0.1` — primeira versão prática. Use em projetos reais, anote atritos e refine o framework a partir de evidência.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/FRAMEWORK.md")"
cat > framework/FRAMEWORK.md <<'__FRAMEWORK_EOF__'
# Framework de Engenharia de Produto Assistida por IA

Este documento define o fluxo canônico do framework.

O fluxo não precisa começar sempre na primeira etapa. Em projetos existentes, entre no ponto correspondente à necessidade atual e preserve as fontes canônicas que continuam válidas.

## 1. Ideia / Necessidade de Produto

Comece pela necessidade como ela existe, mesmo incompleta.

Em produto novo, isso pode ser uma ideia ainda em formação.

Em produto existente, pode ser uma nova capacidade, mudança de comportamento, evolução de domínio, correção estrutural ou nova etapa de entrega.

**Saída:** contexto suficiente para decidir se pesquisa, PRD ou outra fonte canônica precisa ser criada ou alterada.

## 2. Pesquisa / Validação

Use pesquisa externa quando disponível e relevante para confrontar hipóteses sobre dor, alternativas, concorrência, comportamento, mercado, restrições e viabilidade.

Pesquisa não precisa virar artefato permanente. Ela serve para amadurecer decisões que depois serão registradas na fonte canônica adequada.

**Saída:** decisão suficientemente informada para atualizar a definição do produto.

## 3. PRDs de Produto

PRDs transformam decisões funcionais em definição versionada do produto.

O projeto pode possuir:

- um PRD principal, normalmente `docs/product/PRD.md`, responsável pela visão global, problema, público, proposta, core loop, escopo e regras gerais;
- PRDs especializados em `docs/product/`, responsáveis por detalhar domínios, capacidades, funcionalidades ou frentes específicas.

O conjunto dos PRDs relevantes forma a fonte funcional do produto.

O PRD principal governa o contexto global. PRDs especializados refinam suas respectivas áreas.

Não crie um PRD especializado quando uma alteração pequena puder ser representada com clareza no documento já existente.

Depois de aprovadas, essas fontes substituem a necessidade de carregar eternamente brainstorming e pesquisa anteriores.

**Artefatos:** `docs/product/*.md`

## 4. System Design

Desenha tecnicamente o sistema como um todo a partir dos PRDs relevantes: módulos, boundaries, fluxos, persistência, integrações, requisitos não funcionais, segurança e evolução.

Em produto existente, atualize somente quando a arquitetura vigente realmente mudar.

**Artefato:** `docs/architecture/SYSTEM-DESIGN.md`

## 5. ADRs

Registre apenas decisões arquiteturais relevantes com alternativas e trade-offs reais.

ADR não é diário de implementação e não deve existir para toda escolha pequena.

**Artefato:** `docs/architecture/adr-XXX-*.md`

## 6. Engineering Principles

Define como equipe e agentes devem pensar a implementação: linguagem de domínio, boundaries, padrões permitidos, anti-overengineering, testes, validação, segurança e quando criar ADRs.

**Artefato:** `docs/engineering/PRINCIPLES.md`

## 7. Design System / UX/UI

Define a fonte de verdade de UX/UI: princípios, comportamento responsivo, design tokens, componentes, estados, acessibilidade e direção visual.

Atualize somente quando decisões de experiência ou linguagem visual realmente mudarem.

**Artefato:** `DESIGN.md`

## 8. AGENTS.md

É o entrypoint dos agentes.

Deve ser curto. Sua função é apontar para as fontes canônicas, definir autoridade entre documentos e estabelecer regras operacionais de implementação e verificação.

O `AGENTS.md` deve orientar o agente a descobrir os PRDs relevantes dentro de `docs/product/`, sem assumir uma única fonte funcional.

**Artefato:** `AGENTS.md`

## 9. Slices Definition

Antes de implementar um escopo relevante, derive das fontes canônicas o mapa de slices necessário para aquela etapa de entrega.

Slice é a menor capacidade vertical que:

- entrega comportamento observável ao usuário ou ao sistema;
- pode ser testada de ponta a ponta;
- atravessa apenas as camadas necessárias;
- é pequena o bastante para receber uma SPEC própria.

Não criar slices como Banco, API, Frontend, Auth ou Worker.

Infraestrutura entra no primeiro slice que realmente precisar dela.

**Artefato:** `docs/delivery/SLICES.md`

## 10. Loop de Entrega por Slice

Para cada slice, execute sempre:

```text
Slice atual
  ↓
SPEC
  ↓
PLAN
  ↓
IMPLEMENTAÇÃO
  ↓
TESTES + VALIDAÇÃO + SEGURANÇA
  ↓
REVIEW
  ↓
MERGE
  ↺ próximo Slice
```

### SPEC

Define o comportamento e os critérios de aceite do slice atual, sem escolher implementação desnecessariamente.

### PLAN

Transforma a SPEC aprovada em tarefas técnicas incrementais e testáveis considerando o estado real do repositório.

### Implementação

Executa o plano sem expandir o escopo.

### Testes + Validação + Segurança

Prova comportamento e invariantes relevantes.

Verifica testes, typecheck, lint, build e demais gates aplicáveis.

### Review

Primeiro confira conformidade com a SPEC.

Depois confira qualidade de código, arquitetura, Principles, Design e segurança aplicáveis.

### Merge

Só ocorre quando o slice está realmente concluído.

## 11. Deploy

Quando o escopo planejado estiver pronto e verificado, publique através do processo apropriado ao projeto.

Nem toda entrega precisa necessariamente resultar em deploy imediato; siga a estratégia real do projeto.

## 12. Observabilidade + Feedback

Observe erros, comportamento real, uso e feedback.

A observabilidade deve responder problemas reais do produto e operação, não existir como decoração de engenharia.

## 13. Evolução do Produto

Feedback pode voltar para diferentes pontos:

- mudança de produto → PRD principal ou PRD especializado correspondente;
- mudança arquitetural → System Design + ADR quando necessário;
- mudança visual/UX → DESIGN;
- nova capacidade → fontes funcionais relevantes + novo mapa de slices;
- mudança local de implementação → SPEC/PLAN quando não altera fontes superiores.

O framework é um loop de evolução, não uma sequência descartada após a primeira entrega.

## Autoridade dos documentos

| Fonte | Governa |
|---|---|
| PRD principal | contexto global, produto e regras funcionais gerais |
| PRD especializado | domínio/capacidade funcional específica dentro de sua fronteira |
| `SYSTEM-DESIGN.md` | arquitetura vigente |
| ADR aceito | decisão arquitetural específica |
| `PRINCIPLES.md` | regras permanentes de engenharia |
| `DESIGN.md` | UX/UI |
| `SLICES.md` | decomposição macro do escopo atual |
| `SPEC.md` | comportamento do slice atual |
| `PLAN.md` | estratégia de implementação do slice atual |
| Código + testes | implementação real, que deve permanecer compatível com as fontes acima |

Uma fonte mais específica refina a fonte global dentro de sua fronteira, mas não pode contradizê-la silenciosamente.

Conflitos relevantes não devem ser resolvidos silenciosamente pelo agente.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/QUICKSTART.md")"
cat > framework/QUICKSTART.md <<'__FRAMEWORK_EOF__'
# Quickstart

O framework possui pontos de entrada diferentes conforme o estado real do projeto.

## Produto ainda é uma ideia

Use os prompts em ordem:

```text
01-ideia-pesquisa-validacao.md
02-criar-prd.md
03-criar-system-design.md
04-criar-adrs.md
05-criar-principles.md
06-criar-design-system.md
07-criar-agents.md
08-definir-slices.md
```

Depois comece o loop por slice:

```text
09-criar-spec.md
10-criar-plan.md
11-implementar-slice.md
12-review-verificar-slice.md
```

## Projeto já possui definição funcional aprovada

Não recrie o PRD apenas para seguir a sequência do framework.

Leia os PRDs existentes em `docs/product/` e entre na primeira etapa que ainda precisa ser criada ou atualizada.

Exemplos:

```text
PRDs prontos, sem arquitetura
→ 03-criar-system-design.md

Arquitetura pronta, novo escopo funcional
→ atualizar/criar PRD relevante
→ atualizar arquitetura/ADR se necessário
→ 08-definir-slices.md

Fontes canônicas continuam válidas e há novo escopo já definido
→ 08-definir-slices.md

Slices já definidos
→ 09-criar-spec.md
```

O histórico anterior aos documentos canônicos não precisa ser reconstruído quando eles já contêm contexto suficiente.

## Regra de entrada

Não execute etapas anteriores apenas por cerimônia.

Antes de começar:

1. leia `AGENTS.md`, quando existir;
2. descubra as fontes canônicas existentes;
3. identifique o escopo atual;
4. determine qual é a primeira decisão ou artefato realmente ausente/desatualizado;
5. continue o fluxo a partir dali.

O framework deve preservar contexto válido, não recriá-lo.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/prompts/02-criar-prd.md")"
cat > framework/prompts/02-criar-prd.md <<'__FRAMEWORK_EOF__'
# Prompt — Criar ou Atualizar PRD

Com base na definição, pesquisa, validação e fontes já existentes, determine primeiro qual decisão funcional precisa ser registrada.

Leia `AGENTS.md`, quando existir, e descubra todos os PRDs já existentes em `docs/product/`.

## Decida o tipo de alteração

### PRD principal

Use o PRD principal quando estiver definindo ou alterando contexto global do produto, como visão, problema, público, proposta de valor, core loop, escopo geral ou regras funcionais transversais.

O caminho padrão é:

`docs/product/PRD.md`

### PRD especializado

Crie ou atualize um PRD especializado quando uma área relevante do produto precisar de detalhamento próprio sem inflar o PRD principal.

Exemplos:

- domínio específico;
- capability relevante;
- fluxo complexo;
- integração de produto;
- operação especializada;
- comportamento funcional que mereça fronteira documental própria.

Use nome descritivo e siga a convenção existente em `docs/product/`.

Não crie PRD especializado para qualquer detalhe pequeno.

## Regras

O documento deve ser autossuficiente dentro de sua responsabilidade e não depender do histórico da conversa para ser compreendido.

Inclua somente o que for útil para construir ou evoluir o produto:

- problema/contexto;
- objetivo;
- comportamento esperado;
- escopo deste PRD;
- requisitos e regras;
- não objetivos;
- critérios de sucesso/aceite quando aplicáveis;
- riscos e hipóteses ainda abertas.

Quando for especializado, deixe clara sua relação com o PRD principal e não repita desnecessariamente definições globais.

Não escolha stack tecnológica nem faça System Design neste documento.

Não altere silenciosamente outro PRD para resolver conflito. Se encontrar contradição material entre fontes funcionais, registre o conflito para revisão.

Ao final, revise se o documento representa corretamente sua fronteira funcional e se contém contexto suficiente para agentes diferentes utilizá-lo nas próximas etapas.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/prompts/03-criar-system-design.md")"
cat > framework/prompts/03-criar-system-design.md <<'__FRAMEWORK_EOF__'
# Prompt — Criar ou Atualizar System Design

Leia `AGENTS.md` se existir.

Descubra e leia **todos os PRDs relevantes em `docs/product/`** para o escopo atual. Não assuma que `docs/product/PRD.md` é a única fonte funcional.

Leia também System Design e ADRs existentes, quando houver.

Crie ou atualize `docs/architecture/SYSTEM-DESIGN.md` com a arquitetura técnica integrada necessária para sustentar o produto e o escopo atual.

Defina, conforme aplicável:

- módulos/domínios e boundaries;
- fluxos principais;
- persistência;
- integrações;
- autenticação e autorização;
- processamento assíncrono;
- requisitos não funcionais;
- segurança;
- observabilidade necessária;
- evolução já conhecida que afete fronteiras arquiteturais atuais.

Projete para o produto real e para as necessidades atuais.

Antecipe apenas fronteiras futuras cuja existência já seja relevante para evitar acoplamento incorreto. Não implemente infraestrutura especulativa.

Em projeto existente, preserve decisões válidas e altere somente o que a nova necessidade realmente exigir.

Não crie ADRs ainda. Ao final, liste somente decisões relevantes com alternativas e trade-offs que mereçam ADR separado.

Se PRDs relevantes entrarem em conflito material, não escolha uma interpretação silenciosamente: registre o conflito e pare para revisão.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/prompts/04-criar-adrs.md")"
cat > framework/prompts/04-criar-adrs.md <<'__FRAMEWORK_EOF__'
# Prompt — Criar ADRs

Leia `AGENTS.md` quando existir, os PRDs relevantes em `docs/product/`, `docs/architecture/SYSTEM-DESIGN.md` e ADRs já aceitos.

Identifique apenas decisões arquiteturais relevantes com alternativas e trade-offs reais.

Para cada nova decisão necessária, crie um ADR em:

`docs/architecture/adr-XXX-<slug>.md`

Cada ADR deve conter:

- Context;
- Decision;
- Alternatives Considered;
- Positive Consequences;
- Negative Consequences;
- Related.

Não crie ADR para:

- detalhes locais de implementação;
- preferências pessoais;
- decisões reversíveis de baixo impacto;
- decisões já plenamente governadas por outro ADR.

Em projeto existente, não recrie ADRs apenas para documentar novamente decisões já aceitas.

Ao final, verifique se System Design e ADRs formam uma arquitetura coerente com os PRDs relevantes.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/prompts/05-criar-principles.md")"
cat > framework/prompts/05-criar-principles.md <<'__FRAMEWORK_EOF__'
# Prompt — Criar ou Atualizar Engineering Principles

Leia `AGENTS.md` quando existir, os PRDs relevantes em `docs/product/`, System Design e ADRs aceitos.

Crie ou atualize `docs/engineering/PRINCIPLES.md` com regras práticas e duráveis para implementação neste projeto.

Defina somente princípios que mereçam orientar múltiplos slices, como:

- linguagem de domínio;
- boundaries;
- uso pragmático de patterns;
- orientação contra overengineering;
- validação e segurança;
- abordagem de testes;
- critérios para criação de novos ADRs.

Não copie a arquitetura inteira.

Não inclua detalhes de libraries, arquivos ou implementações locais que não representem princípio durável.

Em projeto existente, preserve princípios válidos e altere apenas o que a evolução real do projeto exigir.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/prompts/06-criar-design-system.md")"
cat > framework/prompts/06-criar-design-system.md <<'__FRAMEWORK_EOF__'
# Prompt — Criar ou Atualizar Design System / UX/UI

Leia `AGENTS.md` quando existir, os PRDs relevantes em `docs/product/`, System Design, ADRs e Principles relevantes.

Crie ou atualize `DESIGN.md` como fonte de verdade de UX/UI do produto.

Defina, conforme aplicável:

- contexto de uso;
- princípios;
- direção visual;
- responsividade;
- navegação;
- tokens;
- tipografia;
- espaçamento;
- componentes conceituais;
- estados;
- acessibilidade;
- motion.

Projete para o público e comportamento real descritos nas fontes funcionais relevantes.

Mantenha complexidade por trás e simplicidade na frente.

Em projeto existente, preserve decisões visuais válidas e altere somente o que o novo escopo exigir.

Não duplique detalhes de backend ou decisões técnicas que pertencem ao System Design ou ADRs.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/prompts/07-criar-agents.md")"
cat > framework/prompts/07-criar-agents.md <<'__FRAMEWORK_EOF__'
# Prompt — Criar AGENTS.md

Leia as fontes canônicas existentes do projeto.

Crie um `AGENTS.md` curto que funcione como entrypoint dos agentes.

Ele deve definir:

1. como descobrir e em qual ordem ler as fontes canônicas;
2. que `docs/product/` pode conter PRD principal e PRDs especializados;
3. autoridade de PRDs, System Design, ADRs, Principles, Design, Slices, SPEC e PLAN;
4. regras operacionais essenciais;
5. como lidar com conflito relevante;
6. validações obrigatórias antes de declarar implementação concluída.

Não replique o conteúdo dos documentos.

Não fixe desnecessariamente nomes de PRDs especializados.

A função do `AGENTS.md` é rotear o agente até as fontes corretas e explicitar autoridade, não duplicar contexto.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/prompts/08-definir-slices.md")"
cat > framework/prompts/08-definir-slices.md <<'__FRAMEWORK_EOF__'
# Prompt — Definir Development Slices

Analise o projeto atual e crie o mapa completo de Development Slices necessários para implementar o escopo definido para a etapa atual do projeto.

Antes de definir qualquer slice, leia `AGENTS.md` e todas as fontes canônicas indicadas nele.

Descubra e leia **todos os PRDs existentes em `docs/product/`** que sejam relevantes para o escopo atual.

O projeto pode possuir:

- um PRD principal de produto, responsável pela visão global, core loop, escopo e regras gerais;
- PRDs especializados, responsáveis por detalhar domínios, capacidades, funcionalidades ou frentes específicas do mesmo produto.

Trate o conjunto desses documentos como fonte funcional do produto.

O PRD principal governa o contexto e as regras globais. PRDs especializados refinam suas respectivas áreas e devem ser considerados sempre que forem relevantes para o escopo sendo decomposto.

Não assuma que todos os requisitos existentes nos PRDs precisam fazer parte da etapa atual. Identifique primeiro qual escopo está sendo trabalhado e derive apenas os slices necessários para entregá-lo.

Se houver conflito material entre fontes canônicas, não o resolva silenciosamente. Registre o conflito e pare para revisão antes de derivar comportamento incompatível.

## Objetivo

Decompor o escopo atual em uma sequência coerente de **vertical slices orientados a comportamento real do usuário ou capacidade observável do sistema**.

Um slice deve ser pequeno o suficiente para um agente compreender completamente seu contexto e grande o suficiente para entregar uma capacidade real e testável.

## Regras

- não criar slices por camada técnica;
- não criar slices chamados `Database`, `Frontend`, `API`, `Auth`, `Worker` ou equivalentes;
- infraestrutura entra no primeiro slice que realmente necessitar dela;
- cada slice deve terminar em comportamento observável e verificável;
- não criar SPEC, PLAN ou código nesta etapa;
- não adicionar funcionalidades fora do escopo atual;
- identificar dependências reais entre slices;
- ordenar pela sequência mais lógica e segura de entrega;
- reutilizar a linguagem de domínio do projeto;
- considerar requisitos distribuídos entre PRD principal e PRDs especializados;
- não tratar ausência de um requisito no PRD principal como exclusão automática quando ele estiver definido por um PRD especializado compatível;
- não incluir automaticamente requisitos futuros apenas porque aparecem em algum PRD;
- preservar boundaries e decisões já estabelecidas pelas fontes canônicas.

## Formato

### Slice XXX — Nome

**Outcome:** ...  
**Depends On:** ...  
**Domain Areas:** ...  
**Scope:** ...  
**Out of Scope:** ...

## Validação

Ao final, crie uma matriz:

`Requisito/capacidade → PRD de origem → Slice responsável`

Confirme que:

- todo o escopo selecionado possui um slice responsável;
- nenhum requisito relevante ficou sem cobertura;
- nenhum slice existe apenas para entregar uma camada técnica;
- nenhum requisito fora do escopo atual foi introduzido indevidamente.

Crie `docs/delivery/SLICES.md` e pare para revisão. Não inicie a próxima etapa do fluxo automaticamente.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/prompts/09-criar-spec.md")"
cat > framework/prompts/09-criar-spec.md <<'__FRAMEWORK_EOF__'
# Prompt — Criar SPEC do Slice Atual

Leia `AGENTS.md`, as fontes canônicas e `docs/delivery/SLICES.md`.

Selecione somente o próximo slice aprovado ainda sem SPEC, respeitando suas dependências e o estado real do repositório.

Crie:

`docs/specs/<slice>/SPEC.md`

A SPEC deve definir:

- Outcome;
- contexto;
- In Scope;
- Out of Scope;
- comportamentos;
- regras e invariantes;
- validações e erros;
- estados de UX relevantes;
- segurança/autorização aplicável;
- critérios de aceite verificáveis.

Regras:

- não implemente;
- não escreva PLAN;
- não antecipe slices futuros;
- não invente decisões ausentes;
- SPEC define comportamento, não implementação;
- siga a terminologia e os boundaries das fontes canônicas.

Após criar a SPEC, revise-a com os agentes ou especialidades relevantes quando estiverem disponíveis.

Se houver reprovação, corrija a SPEC e submeta novamente à revisão.

Repita até obter `APPROVED`.

Quando aprovada, execute o prompt `10-criar-plan`.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/prompts/10-criar-plan.md")"
cat > framework/prompts/10-criar-plan.md <<'__FRAMEWORK_EOF__'
# Prompt — Criar PLAN do Slice Atual

Leia `AGENTS.md`, as fontes canônicas, `docs/delivery/SLICES.md` e a SPEC aprovada do slice atual.

Crie:

`docs/specs/<slice>/PLAN.md`

O PLAN deve definir como implementar integralmente a SPEC no estado real atual do repositório.

Inclua somente o necessário para o slice:

- passos de implementação;
- áreas/componentes afetados;
- persistência ou migrations quando necessárias;
- segurança e autorização;
- tratamento de erros;
- estratégia de testes;
- validações finais.

Regras:

- não implemente código;
- não expanda o escopo da SPEC;
- não antecipe slices futuros;
- respeite System Design, ADRs e Engineering Principles;
- prefira a menor solução correta;
- não introduza infraestrutura ou abstrações especulativas.

Após criar o PLAN, revise-o com os agentes ou especialidades relevantes quando estiverem disponíveis.

Se houver reprovação, corrija o PLAN e submeta novamente à revisão.

Repita até obter `APPROVED`.

Quando aprovado, execute o prompt `11-implementar-slice`.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/templates/AGENTS.md")"
cat > framework/templates/AGENTS.md <<'__FRAMEWORK_EOF__'
# AGENTS.md

Antes de implementar:

1. descubra e leia os PRDs relevantes em `docs/product/`;
2. leia `docs/architecture/SYSTEM-DESIGN.md` — arquitetura vigente;
3. leia `docs/architecture/adr-*.md` relevantes — decisões arquiteturais aceitas;
4. leia `docs/engineering/PRINCIPLES.md` — regras de engenharia;
5. leia `DESIGN.md` quando houver impacto de UX/UI;
6. leia `docs/delivery/SLICES.md` — mapa macro do escopo atual;
7. leia `docs/specs/<slice>/SPEC.md` e `PLAN.md`, quando existirem — contrato e plano do slice atual.

## PRDs

`docs/product/` pode conter:

- `PRD.md` como PRD principal;
- PRDs especializados para domínios, capacidades ou frentes específicas.

Não assuma que existe apenas um PRD.

Leia somente os especializados relevantes ao escopo atual, além do contexto global necessário.

## Autoridade

- PRD principal governa contexto global, produto e regras funcionais gerais.
- PRD especializado governa sua fronteira funcional específica sem contradizer silenciosamente o principal.
- ADR aceito governa a decisão específica que registra.
- System Design representa a arquitetura vigente.
- Principles governa práticas permanentes de engenharia.
- Design governa UX/UI.
- SLICES governa a decomposição macro do escopo atual.
- SPEC governa o comportamento do slice atual.
- PLAN governa sua estratégia de implementação.

Em conflito relevante, não invente uma resolução silenciosa.

## Regras operacionais

- preserve o escopo atual;
- implemente verticalmente, um slice por vez;
- não introduza patterns ou infraestrutura por preferência;
- crie ou atualize ADR antes de mudar trade-off arquitetural relevante;
- não altere fontes canônicas apenas para justificar uma implementação;
- não recrie fontes que continuam válidas;
- antes de concluir, execute testes, typecheck, lint, build e demais verificações aplicáveis;
- reporte explicitamente o que não pôde ser executado.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/templates/PRD.md")"
cat > framework/templates/PRD.md <<'__FRAMEWORK_EOF__'
# PRD — <Produto / Capacidade>

## 1. Papel deste PRD

<Indique se este é o PRD principal do produto ou um PRD especializado e qual fronteira ele governa.>

## 2. Contexto / Visão

<Definição curta do produto, capacidade ou frente coberta por este documento.>

## 3. Problema

<Problema real que será resolvido.>

## 4. Público / Atores

<Quem usa ou é afetado e em qual contexto.>

## 5. Proposta de valor / Resultado esperado

<Resultado central entregue.>

## 6. Fluxo ou Core Loop relevante

```text
<Ação → resultado → próxima ação>
```

## 7. Escopo deste PRD

- ...

## 8. Requisitos e regras principais

- ...

## 9. Não objetivos

- ...

## 10. Métricas, critérios de sucesso ou aceite

- ...

## 11. Riscos e hipóteses abertas

- ...

## 12. Relação com outras fontes

<PRD principal, PRDs especializados relacionados e outras fontes canônicas que delimitam este documento, quando aplicável.>
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/templates/SYSTEM-DESIGN.md")"
cat > framework/templates/SYSTEM-DESIGN.md <<'__FRAMEWORK_EOF__'
# System Design — <Produto>

## 1. Contexto e objetivos

<Quais necessidades funcionais e restrições arquiteturais este design sustenta.>

## 2. Fontes funcionais

<PRD principal e PRDs especializados relevantes.>

## 3. Arquitetura geral

<Visão dos módulos, domínios e boundaries.>

## 4. Fluxos principais

<Fluxos técnicos relevantes de ponta a ponta.>

## 5. Persistência e dados

<Entidades, ownership, consistência e armazenamento em nível arquitetural.>

## 6. Integrações

<Dependências e sistemas externos.>

## 7. Autenticação e autorização

<Modelo de acesso quando aplicável.>

## 8. Processamento assíncrono

<Jobs, filas e workers quando necessários.>

## 9. Requisitos não funcionais

<Segurança, confiabilidade, performance, disponibilidade e observabilidade relevantes.>

## 10. Evolução e boundaries futuras

<Preparações justificadas por necessidades conhecidas, sem infraestrutura especulativa.>

## 11. Decisões que exigem ADR

- ...
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/templates/SLICES.md")"
cat > framework/templates/SLICES.md <<'__FRAMEWORK_EOF__'
# Development Slices

## Escopo

<Defina qual etapa, capacidade, release ou conjunto de requisitos este mapa de slices cobre.>

## Regras

- slices orientados a comportamento observável;
- nenhum slice por camada técnica;
- dependências explícitas;
- todos os requisitos pertencentes ao escopo atual devem estar cobertos;
- requisitos futuros fora do escopo não entram automaticamente;
- SPEC/PLAN somente just-in-time.

## Slice 001 — <Nome>

**Outcome**  
O usuário ou sistema consegue...

**Depends On**  
None

**Domain Areas**  
...

**Scope**

- ...

**Out of Scope**

- ...

## Matriz de cobertura

| Requisito/capacidade | PRD de origem | Slice |
|---|---|---|
| ... | ... | ... |
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/docs/02-prd.md")"
cat > framework/docs/02-prd.md <<'__FRAMEWORK_EOF__'
# PRDs de Produto

PRD registra decisões funcionais que precisam sobreviver ao histórico da conversa.

Um projeto pode possuir um PRD principal e PRDs especializados.

## PRD principal

Governa visão global, problema, público, proposta de valor, core loop, escopo e regras funcionais transversais.

Caminho convencional:

`docs/product/PRD.md`

## PRDs especializados

Detalham domínios, capacidades, funcionalidades ou frentes que precisam de espaço próprio sem transformar o PRD principal em um documento monolítico.

Ficam em:

`docs/product/`

com nomes descritivos coerentes com o projeto.

## Regra

Não assuma que toda decisão funcional deve entrar no PRD principal.

Também não crie um PRD novo para cada detalhe.

Use a menor fronteira documental que mantenha o produto compreensível e versionado.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/docs/03-system-design.md")"
cat > framework/docs/03-system-design.md <<'__FRAMEWORK_EOF__'
# System Design

O System Design traduz as fontes funcionais relevantes em arquitetura técnica integrada.

Ele deve considerar o conjunto de PRDs aplicáveis ao escopo atual, e não apenas um arquivo específico.

Define, em nível arquitetural:

- módulos e domínios;
- boundaries;
- fluxos principais;
- persistência;
- integrações;
- autenticação/autorização;
- processamento assíncrono;
- requisitos não funcionais;
- segurança;
- observabilidade necessária;
- evolução conhecida que afete decisões atuais.

Em projeto existente, não reescreva a arquitetura por cerimônia.

Atualize o System Design quando a arquitetura vigente realmente mudar.

Decisões com alternativas e trade-offs relevantes devem ser registradas em ADRs.
__FRAMEWORK_EOF__

mkdir -p "$(dirname "framework/docs/08-slices.md")"
cat > framework/docs/08-slices.md <<'__FRAMEWORK_EOF__'
# Slices Definition

Defina o mapa de slices necessário para o escopo atual antes de iniciar sua implementação.

O escopo pode representar uma primeira entrega, uma nova capacidade, uma evolução de domínio, uma release ou qualquer outro recorte coerente de trabalho.

Um slice é a menor capacidade vertical que entrega comportamento observável e pode ser verificada de ponta a ponta.

Exemplo bom:

> O usuário consegue cadastrar um produto e encontrá-lo novamente.

Exemplos ruins:

- Criar banco;
- Criar API;
- Criar frontend;
- Implementar repository layer.

Infraestrutura deve entrar no primeiro slice que realmente precisar dela.

Defina os slices no nível macro do escopo atual, mas crie SPEC e PLAN somente quando cada slice se tornar o próximo a ser implementado.

O mapa deve apontar de quais PRDs cada requisito veio para facilitar cobertura e rastreabilidade.
__FRAMEWORK_EOF__

if [[ -f "framework/templates/MVP-SLICES.md" ]]; then
  rm "framework/templates/MVP-SLICES.md"
fi

echo "Concluído."
echo "Revise com: git diff -- framework"
echo "Depois rode seus checks habituais antes de commitar."
