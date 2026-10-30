# Normalização do modelo relacional

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**Fase do plano:** Fase 7 — Persistência
**Versão:** v1.0 · **Data:** 29/10/2026
**Objeto analisado:** as 15 relações de [`modelo-relacional.md`](modelo-relacional.md)

---

## 1. Objetivo e método

Demonstrar em que forma normal o modelo está, **onde ele deliberadamente não está** e por quê. A pergunta que este documento responde não é "o modelo é normalizado?", mas "toda redundância que existe é controlada e justificada?".

**Método.** Para cada relação, identificam-se as dependências funcionais (DF) a partir do significado das colunas, e verifica-se cada forma normal na ordem 1FN → 2FN → 3FN → BCNF. Depois, comparam-se as redundâncias encontradas com a lista de redundâncias **intencionais** da §6.

---

## 2. Dependências funcionais

Notação: `X → Y` significa "X determina Y". Chaves candidatas em **negrito**.

| Relação | Dependências funcionais | Chaves candidatas |
|---|---|---|
| `perfil` | `id → todas`; `nome → todas` | **id**, **nome** |
| `permissao` | `id → todas`; `codigo → todas` | **id**, **codigo** |
| `perfil_permissao` | `(id_perfil, id_permissao) → ∅` (sem atributo não-chave) | **(id_perfil, id_permissao)** |
| `usuario` | `id → todas`; `identificacao → todas` | **id**, **identificacao** |
| `area_atuacao` | `id → todas`; `nome → todas` | **id**, **nome** |
| `psicologo` | `id → todas`; `id_usuario → todas` (quando não nulo) | **id**, **id_usuario** |
| `psicologo_area_atuacao` | `(id_psicologo, id_area_atuacao) → ∅` | **(id_psicologo, id_area_atuacao)** |
| `paciente` | `id → todas`; `id_usuario → todas` (quando não nulo) | **id**, **id_usuario** |
| `vinculo` | `id → todas`; `(id_psicologo, id_paciente, vigente) → todas` | **id**, **(id_psicologo, id_paciente, vigente)** |
| `agenda` | `id → todas`; `id_psicologo → todas` | **id**, **id_psicologo** |
| `disponibilidade` | `id → todas`; `(id_agenda, data, hora_inicio) → todas`; `id_agenda → id_psicologo` | **id**, **(id_agenda, data, hora_inicio)** |
| `agendamento` | `id → todas`; `(id, id_psicologo, id_paciente)` é única; `slot_ativo → todas` quando não nulo; `id_disponibilidade → id_psicologo` | **id**, **slot_ativo** (parcial) |
| `atendimento` | `id → todas`; `id_agendamento → todas` (inclusive `id_psicologo`, `id_paciente`) | **id**, **id_agendamento** |
| `solicitacao_espera` | `id → todas`; `id_agendamento → todas` quando não nulo; `(id_disponibilidade, id_paciente, fila_ativa)` é única | **id** |
| `registro_auditoria` | `id → todas` | **id** |

As DFs marcadas em **negrito na coluna de DF** (`id_agenda → id_psicologo`, `id_disponibilidade → id_psicologo`, `id_agendamento → id_psicologo`/`id_paciente`) são as **únicas** que quebram a 3FN. Todas as demais relações estão em 3FN e BCNF.

---

## 3. Primeira forma normal (1FN)

**Requisito:** todo atributo é atômico; não há grupo repetido nem lista em uma coluna.

| Verificação | Resultado |
|---|---|
| Alguma coluna guarda lista, `JSON` ou texto delimitado com vários valores? | **Não.** O modelo não usa `JSON` nem `TEXT` com separadores |
| `contexto_sessao` é lista? | **Não.** É um texto único, limitado a 500 caracteres |
| `detalhe` de auditoria é lista? | **Não.** É um único motivo de falha |
| `psicologo` guarda várias áreas em uma coluna? | **Não.** As áreas vão para `psicologo_area_atuacao` |
| `perfil` guarda várias permissões em uma coluna? | **Não.** Vão para `perfil_permissao` |

**Conclusão: 1FN atendida em todas as 15 relações.** As duas decomposições que garantem isso são exatamente as tabelas associativas A02 e A05.

---

## 4. Segunda forma normal (2FN)

**Requisito:** todo atributo não-chave depende da **chave inteira**, não de parte dela.

| Relação com PK composta | Atributos não-chave | Dependência | Resultado |
|---|---|---|---|
| `perfil_permissao` | nenhum | — | 2FN trivial |
| `psicologo_area_atuacao` | nenhum | — | 2FN trivial |

**Todas as demais relações têm PK de um único atributo.** Com chave simples, não existe "parte da chave", e a 2FN é automaticamente satisfeita.

**Conclusão: 2FN atendida em todas as 15 relações.** O ponto que normalmente quebra a 2FN — uma associativa com atributos que dependem de apenas um dos lados — não ocorre porque **não há associativa com atributos** no modelo. Se `OfertaVaga` virar tabela (INC-17), ela terá `prazo_aceite` dependendo da oferta inteira, e não de um dos lados; continua em 2FN.

---

## 5. Terceira forma normal (3FN) e BCNF

**Requisito 3FN:** nenhum atributo não-chave determina outro atributo não-chave (sem dependência transitiva).
**Requisito BCNF:** todo determinante é chave candidata.

### 5.1 Relações em 3FN e BCNF

| Relação | Determinantes | Todos são chave candidata? |
|---|---|---|
| `perfil` | `id`, `nome` | sim |
| `permissao` | `id`, `codigo` | sim |
| `perfil_permissao` | a própria PK composta | sim |
| `usuario` | `id`, `identificacao` | sim |
| `area_atuacao` | `id`, `nome` | sim |
| `psicologo` | `id`, `id_usuario` | sim |
| `psicologo_area_atuacao` | a própria PK composta | sim |
| `paciente` | `id`, `id_usuario` | sim |
| `vinculo` | `id`, `(id_psicologo, id_paciente, vigente)` | sim |
| `agenda` | `id`, `id_psicologo` | sim |
| `registro_auditoria` | `id` | sim |
| `solicitacao_espera` | `id`, `id_agendamento` (quando não nulo) | sim |

**12 das 15 relações estão em BCNF.**

### 5.2 Relações com redundância intencional

| Relação | DF transitiva | Consequência |
|---|---|---|
| `disponibilidade` | `id_agenda → id_psicologo` | `id_psicologo` é derivável de `agenda` |
| `agendamento` | `id_disponibilidade → id_psicologo` | `id_psicologo` é derivável de `disponibilidade` |
| `atendimento` | `id_agendamento → (id_psicologo, id_paciente)` | as duas colunas são deriváveis de `agendamento` |

Essas três relações **não estão em 3FN** pela definição estrita. A §6 justifica por que a redundância foi mantida e por que ela **não produz anomalia**.

### 5.3 `slot_ativo` e as colunas geradas

`slot_ativo`, `vigente`, `fila_ativa` e `oferta_aberta` **não são redundâncias**: são colunas `GENERATED ALWAYS AS … STORED`. O SGBD as calcula a partir das colunas de origem e **recusa** qualquer `INSERT` ou `UPDATE` que tente atribuir valor a elas. Não existe estado em que a coluna gerada divirja da origem.

---

## 6. Redundâncias intencionais e o argumento da anomalia

### 6.1 A regra clássica

Uma redundância só causa anomalia de atualização se o valor duplicado puder ser alterado **independentemente** do original. Se o banco impede a divergência, a redundância é uma **materialização controlada**, não um defeito de normalização.

### 6.2 `disponibilidade.id_psicologo`

| Pergunta | Resposta |
|---|---|
| Por que existe? | Para permitir a FK composta `(id_agenda, id_psicologo) → agenda(id, id_psicologo)`, que garante RN-011 no banco |
| Pode divergir? | **Não.** A FK composta recusa um par inexistente em `agenda` |
| Há anomalia de atualização? | **Não.** `agenda.id_psicologo` é `ON UPDATE RESTRICT` e, por decisão, nunca muda (a agenda pertence a um titular) |
| Há anomalia de inserção? | **Não.** A coluna é obrigatória e vem do titular da agenda |
| Há anomalia de exclusão? | **Não.** Nenhuma das duas colunas é apagada |
| Custo | ~8 bytes por slot + 1 índice |
| Ganho | RN-011 deixa de depender de código de aplicação |

### 6.3 `agendamento.id_psicologo` e `atendimento.(id_psicologo, id_paciente)`

Mesmo raciocínio:

| Coluna | DF de origem | FK que amarra | Regra protegida |
|---|---|---|---|
| `agendamento.id_psicologo` | `id_disponibilidade → id_psicologo` | `(id_disponibilidade, id_psicologo) → disponibilidade(id, id_psicologo)` | RN-018 |
| `atendimento.id_psicologo` | `id_agendamento → id_psicologo` | `(id_agendamento, id_psicologo, id_paciente) → agendamento(id, id_psicologo, id_paciente)` | RN-017, RN-019 |
| `atendimento.id_paciente` | `id_agendamento → id_paciente` | idem | RN-017, RN-019 |

**O que aconteceria se as colunas fossem removidas.** As regras passariam a depender de `JOIN` de três níveis na aplicação (`atendimento → agendamento → disponibilidade → agenda`) em cada escrita. A probabilidade de um caminho de escrita esquecer a verificação é maior do que a probabilidade de a FK composta falhar.

### 6.4 A alternativa normalizada

Para quem preferir 3FN estrita, a versão sem redundância é:

```
disponibilidade (id, id_agenda, data, hora_inicio, duracao_minutos, criado_em)
agendamento     (id, id_disponibilidade, id_paciente, situacao, ...)
atendimento     (id, id_agendamento, data_hora_registro, contexto_sessao)
```

e a coerência passa a ser verificada por *trigger* ou por código. **A decisão do DER é a versão com FK composta**, porque o plano pede explicitamente integridade referencial e porque a alternativa troca uma restrição declarativa por código imperativo.

---

## 7. Quarta e quinta formas normais (4FN e 5FN)

**Requisito 4FN:** nenhuma dependência multivalorada (DMV) não trivial.
**Requisito 5FN:** nenhuma dependência de junção não trivial.

O modelo **não tem DMV** porque as duas situações em que ela apareceria foram decompostas:

| Situação | Sem decomposição (violaria 4FN) | Como está |
|---|---|---|
| Um psicólogo tem várias áreas **e** vários vínculos | uma tabela `psicologo` com duas listas independentes | `psicologo` + `psicologo_area_atuacao` + `vinculo` |
| Um perfil tem várias permissões **e** vários usuários | uma tabela `perfil` com duas listas independentes | `perfil` + `perfil_permissao` + `usuario` |

**Conclusão: 4FN e 5FN atendidas.** As tabelas associativas não são apenas resolução de N:N — são também a decomposição que elimina as DMVs.

---

## 8. Redundâncias **rejeitadas**

Estas foram consideradas e recusadas. Registrá-las evita que reapareçam como "otimização".

| Redundância proposta | Por que foi rejeitada |
|---|---|
| `agendamento.nome_paciente` para listar a agenda sem `JOIN` | o nome muda; a agenda passaria a mostrar nome antigo. O `JOIN` com `paciente` é barato e há índice |
| `agendamento.data_hora_inicio` copiado do slot | segunda fonte de verdade para o tempo (INC-15); o slot é a autoridade (DEC-018) |
| `solicitacao_espera.posicao` materializada | teria de ser reescrita a cada entrada, saída, recusa ou expiração; inconsistente sob concorrência. Calculada por `COUNT(*)` com índice |
| `agenda.id_agendamento` | inverteria a FK de A17 e criaria ciclo; o slot já é o ponto de junção |
| `vinculo.ativo` booleano separado de `situacao` | duas colunas para o mesmo estado. A coluna gerada `vigente` resolve sem duplicar |
| `paciente.idade` | envelhece sozinha; derivada da data de nascimento (que também não está no modelo — P-21) |
| `atendimento.quantidade_sessoes` no paciente | contador agregado que diverge a cada exclusão lógica; calculado por `COUNT(*)` |
| tabela `historico_situacao` | DEC-024 decidiu que a trilha fica em `registro_auditoria`; uma tabela por entidade multiplicaria esquemas idênticos |
| `registro_auditoria.usuario_nome` | cópia do nome do responsável; a FK + `JOIN` mantém o nome atual. Para o nome **histórico**, o correto seria versionar `usuario`, o que está fora do escopo |

---

## 9. Resumo

| Forma normal | Relações conformes | Relações com exceção declarada |
|---|---|---|
| 1FN | 15 de 15 | — |
| 2FN | 15 de 15 | — |
| 3FN | 12 de 15 | `disponibilidade`, `agendamento`, `atendimento` (§6) |
| BCNF | 12 de 15 | as mesmas três |
| 4FN | 15 de 15 | — |
| 5FN | 15 de 15 | — |

**Conclusão.** O modelo está em **3FN/BCNF com três desnormalizações controladas**, todas do mesmo tipo: repetir uma coluna que é determinada por uma FK, para permitir que uma **FK composta** garanta no banco uma regra que, de outra forma, dependeria de código. Nenhuma das três pode divergir; todas estão amarradas por restrição declarativa. As demais redundâncias usuais foram avaliadas e rejeitadas (§8), e as colunas derivadas que existem são **geradas pelo SGBD** (§5.3), não mantidas pela aplicação.

---

## 10. Referências

- [`modelo-relacional.md`](modelo-relacional.md) §4 — restrições por tabela
- [`dicionario-de-dados.md`](dicionario-de-dados.md) §4.3 — colunas geradas
- [`der/der-001-logico.md`](der/der-001-logico.md) §4.4 — FK compostas de coerência
- [`mapeamento-objeto-relacional.md`](mapeamento-objeto-relacional.md) §4 — atributos derivados
