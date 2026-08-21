import './styles.css';

let activeSession = 0;

const sessionContent = () => {
  const sessions = [
    {
      eyebrow: 'Slide 01 / Consolidado',
      title: 'KPIs principais',
      description: 'Análise consolidada semestral · 1º Semestre 2025 vs 2026 · Grupo Lider Supermercados',
      body: `<div class="slide-layout"><div class="slide-main"><div class="kpi-grid">${[
        ['Faturamento Bruto', 'R$ 2.899 M', '+6,7% nominal · +2,1% real'],
        ['Receita Líquida', 'R$ 2.411 M', '+6,5% nominal · +1,9% real'],
        ['Lucro Bruto', 'R$ 715,9 M', '+7,1% · MB: 29,5% → 29,7%'],
        ['Lucro Líquido', 'R$ 206,9 M', '+17,2% · ML: 7,8% → 8,6%'],
      ].map(([label, value, detail]) => `<article class="kpi-card"><span>${label}</span><strong>${value}</strong><small>${detail}</small></article>`).join('')}</div><div class="chart-panel"><div class="panel-heading"><span class="panel-kicker">Evolução dos indicadores · R$ milhões</span><h3>1S2025 vs 1S2026</h3></div><div class="bar-chart">${[['Faturamento Bruto','2.716','2.899'],['Receita Líquida','2.264','2.411'],['Lucro Bruto','668','716'],['Lucro Líquido','177','207']].map(([label, oldValue, newValue]) => `<div class="bar-row"><span>${label}</span><div><i style="width:${Number(oldValue) / 30}%"></i><b style="width:${Number(newValue) / 30}%"></b></div><strong>R$ ${newValue} M</strong></div>`).join('')}</div></div></div><aside class="slide-sidebar"><div class="side-panel accent"><span class="panel-kicker">Margem bruta</span><strong>29,5% → 29,7%</strong><p>+0,2 p.p. de melhora</p></div><div class="side-panel orange"><span class="panel-kicker">Margem líquida</span><strong>7,8% → 8,6%</strong><p>+0,8 p.p. · expansão expressiva</p></div><div class="side-panel"><span class="panel-kicker">CMV</span><strong>R$ 1.595 M → R$ 1.695 M</strong><p>+6,2% · crescimento controlado</p></div></aside></div>`,
    },
    {
      eyebrow: 'Slide 02 / Performance comercial',
      title: 'Faturamento bruto por loja',
      description: 'Top 23 lojas · 1S2025 vs 1S2026 · R$ mil · Consolidado com restaurantes',
      body: `<div class="slide-layout"><div class="slide-main"><div class="chart-panel tall"><div class="panel-heading"><span class="panel-kicker">Ranking por faturamento</span><h3>Faturamento bruto por loja · ordenado por 1S2026</h3></div><div class="store-list">${[['L24 Quintino','171.939','+1,1%'],['L03 Doca','157.227','-0,1%'],['L31 Barcarena','149.658','-3,0%'],['L18 C. Nova','154.701','+2,7%'],['L32 Marabá','107.136','+25,1%'],['L36 Paragominas','72.941','+22,3%']].map(([label, value, growth]) => `<div class="store-row"><span>${label}</span><div><b style="width:${Number(value.replace('.', '')) / 900}%"></b></div><strong>R$ ${value}k</strong><em class="positive">${growth}</em></div>`).join('')}</div></div></div><aside class="slide-sidebar"><div class="side-panel accent"><span class="panel-kicker">Top performers 1S26</span><strong>L32 Marabá · +25,1%</strong><p>L36 Paragominas · +22,3%<br>L50 Estrela · +12,8%</p></div><div class="side-panel danger"><span class="panel-kicker">Underperformers</span><strong>L06 MAG Castanheira · -12,3%</strong><p>L17 Canudos · -11,9%<br>L09 Humaítá · -6,2%</p></div><div class="side-panel cyan"><span class="panel-kicker">Estatísticas</span><strong>15 de 28 lojas</strong><p>com crescimento · média +2,8% nominal<br>Maior loja: L24 · R$ 172 M</p></div></aside></div>`,
    },
    {
      eyebrow: 'Slide 03 / Rentabilidade',
      title: 'Margens e rentabilidade por loja',
      description: 'MB% e ML% · 1S2025 vs 1S2026 · Média MB 29,7% · Média ML 8,6%',
      body: `<div class="slide-layout"><div class="slide-main"><div class="chart-panel tall"><div class="panel-heading"><span class="panel-kicker">Ranking de margens por loja</span><h3>Ordenado por margem bruta · 1S2026</h3></div><div class="margin-list">${[['L08 Batista Campos','33,1%','9,6%'],['L05 Castanheira','32,6%','9,4%'],['L54 Duque','32,2%','9,3%'],['L10 Castanhal','32,1%','9,3%'],['L48 São Francisco','32,0%','9,2%'],['L06 MAG Castanheira','26,1%','7,8%']].map(([label, mb, ml]) => `<div class="margin-row"><span>${label}</span><div><b style="width:${Number(mb.replace(',', '.')) * 2.5}%"></b><i style="width:${Number(ml.replace(',', '.')) * 7}%"></i></div><strong>${mb}</strong><em>${ml}</em></div>`).join('')}</div></div></div><aside class="slide-sidebar"><div class="side-panel violet"><span class="panel-kicker">Mais rentáveis · MB%</span><strong>L08 Batista Campos · 33,1%</strong><p>L05 Castanheira · 32,6%<br>L54 Duque · 32,2%</p></div><div class="side-panel danger"><span class="panel-kicker">Menor margem bruta</span><strong>L06 MAG Castanheira · 26,1%</strong><p>L19 MAG Castanhal · 26,1%<br>L01 Condor · 27,1%</p></div><div class="side-panel"><span class="panel-kicker">Evolução consolidada</span><strong>MB 29,5% → 29,7%</strong><p>ML 7,8% → 8,6%<br>Spread: 26,1% – 33,1%</p></div></aside></div>`,
    },
    {
      eyebrow: 'Slide 04 / Tendências',
      title: 'Evolução trimestral e análise de tendências',
      description: 'Q1 e Q2 · 2025 vs 2026 · Faturamento, Receita, Lucros e Margens · Sazonalidade e Insights',
      body: `<div class="slide-layout slide-four"><div class="slide-main"><div class="kpi-grid quarter-grid">${[['Faturamento Bruto','Q1-2025 R$ 1.326 M · Q1-2026 R$ 1.382 M','Q2-2025 R$ 1.390 M · Q2-2026 R$ 1.518 M'],['Receita Líquida','Q1-2025 R$ 1.111 M · Q1-2026 R$ 1.156 M','Q2-2025 R$ 1.153 M · Q2-2026 R$ 1.255 M'],['Lucro Bruto','Q1-2025 R$ 327 M · Q1-2026 R$ 347 M','Q2-2025 R$ 341 M · Q2-2026 R$ 369 M'],['Lucro Líquido','Q1-2025 R$ 76,7 M · Q1-2026 R$ 100,0 M','Q2-2025 R$ 99,8 M · Q2-2026 R$ 107,1 M']].map(([label, q1, q2]) => `<article class="kpi-card"><span>${label}</span><strong>${q2.split(' · ')[1]}</strong><small>${q1}<br>${q2.split(' · ')[0]}</small></article>`).join('')}</div><div class="trend-panels"><div class="chart-panel"><div class="panel-heading"><span class="panel-kicker">Evolução do faturamento (R$ M)</span><h3>Q2-2026 acelerou: +9,2% vs Q2-2025</h3></div><div class="trend-line"><b style="height:45%"></b><b style="height:57%"></b><b style="height:52%"></b><b style="height:82%"></b></div><div class="trend-labels"><span>Q1-2025</span><span>Q2-2025</span><span>Q1-2026</span><span>Q2-2026</span></div></div><div class="chart-panel"><div class="panel-heading"><span class="panel-kicker">Evolução das margens (%)</span><h3>ML expandiu de 6,9% para 8,5%</h3></div><div class="trend-line violet-line"><b style="height:48%"></b><b style="height:64%"></b><b style="height:62%"></b><b style="height:76%"></b></div><div class="trend-labels"><span>Q1-2025</span><span>Q2-2025</span><span>Q1-2026</span><span>Q2-2026</span></div></div></div></div><aside class="slide-sidebar"><div class="side-panel accent"><span class="panel-kicker">⚡ Insights principais</span><strong>Q2 supera Q1 sempre</strong><p>Sazonalidade positiva: +R$64M de diferença média no 2º tri</p></div><div class="side-panel cyan"><span class="panel-kicker">Q2-2026 acelerou</span><strong>+9,2% vs Q2-2025</strong><p>Acima da média semestral de +6,7%</p></div><div class="side-panel violet"><span class="panel-kicker">Lucratividade crescente</span><strong>ML: 6,9% → 8,5%</strong><p>Ganho de +1,6 p.p. em 4 trimestres</p></div><div class="side-panel"><span class="panel-kicker">Crescimento Q vs Q</span><p>Q1-26 vs Q1-25 <strong class="inline-value green-text">+4,3%</strong><br>Q2-26 vs Q2-25 <strong class="inline-value green-text">+9,2%</strong><br>Q2-26 vs Q1-26 <strong class="inline-value orange-text">+9,9%</strong></p></div></aside></div>`,
    },
  ];
  return sessions[activeSession];
};

const renderPage = () => {
  const app = document.querySelector('#app');
  if (!app) return;
  const session = sessionContent();

  app.innerHTML = `
    <main class="viewer">
      <nav class="viewer-nav" aria-label="Navegação dos slides">
        ${['KPIs consolidados', 'Faturamento por loja', 'Margens e rentabilidade', 'Evolução trimestral'].map((label, index) => `<button class="viewer-button${index === activeSession ? ' active' : ''}" data-session="${index}" type="button"><span>0${index + 1}</span>${label}</button>`).join('')}
      </nav>
      <section class="slide-frame" aria-label="${session.title}">
        <iframe src="/slides/${activeSession + 1}.html" title="${session.title}" loading="eager"></iframe>
      </section>
    </main>
  `;

  const frame = document.querySelector<HTMLElement>('.slide-frame');
  const iframe = document.querySelector<HTMLIFrameElement>('.slide-frame iframe');
  const fitSlide = () => {
    if (!frame || !iframe) return;
    const scale = Math.min(frame.clientWidth / 1920, frame.clientHeight / 1080);
    iframe.style.transform = `scale(${scale})`;
  };
  fitSlide();
  window.addEventListener('resize', fitSlide);

  document.querySelectorAll<HTMLButtonElement>('[data-session]').forEach((button) => {
    button.addEventListener('click', () => {
      activeSession = Number(button.dataset.session);
      renderPage();
    });
  });
};

renderPage();
