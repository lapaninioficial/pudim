'use strict';

/* =====================================================================
   Pudim Lapanini — catálogo completo (loja EXCLUSIVA de pudins).
   8 categorias, nesta ordem: Kits Mini, Eventos, Sobremesas Variadas,
   Bebidas, Geladinhos, Os Mais Pedidos, Promoção do Dia, Top Mais Vendidos.
   Espelha o banco (api/catalog é autoritativo quando há backend).
   Cada produto tem: id, categoria, preço base, descrição curta e longa,
   ingredientes, grupo de adicionais, tamanhos e marcas.
   ===================================================================== */

function P(id, cat, name, base, desc, long, extra) {
  return Object.assign({
    id: id, cat: cat, name: name, base: base, desc: desc, long: long,
    old: null, sizes: SIZE_UNIT, type: 'reg',
    addonGroup: 'doce', ingredients: [], tags: [], obsNote: '',
    encomenda: false, freteGratis: false, badge: '', min: 0, maxPerFlavor: 0,
    pool: [], sizeLabel: '', discount: 0, time: 'Feito no dia'
  }, extra || {});
}

var PRODUCTS = [

  /* ==================== Kits Mini ==================== */

  P('kit-mini-festa', 'doces', 'Kit Mini Festa', 89.90,
    '6 mini pudins + 2 fatias de torta para a festa.',
    'Kit com 6 mini pudins sortidos (tradicional, coco, café e doce de leite) + 2 fatias de torta (alfajor e chocolate belga). Serve 6 a 8 pessoas.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: 'Caixa com 8 un.', tags: ['Festa'],
      comp: ['2x Pudim Tradicional da Casa 100g', '1x Pudim de Coco 130g', '1x Pudim de Café 130g', '1x Pudim de Doce de Leite 130g', '1x Pudim Tradicional Familia 380g (fatiado)', '1x Torta Alfajor na Fatia', '1x Torta de Chocolate Belga'] }),

  P('kit-mini-reuniao', 'doces', 'Kit Mini Reunião', 119.90,
    '8 mini pudins + 4 fatias de torta para reunir a turma.',
    'Kit com 8 mini pudins sortidos + 4 fatias de torta variadas (alfajor, chaja, chocolate belga e sorvete alfajor). Serve 10 a 12 pessoas.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: 'Caixa com 12 un.', tags: ['Reunião'],
      comp: ['3x Pudim Tradicional da Casa 100g', '2x Pudim de Coco 130g', '2x Pudim de Café 130g', '1x Pudim de Doce de Leite 130g', '1x Torta Alfajor na Fatia', '1x Torta Chaja', '1x Torta de Chocolate Belga', '1x Torta de Sorvete Alfajor'] }),

  P('kit-mini-caseiro', 'doces', 'Kit Mini Caseiro', 59.90,
    '4 mini pudins para a semana em casa.',
    'Kit com 4 mini pudins sortidos para deixar a semana resolvida: tradicional, coco, café e doce de leite.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: 'Caixa com 4 un.', tags: ['Casa'],
      comp: ['1x Pudim Tradicional da Casa 100g', '1x Pudim de Coco 130g', '1x Pudim de Café 130g', '1x Pudim de Doce de Leite 130g'] }),

  P('kit-mini-aniversario', 'doces', 'Kit Mini Aniversário', 99.90,
    '6 mini pudins + 1 geladinho para cantar parabéns.',
    'Kit aniversario com 6 mini pudins sortidos + 1 geladinho gourmet de Leite Moça.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: 'Caixa com 7 un.', tags: ['Aniversário', 'Kids'],
      comp: ['2x Pudim Tradicional da Casa 100g', '2x Pudim de Coco 130g', '2x Pudim de Doce de Leite 130g', '1x Geladinho Gourmet Leite Moça'] }),

  P('kit-mini-cafe-tarde', 'doces', 'Kit Mini Café da Tarde', 79.90,
    '4 mini pudins + 2 fatias de torta para o café.',
    'Kit café da tarde com 4 mini pudins sortidos + 2 fatias de torta (chajá e alfajor). Combina com café fresquinho.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: 'Caixa com 6 un.', tags: ['Café'],
      comp: ['2x Pudim Tradicional da Casa 100g', '1x Pudim de Café 130g', '1x Pudim de Doce de Leite 130g', '1x Torta Chaja', '1x Torta Alfajor na Fatia'] }),

  /* ==================== Eventos ==================== */

  P('kit-festa-doce-10un', 'eventos', 'Kit Festa Doce (10 un)', 149.90,
    '10 porcoes de pudins e tortas para a festa.',
    'Kit festa com 6 mini pudins sortidos + 4 fatias de torta variadas. Serve 10 pessoas. Encomenda com 24h.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: '10 porcoes', tags: ['Festa', 'Evento'], encomenda: true,
      comp: ['4x Pudim Tradicional da Casa 100g', '2x Pudim de Coco 130g', '2x Torta Alfajor na Fatia', '2x Torta de Chocolate Belga'] }),

  P('kit-casamento-mini', 'eventos', 'Kit Casamento Mini', 189.90,
    'Lembrancinhas doces para os convidados.',
    'Kit casamento com 10 mini pudins em potinhos individuais (tradicional, coco e doce de leite) + etiqueta personalizada. Encomenda com 48h.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: '10 potinhos', tags: ['Casamento'], encomenda: true,
      comp: ['4x Pudim Tradicional da Casa 100g (potinho)', '3x Pudim de Coco 130g (potinho)', '3x Pudim de Doce de Leite 130g (potinho)'] }),

  P('kit-aniversario-kids', 'eventos', 'Kit Aniversário Kids', 99.90,
    'Festa kids com pudim e geladinho.',
    'Kit kids com 4 mini pudins + 4 geladinhos gourmet (leite moca e coco). Encomenda com 24h.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: '8 porcoes', tags: ['Kids', 'Aniversário'], encomenda: true,
      comp: ['2x Pudim Tradicional da Casa 100g', '2x Pudim de Doce de Leite 130g', '2x Geladinho Gourmet Leite Moça', '2x Geladinho Gourmet de Coco'] }),

  P('kit-escritorio', 'eventos', 'Kit Escritório', 119.90,
    'Coffee break doce para a equipe.',
    'Kit escritorio com 6 mini pudins + 2 fatias de torta grande (chocolate belga e chaja). Ideal para coffee break de 8 pessoas. Encomenda com 24h.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: '8 porcoes', tags: ['Empresa'], encomenda: true,
      comp: ['3x Pudim Tradicional da Casa 100g', '3x Pudim de Café 130g', '1x Torta de Chocolate Belga', '1x Torta Chaja'] }),

  P('kit-degustacao', 'eventos', 'Kit Degustação', 79.90,
    'Prove todos os sabores da casa.',
    'Kit degustacao com 1 mini de cada sabor: tradicional, coco, cafe, doce de leite + 1 fatia de torta alfajor + 1 geladinho.',
    { type: 'kit', sizes: SIZE_KIT, sizeLabel: '6 porcoes', tags: ['Degustação'],
      comp: ['1x Pudim Tradicional da Casa 100g', '1x Pudim de Coco 130g', '1x Pudim de Café 130g', '1x Pudim de Doce de Leite 130g', '1x Torta Alfajor na Fatia', '1x Geladinho Gourmet Leite Moça'] }),

  /* ==================== Sobremesas Variadas (11) ==================== */

  P('torta-alfajor', 'sobremesas', 'Torta Alfajor na Fatia', 24.90,
    'Camadas generosas de doce de leite com textura de alfajor.',
    'Camadas generosas de doce de leite com a textura inconfundível do alfajor. Para quem gosta de sobremesa que impressiona sem complicar.',
    { sizes: [{ id: 'u', label: 'Fatia · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['Fatia'], ingredients: [
      { label: 'Doce de leite' }, { label: 'Chocolate' }, { label: 'Crocante de alfajor' } ] }),

  P('chaja', 'sobremesas', 'Torta Chajá', 25.90,
    'Leve, cremosa, com equilíbrio entre doce e delicado.',
    'Leve, cremosa e com aquele equilíbrio perfeito entre doce e delicado. Uma sobremesa sofisticada que some rápido da mesa.',
    { sizes: [{ id: 'u', label: 'Fatia · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['Fatia'], ingredients: [
      { label: 'Pão de ló' }, { label: 'Creme' }, { label: 'Pêssego em calda' } ] }),

  P('choc-belga', 'sobremesas', 'Torta de Chocolate Belga', 25.90,
    'Chocolate intenso e aveludado.',
    'Chocolate de verdade, intenso e aveludado. Para os momentos em que só uma sobremesa à altura resolve.',
    { sizes: [{ id: 'u', label: 'Fatia · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['Fatia'], ingredients: [
      { label: 'Chocolate belga' }, { label: 'Creme' }, { label: 'Cacau' } ] }),

  P('sorvete-alfajor', 'sobremesas', 'Torta de Sorvete Alfajor', 29.90,
    'O frescor do sorvete com o sabor clássico do alfajor.',
    'O frescor do sorvete com o sabor clássico do alfajor. Cremosa, gelada e irresistível, especialmente nos dias quentes.',
    { sizes: [{ id: 'u', label: 'Fatia · gelada', factor: 1 }], addonGroup: 'doce', tags: ['Gelada'], ingredients: [
      { label: 'Sorvete' }, { label: 'Doce de leite' }, { label: 'Chocolate' } ] }),

  P('pudim-tradicional', 'sobremesas', 'Pudim Tradicional da Casa', 9.90,
    'Textura firme e calda generosa. O pudim de sempre.',
    'Feito com cuidado, textura firme e calda generosa. O pudim de sempre, do jeito que tem que ser.',
    { sizes: [{ id: 'u', label: '100g · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['100g'], ingredients: [
      { label: 'Leite condensado' }, { label: 'Ovos' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-tradicional-380g', 'sobremesas', 'Pudim Tradicional da Casa Família', 27.90,
    'Textura firme e calda generosa, no tamanho família.',
    'Feito com cuidado, textura firme e calda generosa. O pudim de sempre, no tamanho para dividir.',
    { sizes: [{ id: 'u', label: '380g · 4 porções', factor: 1 }], addonGroup: 'doce', tags: ['380g'], ingredients: [
      { label: 'Leite condensado' }, { label: 'Ovos' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-coco', 'sobremesas', 'Pudim de Coco', 13.90,
    'Cremoso, aromático, com o sabor de coco que reconforta.',
    'Cremoso, aromático e com aquele sabor de coco que reconforta. Simples e delicioso do primeiro ao último pedaço.',
    { sizes: [{ id: 'u', label: '130g · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['130g'], ingredients: [
      { label: 'Leite condensado' }, { label: 'Coco' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-cafe', 'sobremesas', 'Pudim de Café', 13.90,
    'Para os apaixonados por café. Intenso e sofisticado.',
    'Para os apaixonados por café: o sabor marcante que você ama em formato de sobremesa. Intenso e sofisticado.',
    { sizes: [{ id: 'u', label: '130g · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['130g'], ingredients: [
      { label: 'Leite condensado' }, { label: 'Café' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-doce-leite', 'sobremesas', 'Pudim de Doce de Leite', 13.90,
    'Macio, encorpado e com doce de leite em cada garfada.',
    'Macio, encorpado e com doce de leite em cada garfada. Difícil comer só um.',
    { sizes: [{ id: 'u', label: '130g · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['130g'], ingredients: [
      { label: 'Leite condensado' }, { label: 'Doce de leite' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-pacoca-130g', 'sobremesas', 'Pudim de Paçoca 130g', 15.90,
    'Cremoso com crocante de paçoca.',
    'Pudim cremoso de Leite Moça com paçoca de verdade e crocante por cima.',
    { sizes: [{ id: 'u', label: '130g · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['130g'], ingredients: [
      { label: 'Leite condensado' }, { label: 'Paçoca' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-limao-130g', 'sobremesas', 'Pudim de Limão 130g', 15.90,
    'Azedinho na medida, refrescante.',
    'Pudim de limão siciliano com Leite Moça: azedinho na medida e super refrescante.',
    { sizes: [{ id: 'u', label: '130g · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['130g'], ingredients: [
      { label: 'Leite condensado' }, { label: 'Limão siciliano' }, { label: 'Calda de caramelo' } ] }),

  /* ==================== Bebidas (5) ==================== */

  P('coca-cola-350', 'bebidas', 'Coca-Cola', 6.90,
    'O sabor que nunca passa da hora.',
    'Coca-Cola lata 350ml gelada, perfeita para acompanhar seu pudim.',
    { sizes: [{ id: 'u', label: '350ml · gelada', factor: 1 }], addonGroup: '', tags: ['Lata'], ingredients: [] }),

  P('guarana-350', 'bebidas', 'Guaraná Antarctica', 5.90,
    'O guaraná mais brasileiro.',
    'Guaraná Antarctica lata 350ml gelado, refrescante e delicioso.',
    { sizes: [{ id: 'u', label: '350ml · gelado', factor: 1 }], addonGroup: '', tags: ['Lata'], ingredients: [] }),

  P('suco-laranja', 'bebidas', 'Suco de Laranja', 8.90,
    'Natural e fresquinho.',
    'Suco de laranja natural 400ml, feito na hora com laranjas selecionadas.',
    { sizes: [{ id: 'u', label: '400ml · natural', factor: 1 }], addonGroup: '', tags: ['Natural'], ingredients: [] }),

  P('agua-mineral', 'bebidas', 'Água Mineral', 4.50,
    'Pura e gelada.',
    'Água mineral sem gás 500ml, refrescante e leve.',
    { sizes: [{ id: 'u', label: '500ml · sem gás', factor: 1 }], addonGroup: '', tags: ['Sem gás'], ingredients: [] }),

  P('suco-maracuja', 'bebidas', 'Suco de Maracujá', 8.90,
    'Natural da fruta, feito na hora.',
    'Suco de maracujá natural 400ml, feito na hora com fruta selecionada. Azedinho e gelado.',
    { sizes: [{ id: 'u', label: '400ml · natural', factor: 1 }], addonGroup: '', tags: ['Natural'], ingredients: [] }),

  /* ==================== Geladinhos (2) ==================== */

  P('base-geladinho-leite-moca', 'geladinhos', 'Geladinho Gourmet Leite Moça', 12.90,
    'Geladinho cremoso de pudim de Leite Moça.',
    'Geladinho gourmet cremoso feito com puro Leite Moça. Refrescância de pudim no palito.',
    { sizes: [{ id: 'u', label: 'Unidade · geladinho', factor: 1 }], addonGroup: 'doce', tags: ['Gourmet'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Leite' } ] }),

  P('base-geladinho-coco', 'geladinhos', 'Geladinho Gourmet de Coco', 12.90,
    'Geladinho cremoso de coco com Leite Moça.',
    'Geladinho gourmet cremoso de coco com Leite Moça. Leve, aromático e gelado na medida.',
    { sizes: [{ id: 'u', label: 'Unidade · geladinho', factor: 1 }], addonGroup: 'doce', tags: ['Gourmet'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Coco' } ] }),

  /* ==================== Os Mais Pedidos (5) ==================== */

  P('pudim-leite-moca-familia', 'mais-pedidos', 'Pudim de Leite Moça Tradicional - Tamanho Família', 84.90,
    'O clássico da casa no tamanho para dividir.',
    'Pudim de Leite Moça tradicional em tamanho família. Textura firme e calda generosa para a mesa toda.',
    { sizes: [{ id: 'u', label: 'Tamanho Família', factor: 1 }], addonGroup: 'doce', tags: ['Família'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Ovos' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-leite-moca-individual', 'mais-pedidos', 'Pudim de Leite Moça Tradicional - Individual', 14.90,
    'O clássico em porção individual.',
    'Pudim de Leite Moça tradicional em porção individual. A medida certa da vontade.',
    { sizes: [{ id: 'u', label: 'Individual · 1 porção', factor: 1 }], addonGroup: 'doce', tags: ['Individual'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Ovos' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-leite-moca-medio-550g', 'mais-pedidos', 'Pudim de Leite Moça Tradicional - Tamanho Médio (550g)', 49.90,
    'O clássico no tamanho médio de 550g.',
    'Pudim de Leite Moça tradicional, 550g. Equilíbrio perfeito entre vontade e partilha.',
    { sizes: [{ id: 'u', label: '550g · Médio', factor: 1 }], addonGroup: 'doce', tags: ['550g'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Ovos' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-geladinho-gourmet', 'mais-pedidos', 'Geladinho Gourmet de Pudim de Leite Moça', 12.90,
    'Refrescância cremosa de pudim.',
    'Geladinho gourmet de pudim de Leite Moça. Cremoso e gelado na medida.',
    { sizes: [{ id: 'u', label: 'Unidade · geladinho', factor: 1 }], addonGroup: 'doce', tags: ['Geladinho'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Leite' } ] }),

  P('pudim-laka-granule', 'mais-pedidos', 'Pudim de Laka com Granulê (Brigadeirão Branco)', 16.90,
    'Brigadeirão branco com granulê.',
    'Pudim de Laka com granulê, o brigadeirão branco cremoso com cobertura crocante.',
    { sizes: [{ id: 'u', label: 'Unidade · com granulê', factor: 1 }], addonGroup: 'doce', tags: ['Brigadeirão'], ingredients: [
      { label: 'Chocolate Laka' }, { label: 'Leite Moça' }, { label: 'Granulê' } ] }),

  /* ==================== Promoção do Dia! (3) ==================== */

  P('pudim-combo-tradicional-geladinho', 'promocao-do-dia', 'Combo Pudim Tradicional + Geladinho', 89.90,
    '1 Pudim Família Tradicional + 1 geladinho sabor variado conforme disponibilidade na loja.',
    'Combo com 1 Pudim Família Tradicional e 1 geladinho de sabor variado, conforme disponibilidade na loja.',
    { old: 97.80, badge: '−8% OFF', sizes: [{ id: 'u', label: 'Combo', factor: 1 }], addonGroup: 'doce', tags: ['Combo'], ingredients: [
      { label: 'Pudim família tradicional' }, { label: 'Geladinho' } ] }),

  P('pudim-combo-5-geladinhos', 'promocao-do-dia', 'Combo com 5 Geladinhos com Desconto!', 59.90,
    '5 geladinhos conforme sabores disponíveis no dia! Com desconto especial!',
    'Combo com 5 geladinhos nos sabores disponíveis no dia, com desconto especial aplicado.',
    { old: 64.50, badge: '−7% OFF', sizes: [{ id: 'u', label: '5 unidades', factor: 1 }], addonGroup: 'doce', tags: ['Combo'], ingredients: [
      { label: 'Geladinhos sortidos' } ] }),

  P('pudim-kit-caixa-4', 'promocao-do-dia', 'Kit Caixa Presenteável com 4 Pudins Individuais', 59.90,
    '4 pudins sortidos conforme disponibilidade do dia.',
    'Kit em caixa presenteável com 4 pudins individuais sortidos, conforme disponibilidade do dia.',
    { sizes: [{ id: 'u', label: 'Caixa com 4', factor: 1 }], addonGroup: 'doce', tags: ['Presenteável'], ingredients: [
      { label: 'Pudins individuais sortidos' } ] }),

  /* ==================== Top Mais Vendidos! (4) ==================== */

  P('pudim-premium-tradicional-individual', 'top-mais-vendidos', 'Pudim Tradicional de Leite Moça - Individual', 14.90,
    'O melhor pudim da vida! Macio, cremoso e lisinho.',
    'Nosso inconfundível Pudim Premium Gourmet 130g feito com puro Leite Moça! Macio e cremoso! O mais vendido, lisinho e saboroso.',
    { badge: 'O mais queridinho', sizes: [{ id: 'u', label: '130g · Individual', factor: 1 }], addonGroup: 'doce', tags: ['130g'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Ovos' }, { label: 'Calda de caramelo' } ] }),

  P('pudim-premium-doce-leite-individual', 'top-mais-vendidos', 'Pudim de Doce de Leite - Individual', 14.90,
    'Com Doce de Leite Mineiro, o melhor de Minas Gerais.',
    'Pudim Premium Gourmet 130g feito com puro Leite Moça + Doce de Leite Mineiro! Macio e cremoso, sabor sem igual!',
    { sizes: [{ id: 'u', label: '130g · Individual', factor: 1 }], addonGroup: 'doce', tags: ['130g'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Doce de leite mineiro' } ] }),

  P('pudim-premium-brigadeiro-individual', 'top-mais-vendidos', 'Pudim de Brigadeiro Gourmet - Individual', 16.90,
    'O brigadeirão viciante, top 2 mais vendidos.',
    'Pudim Premium Gourmet 130g feito com puro Leite Moça + chocolate nobre! Cobertura de granulê ao leite. Macio e cremoso, doce na medida certa!',
    { sizes: [{ id: 'u', label: '130g · Individual', factor: 1 }], addonGroup: 'doce', tags: ['130g'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Chocolate nobre' }, { label: 'Granulê ao leite' } ] }),

  P('pudim-premium-cheesecake-individual', 'top-mais-vendidos', 'Pudim de Cream Cheese com Frutas Vermelhas (Cheesecake) - Individual', 16.90,
    'Uma experiência gastronômica, top 3 mais vendidos.',
    'Pudim Premium Gourmet 130g feito com puro Leite Moça + Cream Cheese com calda de frutas vermelhas artesanal!',
    { sizes: [{ id: 'u', label: '130g · Individual', factor: 1 }], addonGroup: 'doce', tags: ['130g'], ingredients: [
      { label: 'Leite Moça' }, { label: 'Cream cheese' }, { label: 'Calda de frutas vermelhas' } ] })
];

function getById(id) {
  return PRODUCTS.filter(function (p) { return p.id === id; })[0] || null;
}

function catOf(id) {
  return CATEGORIES.filter(function (c) { return c.id === id; })[0] || null;
}

function catName(id) {
  var c = catOf(id);
  return c ? c.name : id;
}
