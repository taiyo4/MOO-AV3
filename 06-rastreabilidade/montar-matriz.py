import re,sys
import pathlib
R=str(pathlib.Path(__file__).resolve().parent.parent)+'/'
def tables(path):
    """yield (header list, row dict) for each table row whose first cell starts with RF-nnn"""
    hdr=None; out={}
    for l in open(R+path,encoding='utf-8'):
        if not l.startswith('|'): hdr=None; continue
        cells=[c.strip() for c in l.strip().strip('|').split('|')]
        if cells and cells[0] in ('RF','Requisito') and not re.match(r'\**RF-\d{3}',cells[0]) : hdr=cells; continue
        if re.match(r'-+$',cells[0].replace(':','')): continue
        m=re.match(r'\**(RF-\d{3})',cells[0])
        if m and hdr:
            out.setdefault(m.group(1),dict(zip(hdr,cells)))
        elif hdr is None or not m:
            pass
    return out
def clean(s): return re.sub(r'\*\*','',s or '').strip() or '—'
f5=tables('06-rastreabilidade/matriz-rastreabilidade-fase5.md')
f6=tables('06-rastreabilidade/matriz-rastreabilidade-fase6.md')
ini=tables('02-requisitos/rastreabilidade-inicial.md')
# dicionario
dic={}
for l in open(R+'04-persistencia/dicionario-de-dados.md',encoding='utf-8'):
    m=re.match(r'\| (RF-\d{3}) \| (.*) \|$',l.rstrip())
    if m: dic[m.group(1)]=m.group(2)
# titles
tit={}
for l in open(R+'02-requisitos/requisitos-funcionais.md',encoding='utf-8'):
    m=re.match(r'### (RF-\d{3}) — (.*)',l)
    if m: tit[m.group(1)]=m.group(2).strip()
# CT per RF
ct={}
txt=open(R+'01-planejamento/revisoes/FASE8-REV-I2-testes-conceituais.md',encoding='utf-8').read()
for m in re.finditer(r'CT-(\d{3})',txt):
    ct.setdefault('RF-'+m.group(1),'CT-'+m.group(1))

import datetime
rfs=sorted(tit)
rows=[];rn_seen=set();rnf_seen=set();dec_seen=set()
def col(d,*names):
    for n in names:
        for k in d:
            if k.startswith(n): return d[k]
    return ''
ctdone=set(ct.values())
stat={'ok':0,'lac':[]}
for k in rfs:
    a=f5.get(k,{});b=f6.get(k,{});c=ini.get(k,{})
    rn=clean(col(b,'RN')) if b else clean(col(a,'RN'))
    extra=[x for x in re.findall(r'RNF?-\d{3}',col(a,'RN')+' '+col(c,'Regra')) if x not in rn]
    if extra: rn=(rn+', '+', '.join(extra)) if rn!='—' else ', '.join(extra)
    for x in re.findall(r'RN-\d{3}',rn): rn_seen.add(x)
    for x in re.findall(r'RNF-\d{3}',rn): rnf_seen.add(x)
    uc=clean(col(b,'UC')) if b else clean(col(a,'UC'))
    cls=clean(col(a,'Classe'))
    op=clean(col(b,'Operação')) if b else clean(col(a,'Operação'))
    beh=[]
    for h,n in (('SEQ','SEQ'),('ATV','ATV'),('COM','COM'),('EST','EST')):
        v=clean(col(b,h))
        if v!='—': beh.append(f"{n}: {v}")
    beh='; '.join(beh) or '—'
    tab=dic.get(k,'—')
    ca=clean(col(c,'Critério')); hu=clean(col(c,'História')); dc=clean(col(c,'Decisão'))
    for x in re.findall(r'DEC-\d{3}',dc+rn+op): dec_seen.add(x)
    qt=clean(col(a,'Qualidade'))
    t=re.findall(r'CT-\d{3}',qt)
    if not t and k in ct: t=[ct[k]]
    tcell=(t[0]+(' (escrito)' if t and t[0] in ctdone else ' (a escrever)')) if t else '—'
    qual=qt.split('/')[0].strip() if qt!='—' else '—'
    rows.append((k,tit[k],rn,uc,cls,op,beh,tab,f"{ca}; {hu}",dc,tcell,qual))
    flag=[]
    if uc=='—': flag.append('sem UC')
    if beh=='—' and not re.search(r'consult|Consult|painel|Gerenciar|Cadastr|Atualiz|Ativ|Bloq|Alterar|Associar',tit[k]): flag.append('sem diagrama comportamental')
    if tab in('—',) : flag.append('sem tabela')
    stat['lac'].append((k,flag))
out=[]
w=out.append
w("# Matriz de Rastreabilidade Final — v0.7 (preenchida até a Fase 7)")
w("")
w("**Responsável:** Integrante 5 (verificação, sem órfãos; gerada por `06-rastreabilidade/montar-matriz.py`) e Integrante 1 (requisitos); montada em 30/10/2026 a partir das matrizes das Fases 3, 5 e 6, do dicionário de dados da Fase 7 e dos testes conceituais do Integrante 2.")
w("**Situação:** versão **v0.7**, não final. As colunas de classe e de persistência dependem do diagrama de classes oficial (Integrante 3), que ainda não incorporou DEC-013 a DEC-030. Esta matriz será **v1.0** quando os itens P7 a P10 de `01-planejamento/etapas-e-responsabilidades.md` estiverem fechados.")
w("**Fontes:** `02-requisitos/rastreabilidade-inicial.md` (UC futuro, CA, HU, decisão); `06-rastreabilidade/matriz-rastreabilidade-fase5.md` (classe, teste, categoria de qualidade); `06-rastreabilidade/matriz-rastreabilidade-fase6.md` (operação, SEQ, ATV, COM, EST); `04-persistencia/dicionario-de-dados.md` §6 (tabela e coluna); `01-planejamento/revisoes/FASE8-REV-I2-testes-conceituais.md` (testes escritos).")
w("")
w("## 1. Matriz principal — requisito, regra, caso de uso, classe, comportamento, persistência, qualidade e teste")
w("")
w("| RF | RN / RNF | UC | Classe | Operação / responsabilidade | Diagramas comportamentais | Persistência (tabela.coluna) | CA; HU | Decisão | Teste conceitual | Qualidade |")
w("|---|---|---|---|---|---|---|---|---|---|---|")
for r in rows:
    k,t,rn,uc,cls,op,beh,tab,cahu,dc,tc,q=r
    w(f"| {k} {t} | {rn} | {uc} | {cls} | {op} | {beh} | {tab} | {cahu} | {dc} | {tc} | {q} |")
w("")
# orphans
rn_all=set(re.findall(r'### (RN-\d{3})',open(R+'02-requisitos/regras-negocio.md',encoding='utf-8').read()))
rnf_all=set(re.findall(r'### (RNF-\d{3})',open(R+'02-requisitos/requisitos-nao-funcionais.md',encoding='utf-8').read()))
dec_all=set(re.findall(r'## (DEC-\d{3})',open(R+'01-planejamento/decisoes.md',encoding='utf-8').read()))
w("## 2. Verificação de órfãos")
w("")
w("| Conjunto | Total | Rastreados na matriz | Órfãos |")
w("|---|---|---|---|")
w(f"| RF | {len(rfs)} | {len(rows)} | nenhum (todos têm linha) |")
o=sorted(rn_all-rn_seen); w(f"| RN | {len(rn_all)} | {len(rn_all&rn_seen)} | {', '.join(o) or 'nenhum'} |")
o=sorted(rnf_all-rnf_seen); w(f"| RNF | {len(rnf_all)} | {len(rnf_all&rnf_seen)} | {', '.join(o) or 'nenhum'} |")
w("")
w("RNF órfãos na coluna \"RN / RNF\" são **requisitos transversais** (valem para o sistema inteiro, não para um RF específico); estão cobertos pelo plano de qualidade (`05-qualidade/plano-qualidade-iso25010.md`) e não são lacuna de modelagem.")
w("")
w("## 3. Lacunas a fechar para a v1.0")
w("")
lac=[(k,f) for k,f in stat['lac'] if f]
w("| RF | Lacuna detectada pela matriz |")
w("|---|---|")
for k,f in lac: w(f"| {k} | {'; '.join(f)} |")
if not lac: w("| — | nenhuma lacuna estrutural detectada automaticamente |")
w("")
w("Lacunas já conhecidas por outras fontes: (a) a lista de espera (RF-034 a RF-036) tem caso de uso, diagramas comportamentais e tabela (`solicitacao_espera`), mas **não tem classe no diagrama de classes oficial** (P8, Integrante 3); (b) a coluna **Classe** das linhas RF-001 a RF-033 reflete o diagrama oficial, ainda com multiplicidades `PENDENTE` (P7); (c) os testes conceituais marcados \"a escrever\" ficam para os Integrantes 3 e 4 (Fase 8).")
w("")
n_esc=sum(1 for r in rows if '(escrito)' in r[10]); n_ae=sum(1 for r in rows if '(a escrever)' in r[10])
w("## 4. Cobertura de testes conceituais")
w("")
w(f"- Testes escritos (Integrante 2): {n_esc} de {len(rows)} requisitos têm teste `CT-0RF` com cenário escrito.")
w(f"- Testes previstos e ainda a escrever: {n_ae}.")
w("- Convenção: `CT-0RF` (DEC-026).")
w("")
w("## 5. Regra de manutenção")
w("")
w("1. Esta matriz é **regerada** por script quando uma fonte muda; não é editada à mão.")
w("2. Um RF novo exige linha em todas as fontes antes de entrar aqui.")
w("3. Um achado de rastreabilidade vira achado `Q8-nn` no `05-qualidade/analises/`.")
open(R+'06-rastreabilidade/matriz-rastreabilidade-final.md','w',encoding='utf-8').write('\n'.join(out)+'\n')
print(len(rows),len(lac),n_esc,n_ae)
