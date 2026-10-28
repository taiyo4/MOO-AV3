#!/usr/bin/env python3
"""Monta 07-dossie/dossie.md a partir das seções preparadas pelos integrantes.

Responsável: Integrante 6 (documentação e integração).

Uso, a partir da raiz do repositório:

    python3 07-dossie/montar-dossie.py

O script não altera nenhum arquivo de origem. Ele:
1. lê as seções em 07-dossie/secoes/ na ordem do dossiê;
2. gera as tabelas de glossário, RF, RNF, RN e HU diretamente de 02-requisitos/,
   para que o dossiê nunca diverja da baseline oficial do Integrante 1;
3. insere, logo abaixo do título de cada seção, as notas de integração do
   Integrante 6 (NOTAS_INTEGRACAO), que apontam onde o texto de origem ficou
   desatualizado em relação a decisões aprovadas depois da sua redação;
4. grava 07-dossie/dossie.md.
"""

import re
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SECOES = RAIZ / "07-dossie" / "secoes"
REQ = RAIZ / "02-requisitos"
SAIDA = RAIZ / "07-dossie" / "dossie.md"

VERSAO = "v0.6"
DATA = "28/10/2026"

# Ordem das partes do dossiê: (arquivo, primeira seção a aproveitar).
PARTES = [
    ("fases1-4-secao-01-17.md", 1),
    ("fase5-secao-18-20-27.md", 18),
    ("fase6-secao-21-24.md", 21),
    ("fases7-9-secao-25-36.md", 25),
]

TITULOS = {
    1: "Capa", 2: "Resumo", 3: "Equipe e funções",
    4: "Contexto e situação-problema", 5: "Objetivos",
    6: "Escopo, fronteiras e escopo negativo", 7: "Premissas e restrições",
    8: "Stakeholders e atores", 9: "Glossário", 10: "Decisões do projeto",
    11: "Diagrama de contexto", 12: "Requisitos funcionais",
    13: "Requisitos não funcionais", 14: "Regras de negócio",
    15: "Histórias de usuário e critérios de aceite",
    16: "Diagrama de casos de uso", 17: "Especificações de casos de uso",
    18: "Modelo de domínio", 19: "Diagrama de classes", 20: "Diagrama de objetos",
    21: "Diagramas de sequência", 22: "Diagrama de comunicação",
    23: "Diagrama de atividades", 24: "Máquina de estados",
    25: "Arquitetura: pacotes, componentes e implantação",
    26: "Persistência: DER, modelo relacional, dicionário e mapeamento objeto-relacional",
    27: "Princípios OO e SOLID", 28: "Plano de qualidade (ISO/IEC 25010:2023)",
    29: "Normas aplicadas", 30: "Autoavaliação do processo",
    31: "Matriz de rastreabilidade", 32: "Verificação de consistência e revisões",
    33: "Conclusão", 34: "Limitações e próximos passos", 35: "Referências",
    36: "Anexos",
}

ORIGEM = {
    **{n: "Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/)" for n in range(1, 18)},
    **{n: "Integrante 2 (Fase 5)" for n in (18, 19, 20, 27)},
    **{n: "Integrante 2 (Fase 6)" for n in (21, 22, 23, 24)},
    25: "Integrante 4 (Fase 7, a produzir)", 26: "Integrante 4 (Fase 7, a produzir)",
    **{n: "Integrante 5 (resumo de 05-qualidade/)" for n in (28, 29, 30)},
    31: "Integrantes 1, 2 e 5", 32: "Integrante 6 (consolidação)",
    **{n: "Integrante 6 + grupo (Fase 9)" for n in (33, 34, 35, 36)},
}

NOTAS_INTEGRACAO = {
    18: [
        "O texto cita **RF-001 a RF-032**; desde 25/10/2026 a baseline vai até **RF-037** (RF-033 e-mail, RF-034 a RF-036 lista de espera, RF-037 não comparecimento).",
        "A linha \"Notificação e sessão fora do domínio\" trata **DEC-009 como pendente**; ela foi aprovada em 25/10/2026.",
        "As multiplicidades \"fechadas na Fase 5\" eram da proposta CLS-001 v2 (retirada do repositório em 28/10/2026); o diagrama oficial do Integrante 3 ainda tem `PENDENTE` (Q5-01, INT-09).",
        "A lista de espera (DEC-010) ainda não tem conceito no domínio (Q5-05).",
    ],
    19: [
        "Na proposta CLS-001 v2 (retirada em 28/10/2026) e no oficial, conforme o caso, o enumerado `SituacaoAgendamento` ainda contém `SOLICITADO`; pela **DEC-016** os valores são apenas `CONFIRMADO`, `CANCELADO`, `REALIZADO` e `NAO_COMPARECEU` (Q5-02).",
        "A guarda de `podeSerCancelado()` (\"situação atual + prazo\") deve ser lida como **\"antes do horário marcado\"** (DEC-011); o prazo de 2 horas não foi adotado e não há antecedência mínima (DEC-028, 28/10/2026).",
        "Atributos e tipos ainda incompletos no diagrama (Q5-08).",
    ],
    20: [
        "O objeto de notificação é descrito \"enquanto DEC-009 não for decidida\"; DEC-009 foi aprovada em 25/10/2026, e a notificação continua sendo objeto de aplicação, não classe de domínio (DEC-022, aprovada em 28/10/2026).",
    ],
    21: [
        "A SEQ-002 mostra o agendamento criado como `SOLICITADO` e depois confirmado; pela **DEC-016** o agendamento já nasce `Confirmado` (Q6-01).",
        "As referências a **DEC-009 (pendente)** e **DEC-012 (pendente)** estão superadas: DEC-009 foi aprovada; o cancelamento vale \"antes do horário marcado\" (DEC-011), e a DEC-028 (28/10/2026) confirma que não há antecedência adicional.",
        "A sequência da lista de espera (SEQ-004) ainda não existe; com a DEC-010 aprovada e os parâmetros da fila decididos (DEC-027, 28/10/2026), ela deixou de estar bloqueada (Q6-05).",
    ],
    22: [
        "A notificação aparece como fronteira **condicional**; desde a DEC-009 ela é obrigatória para confirmação, cancelamento e oferta de vaga (Q6-04).",
    ],
    23: [
        "O diagrama de atividades não inclui a oferta da lista de espera após o cancelamento (DEC-010, RF-035) (Q6-05).",
        "A guarda do cancelamento deve ser \"antes do horário marcado\" (DEC-011) e o registro de falta ocorre \"após o horário marcado\", pelo Psicólogo (DEC-025).",
    ],
    24: [
        "**Divergência com decisão aprovada:** a máquina de estados versionada tem `SOLICITADO` como estado inicial e as transições T2 e T3. Pela **DEC-016** (25/10/2026), `SOLICITADO` não é situação persistente: a transição inicial vai direto para `CONFIRMADO` quando o horário está disponível e sem conflito, e T2/T3 deixam de existir (Q6-01).",
        "A transição `CONFIRMADO → NAO_COMPARECEU` passa a ter guarda **\"após o horário marcado\"** e ator **Psicólogo** (DEC-025) (Q6-03).",
        "Se `Cancelado`, `Realizado` e `Não compareceu` são finais sem reversão continua **não decidido** pelo grupo (DEC-016, \"Ainda não decidido\").",
    ],
    27: [
        "O texto afirma que `Agendamento`–`Atendimento` \"foi modelada como composição\", mas nem o diagrama oficial (OO-03) nem a proposta v2 (retirada) desenhavam composição. Recomendação do Integrante 5: manter associação `1`–`0..1` e, se o grupo quiser evidenciar composição, usar `Agenda` ◆— `Disponibilidade` (Q5-03).",
        "No SRP, o ciclo do agendamento é \"Confirmado → Realizado / Cancelado / Não compareceu\" (DEC-016), sem `SOLICITADO` (Q5-07).",
    ],
}


def ler(caminho):
    return caminho.read_text(encoding="utf-8")


def secoes_do_arquivo(texto):
    """Divide o texto em {numero: bloco} a partir de linhas '## N. Título'."""
    partes = re.split(r"(?m)^(?=## \d+\. )", texto)
    resultado = {}
    for parte in partes:
        m = re.match(r"## (\d+)\. ", parte)
        if not m:
            continue
        bloco = parte
        # Remove a nota de consolidação endereçada ao Integrante 6.
        bloco = re.split(r"(?m)^## Nota de consolidação", bloco)[0]
        bloco = re.sub(r"\n---\s*$", "\n", bloco.rstrip() + "\n")
        resultado[int(m.group(1))] = bloco.rstrip() + "\n"
    return resultado


def celula(texto):
    return texto.replace("|", "\\|").strip()


def tabela_glossario():
    linhas = ["| Termo | Definição |", "|---|---|"]
    for l in ler(REQ / "glossario.md").splitlines():
        m = re.match(r"\| \*\*(.+?)\*\* \| (.+) \|$", l)
        if m:
            linhas.append(f"| {m.group(1)} | {m.group(2)} |")
    return "\n".join(linhas)


def blocos(texto, prefixo):
    return re.findall(rf"(?ms)^### ({prefixo}-\d+) — (.+?)\n(.*?)(?=^### |^## |\Z)", texto)


def campo(corpo, nome, sem_ponto=False):
    m = re.search(rf"\*\*{nome}:\*\*\s*(.+)", corpo)
    if not m:
        return "—"
    valor = celula(m.group(1))
    return valor.rstrip(".") if sem_ponto else valor


def tabela_rf():
    linhas = ["| ID | Requisito | Ator(es) | Prioridade |", "|---|---|---|---|"]
    rfs = blocos(ler(REQ / "requisitos-funcionais.md"), "RF")
    for ident, titulo, corpo in sorted(rfs, key=lambda b: b[0]):
        linhas.append(f"| {ident} | {celula(titulo)} | {campo(corpo, 'Ator\\(es\\)', True)} | {campo(corpo, 'Prioridade', True)} |")
    return "\n".join(linhas)


def tabela_rnf():
    linhas = ["| ID | Requisito | Categoria | Descrição |", "|---|---|---|---|"]
    for ident, titulo, corpo in blocos(ler(REQ / "requisitos-nao-funcionais.md"), "RNF"):
        linhas.append(f"| {ident} | {celula(titulo)} | {campo(corpo, 'Categoria')} | {campo(corpo, 'Descrição')} |")
    return "\n".join(linhas)


def tabela_rn():
    linhas = ["| ID | Regra | Requisitos relacionados |", "|---|---|---|"]
    for ident, titulo, corpo in blocos(ler(REQ / "regras-negocio.md"), "RN"):
        linhas.append(f"| {ident} | **{celula(titulo)}** — {campo(corpo, 'Regra')} | {campo(corpo, 'Requisitos relacionados', True)} |")
    return "\n".join(linhas)


def tabela_hu():
    linhas = ["| ID | História | Requisitos relacionados |", "|---|---|---|"]
    for ident, titulo, corpo in blocos(ler(REQ / "historias-usuario.md"), "HU"):
        linhas.append(f"| {ident} | {celula(titulo)} | {campo(corpo, 'Requisitos relacionados', True)} |")
    return "\n".join(linhas)


TABELAS = {
    "GLOSSARIO": tabela_glossario,
    "RF": tabela_rf,
    "RNF": tabela_rnf,
    "RN": tabela_rn,
    "HU": tabela_hu,
}


def aplicar_tabelas(bloco):
    return re.sub(r"<!-- TABELA:(\w+) -->", lambda m: TABELAS[m.group(1)](), bloco)


def aplicar_nota(numero, bloco):
    notas = NOTAS_INTEGRACAO.get(numero)
    if not notas:
        return bloco
    titulo, _, resto = bloco.partition("\n")
    caixa = ["", "> **Nota de integração (Integrante 6, 28/10/2026).** O texto abaixo foi preparado antes das decisões de 25/10/2026 e é mantido como entregue pelo autor. Prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:"]
    caixa += [f"> - {n}" for n in notas]
    return titulo + "\n" + "\n".join(caixa) + "\n" + resto


def main():
    todas = {}
    for arquivo, _ in PARTES:
        todas.update(secoes_do_arquivo(ler(SECOES / arquivo)))

    faltando = sorted(set(TITULOS) - set(todas))
    if faltando:
        raise SystemExit(f"Seções sem texto: {faltando}")

    cab = [
        "# Dossiê de Modelagem Orientada a Objetos — Plataforma para Psicólogos",
        "",
        f"**Versão:** {VERSAO} · **Data de montagem:** {DATA} · **Situação:** dossiê em construção — seções 1 a 24 e 27 com conteúdo das Fases 1 a 6; seções 25, 26 e 28 a 36 com estrutura e texto disponível.",
        "**Montagem:** arquivo gerado por `07-dossie/montar-dossie.py` a partir de `07-dossie/secoes/` e de `02-requisitos/`. Não editar este arquivo diretamente: editar a seção de origem e rodar o script.",
        "**Responsável pela integração:** Integrante 6 — Guilherme Freire.",
        "",
        "> As seções preparadas pelos Integrantes 2, 4 e 5 são mantidas como entregues. Quando uma decisão aprovada depois da redação torna parte do texto desatualizada, uma **nota de integração** logo abaixo do título da seção indica o que prevalece. A correção do texto e dos diagramas cabe ao autor.",
        "",
        "## Sumário",
        "",
        "| Seção | Título | Origem do texto |",
        "|---|---|---|",
    ]
    for n, t in TITULOS.items():
        cab.append(f"| {n} | {t} | {ORIGEM[n]} |")
    cab += ["", "---", ""]

    corpo = []
    for n in TITULOS:
        bloco = aplicar_tabelas(todas[n])
        bloco = aplicar_nota(n, bloco)
        corpo.append(bloco.rstrip() + "\n\n---\n")

    SAIDA.write_text("\n".join(cab) + "\n".join(corpo), encoding="utf-8")
    print(f"Gerado {SAIDA.relative_to(RAIZ)} com {len(TITULOS)} seções.")


if __name__ == "__main__":
    main()
