-- ============================================================================
-- 29 — Acentos UTF-8 nos produtos novos (loja Pudim Lapanini)
-- Aplica acentuação correta (utf8mb4) nos 15 produtos criados pela 28.
-- Rode com cliente em utf8mb4 (mysql --default-character-set=utf8mb4).
-- ============================================================================

UPDATE products SET name = 'Kit Mini Reunião' WHERE id = 'kit-mini-reuniao';
UPDATE products SET name = 'Kit Mini Aniversário',
  description = '6 mini pudins + 1 geladinho para cantar parabéns.',
  long_desc = 'Kit aniversário com 6 mini pudins sortidos + 1 geladinho gourmet de Leite Moça.'
  WHERE id = 'kit-mini-aniversario';
UPDATE products SET name = 'Kit Mini Café da Tarde',
  description = '4 mini pudins + 2 fatias de torta para o café.',
  long_desc = 'Kit café da tarde com 4 mini pudins sortidos + 2 fatias de torta (chajá e alfajor). Combina com café fresquinho.'
  WHERE id = 'kit-mini-cafe-tarde';
UPDATE products SET name = 'Kit Aniversário Kids',
  description = 'Festa kids com pudim e geladinho.',
  long_desc = 'Kit kids com 4 mini pudins + 4 geladinhos gourmet (leite moça e coco). Faz a alegria da criançada. Encomenda com 24h.'
  WHERE id = 'kit-aniversario-kids';
UPDATE products SET name = 'Kit Escritório',
  description = 'Coffee break doce para a equipe.',
  long_desc = 'Kit escritório com 6 mini pudins + 2 fatias de torta grande (chocolate belga e chajá). Ideal para coffee break de 8 pessoas. Encomenda com 24h.'
  WHERE id = 'kit-escritorio';
UPDATE products SET name = 'Kit Degustação',
  description = 'Prove todos os sabores da casa.',
  long_desc = 'Kit degustação com 1 mini de cada sabor: tradicional, coco, café, doce de leite + 1 fatia de torta alfajor + 1 geladinho.'
  WHERE id = 'kit-degustacao';
UPDATE products SET name = 'Pudim de Paçoca 130g',
  description = 'Cremoso com crocante de paçoca.',
  long_desc = 'Pudim cremoso de Leite Moça com paçoca de verdade e crocante por cima. O queridinho junino o ano todo.',
  size_label = '130g · 1 porção'
  WHERE id = 'pudim-pacoca-130g';
UPDATE products SET name = 'Pudim de Limão 130g',
  description = 'Azedinho na medida, refrescante.',
  long_desc = 'Pudim de limão siciliano com Leite Moça: azedinho na medida e super refrescante depois do almoço.',
  size_label = '130g · 1 porção'
  WHERE id = 'pudim-limao-130g';
UPDATE products SET name = 'Suco de Maracujá',
  description = 'Natural da fruta, feito na hora.',
  long_desc = 'Suco de maracujá natural 400ml, feito na hora com fruta selecionada. Azedinho e gelado.',
  size_label = '400ml · natural'
  WHERE id = 'suco-maracuja';
UPDATE products SET name = 'Geladinho Gourmet Leite Moça',
  description = 'Geladinho cremoso de pudim de Leite Moça.',
  long_desc = 'Geladinho gourmet cremoso feito com puro Leite Moça. Refrescância de pudim no palito.'
  WHERE id = 'base-geladinho-leite-moca';
UPDATE products SET name = 'Geladinho Gourmet de Coco',
  description = 'Geladinho cremoso de coco com Leite Moça.',
  long_desc = 'Geladinho gourmet cremoso de coco com Leite Moça. Leve, aromático e gelado na medida.'
  WHERE id = 'base-geladinho-coco';
UPDATE product_sizes SET label = '130g · 1 porção'
  WHERE product_id IN ('pudim-pacoca-130g','pudim-limao-130g');
UPDATE product_sizes SET label = '400ml · natural'
  WHERE product_id = 'suco-maracuja';
