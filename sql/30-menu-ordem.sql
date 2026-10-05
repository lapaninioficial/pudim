-- ============================================================================
-- 30 — Ordem da barra de menu na vitrine (1→8 da esquerda para a direita):
-- Mais Pedidos, Top Vendidos, Promoção, Geladinhos, Sobremesas,
-- Kits Mini, Eventos, Bebidas.
-- A vitrine (renderCategories + gridGrouped) e o painel usam a mesma
-- fonte: a ordem do array CATEGORIES = position no banco.
-- Nenhuma categoria removida ou renomeada; só positions.
-- ============================================================================

UPDATE categories SET position = CASE id
  WHEN 'mais-pedidos' THEN 1
  WHEN 'top-mais-vendidos' THEN 2
  WHEN 'promocao-do-dia' THEN 3
  WHEN 'geladinhos' THEN 4
  WHEN 'sobremesas' THEN 5
  WHEN 'doces' THEN 6
  WHEN 'eventos' THEN 7
  WHEN 'bebidas' THEN 8
  ELSE position END
WHERE id IN ('mais-pedidos','top-mais-vendidos','promocao-do-dia',
  'geladinhos','sobremesas','doces','eventos','bebidas');
