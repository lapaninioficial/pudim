-- ============================================================================
-- 28 — Pudim Lapanini EXCLUSIVO (sem lasanha)
-- Converte a loja clonada da "Lapanini lasanhas" em loja de pudins,
-- sobremesas variadas e bebidas. Regras (aprovadas):
--  C1: doces ganha IDs NOVOS (kits mini de pudim); apaga minis de lasanha.
--  C2: selecoes-* viram Kits Mini/Eventos de pudim; apaga kits de lasanha.
--  C3: remove massa-fresca, molhos-caseiros, caldas + insumos massas/molhos.
--  C4: remove adicionais salgados; ativa só os doces.
--  C5: remove preparo Assada/Congelada (baked_fee).
--  C6: ativa bases de geladinho com nomes apetitosos; deleta
--      romeu-julieta, california e chopp-brahma.
--  C7: cria categoria eventos + 5 kits do zero.
--  C8: textos de marca sem lasanha/brasa (settings).
--  C10: limpa fichas/CMV de lasanha; mantém estrutura e fichas de pudim.
-- Ordem FK: ficha_insumos -> fichas -> pool -> sizes -> ingredients ->
-- components -> products -> ingredients/addons -> categories -> settings.
-- ============================================================================

-- ---------- 0. Limpa filhos dos 33 produtos condenados ----------
DELETE fi FROM ficha_insumos fi
  JOIN fichas_tecnicas f ON f.id = fi.ficha_id
 WHERE f.product_id IN (
  'bolonhesa-branca','bolonhesa-vermelha','brocolis-cream-cheese',
  'brocolis-bacon-cream-cheese','frango-branca','frango-vermelha',
  'presunto-branca','presunto-vermelha','queijos-gorgonzola',
  'gorgonzola-bacon','carne-madeira','frango-requeijao','cogumelos',
  'carne-gorgonzola','file-mignon','abobrinha-frango','camarao-branco',
  'bacalhau','mesa-farta','experiencia-mesa','curadoria-casa',
  'selecao-generosa','selecao-compartilhar','selecao-essencial',
  'mini-bolonhesa','mini-frango','mini-queijos','mini-vegetariana',
  'mini-file','romeu-julieta','california','chopp-brahma',
  'calda-caramelo-casa');

DELETE FROM fichas_tecnicas WHERE product_id IN (
  'bolonhesa-branca','bolonhesa-vermelha','brocolis-cream-cheese',
  'brocolis-bacon-cream-cheese','frango-branca','frango-vermelha',
  'presunto-branca','presunto-vermelha','queijos-gorgonzola',
  'gorgonzola-bacon','carne-madeira','frango-requeijao','cogumelos',
  'carne-gorgonzola','file-mignon','abobrinha-frango','camarao-branco',
  'bacalhau','mesa-farta','experiencia-mesa','curadoria-casa',
  'selecao-generosa','selecao-compartilhar','selecao-essencial',
  'mini-bolonhesa','mini-frango','mini-queijos','mini-vegetariana',
  'mini-file','romeu-julieta','california','chopp-brahma',
  'calda-caramelo-casa');

DELETE FROM product_pool WHERE selection_id IN (
  'bolonhesa-branca','bolonhesa-vermelha','brocolis-cream-cheese',
  'brocolis-bacon-cream-cheese','frango-branca','frango-vermelha',
  'presunto-branca','presunto-vermelha','queijos-gorgonzola',
  'gorgonzola-bacon','carne-madeira','frango-requeijao','cogumelos',
  'carne-gorgonzola','file-mignon','abobrinha-frango','camarao-branco',
  'bacalhau','mesa-farta','experiencia-mesa','curadoria-casa',
  'selecao-generosa','selecao-compartilhar','selecao-essencial',
  'mini-bolonhesa','mini-frango','mini-queijos','mini-vegetariana',
  'mini-file','romeu-julieta','california','chopp-brahma',
  'calda-caramelo-casa')
  OR flavor_id IN (
  'bolonhesa-branca','bolonhesa-vermelha','brocolis-cream-cheese',
  'brocolis-bacon-cream-cheese','frango-branca','frango-vermelha',
  'presunto-branca','presunto-vermelha','queijos-gorgonzola',
  'gorgonzola-bacon','carne-madeira','frango-requeijao','cogumelos',
  'carne-gorgonzola','file-mignon','abobrinha-frango','camarao-branco',
  'bacalhau','mesa-farta','experiencia-mesa','curadoria-casa',
  'selecao-generosa','selecao-compartilhar','selecao-essencial',
  'mini-bolonhesa','mini-frango','mini-queijos','mini-vegetariana',
  'mini-file','romeu-julieta','california','chopp-brahma',
  'calda-caramelo-casa');

DELETE FROM product_sizes WHERE product_id IN (
  'bolonhesa-branca','bolonhesa-vermelha','brocolis-cream-cheese',
  'brocolis-bacon-cream-cheese','frango-branca','frango-vermelha',
  'presunto-branca','presunto-vermelha','queijos-gorgonzola',
  'gorgonzola-bacon','carne-madeira','frango-requeijao','cogumelos',
  'carne-gorgonzola','file-mignon','abobrinha-frango','camarao-branco',
  'bacalhau','mesa-farta','experiencia-mesa','curadoria-casa',
  'selecao-generosa','selecao-compartilhar','selecao-essencial',
  'mini-bolonhesa','mini-frango','mini-queijos','mini-vegetariana',
  'mini-file','romeu-julieta','california','chopp-brahma',
  'calda-caramelo-casa');

DELETE FROM product_ingredients WHERE product_id IN (
  'bolonhesa-branca','bolonhesa-vermelha','brocolis-cream-cheese',
  'brocolis-bacon-cream-cheese','frango-branca','frango-vermelha',
  'presunto-branca','presunto-vermelha','queijos-gorgonzola',
  'gorgonzola-bacon','carne-madeira','frango-requeijao','cogumelos',
  'carne-gorgonzola','file-mignon','abobrinha-frango','camarao-branco',
  'bacalhau','mesa-farta','experiencia-mesa','curadoria-casa',
  'selecao-generosa','selecao-compartilhar','selecao-essencial',
  'mini-bolonhesa','mini-frango','mini-queijos','mini-vegetariana',
  'mini-file','romeu-julieta','california','chopp-brahma',
  'calda-caramelo-casa');

DELETE FROM product_components WHERE product_id IN (
  'bolonhesa-branca','bolonhesa-vermelha','brocolis-cream-cheese',
  'brocolis-bacon-cream-cheese','frango-branca','frango-vermelha',
  'presunto-branca','presunto-vermelha','queijos-gorgonzola',
  'gorgonzola-bacon','carne-madeira','frango-requeijao','cogumelos',
  'carne-gorgonzola','file-mignon','abobrinha-frango','camarao-branco',
  'bacalhau','mesa-farta','experiencia-mesa','curadoria-casa',
  'selecao-generosa','selecao-compartilhar','selecao-essencial',
  'mini-bolonhesa','mini-frango','mini-queijos','mini-vegetariana',
  'mini-file','romeu-julieta','california','chopp-brahma',
  'calda-caramelo-casa');

-- ---------- 1. Apaga os 33 produtos de lasanha/internos ----------
DELETE FROM products WHERE id IN (
  'bolonhesa-branca','bolonhesa-vermelha','brocolis-cream-cheese',
  'brocolis-bacon-cream-cheese','frango-branca','frango-vermelha',
  'presunto-branca','presunto-vermelha','queijos-gorgonzola',
  'gorgonzola-bacon','carne-madeira','frango-requeijao','cogumelos',
  'carne-gorgonzola','file-mignon','abobrinha-frango','camarao-branco',
  'bacalhau','mesa-farta','experiencia-mesa','curadoria-casa',
  'selecao-generosa','selecao-compartilhar','selecao-essencial',
  'mini-bolonhesa','mini-frango','mini-queijos','mini-vegetariana',
  'mini-file','romeu-julieta','california','chopp-brahma',
  'calda-caramelo-casa');

-- ---------- 2. Insumos exclusivos de lasanha (C3) ----------
DELETE FROM ingredients WHERE category IN ('massas','molhos');

-- ---------- 3. Adicionais salgados (C4): mantém só grupo doce ----------
DELETE FROM addons WHERE grp IN ('borda','molho','extra','retirar','salgado');
UPDATE addons SET active = 1 WHERE grp = 'doce';

-- ---------- 4. Categorias: apaga 10 de lasanha/internas, cria eventos ----------
DELETE FROM products WHERE cat_id IN ('classicos','deluxe','especiais',
  'lowcarb','frutosdormar','selecoes-fechadas','selecoes-personalizadas',
  'massa-fresca','molhos-caseiros','caldas');
DELETE FROM categories WHERE id IN ('classicos','deluxe','especiais',
  'lowcarb','frutosdormar','selecoes-fechadas','selecoes-personalizadas',
  'massa-fresca','molhos-caseiros','caldas');

INSERT INTO categories (id, name, short, kicker, position, active) VALUES
  ('eventos','Eventos','Eventos','Kits de pudins e sobremesas para festas e empresas',2,1)
  ON DUPLICATE KEY UPDATE name=VALUES(name), short=VALUES(short),
    kicker=VALUES(kicker), position=VALUES(position), active=VALUES(active);

-- Nomes/kickers sem lasanha + ordem final das 8 secoes (C8 parcial)
UPDATE categories SET name='Kits Mini', short='Kits Mini',
  kicker='Mini pudins e sobremesas para festas e eventos', position=1, active=1
  WHERE id='doces';
UPDATE categories SET position=3, active=1 WHERE id='sobremesas';
UPDATE categories SET name='Escolha sua bebida', short='Bebidas',
  kicker='Bebidas para acompanhar seu pudim', position=4, active=1
  WHERE id='bebidas';
UPDATE categories SET name='Geladinhos', short='Geladinhos',
  kicker='Geladinhos gourmet feitos na casa', position=5, active=1
  WHERE id='geladinhos';
UPDATE categories SET position=6, active=1 WHERE id='mais-pedidos';
UPDATE categories SET position=7, active=1 WHERE id='promocao-do-dia';
UPDATE categories SET position=8, active=1 WHERE id='top-mais-vendidos';

-- ---------- 5. Preparo Assada/Congelada fora (C5) + textos de marca (C8) ----------
DELETE FROM settings WHERE k = 'baked_fee';
UPDATE settings SET v = 'Pudim Lapanini' WHERE k = 'store_name';
UPDATE settings SET v = 'Pudins Artesanais' WHERE k = 'tagline';
UPDATE settings SET v = 'Semana do Pudim: 10% OFF com PUDIMHASS10'
  WHERE k = 'offer_text';
UPDATE settings SET v = '<b>Pudim Lapanini</b><br>Rua Osvaldo Serra, 193 - Jd. Interlagos<br>Campinas - SP<br>'
  WHERE k = 'foot_address';

-- Rótulo de tempo de lasanha ("forno") -> "Feito no dia" / "Gelada"
UPDATE products SET time_label = 'Feito no dia'
  WHERE cat_id IN ('doces','eventos','sobremesas','mais-pedidos',
    'promocao-do-dia','top-mais-vendidos');
UPDATE products SET time_label = 'Gelada'
  WHERE cat_id IN ('bebidas','geladinhos');

-- ---------- 6. Geladinhos: ativa as 2 bases com nomes apetitosos (C6) ----------
UPDATE products
  SET name='Geladinho Gourmet Leite Moca', base_price=12.90,
      description='Geladinho cremoso de pudim de Leite Moca.',
      long_desc='Geladinho gourmet cremoso feito com puro Leite Moca. Refrescancia de pudim no palito.',
      addon_group='doce', time_label='Gelada', tags='Gourmet', position=101,
      active=1
  WHERE id='base-geladinho-leite-moca';
UPDATE products
  SET name='Geladinho Gourmet de Coco', base_price=12.90,
      description='Geladinho cremoso de coco com Leite Moca.',
      long_desc='Geladinho gourmet cremoso de coco com Leite Moca. Leve, aromatico e gelado na medida.',
      addon_group='doce', time_label='Gelada', tags='Gourmet', position=102,
      active=1
  WHERE id='base-geladinho-coco';

-- ---------- 7. Kits Mini novos, IDs limpos (C1) ----------
-- Re-execucao segura: limpa filhos dos IDs novos antes de inserir.
DELETE FROM product_sizes WHERE product_id IN (
  'kit-mini-festa','kit-mini-reuniao','kit-mini-caseiro',
  'kit-mini-aniversario','kit-mini-cafe-tarde','kit-festa-doce-10un',
  'kit-casamento-mini','kit-aniversario-kids','kit-escritorio',
  'kit-degustacao','pudim-pacoca-130g','pudim-limao-130g','suco-maracuja');
DELETE FROM product_components WHERE product_id IN (
  'kit-mini-festa','kit-mini-reuniao','kit-mini-caseiro',
  'kit-mini-aniversario','kit-mini-cafe-tarde','kit-festa-doce-10un',
  'kit-casamento-mini','kit-aniversario-kids','kit-escritorio',
  'kit-degustacao');
DELETE FROM product_ingredients WHERE product_id IN (
  'pudim-pacoca-130g','pudim-limao-130g');
INSERT INTO products (id, cat_id, name, base_price, description, long_desc,
  old_price, type, addon_group, encomenda, frete_gratis, badge, size_label,
  discount, time_label, tags, position, active) VALUES
('kit-mini-festa','doces','Kit Mini Festa',89.90,
  '6 mini pudins + 2 fatias de torta para a festa.',
  'Kit com 6 mini pudins sortidos (tradicional, coco, cafe e doce de leite) + 2 fatias de torta (alfajor e chocolate belga). Serve 6 a 8 pessoas.',
  NULL,'kit','doce',0,0,'','Caixa com 8 un.',0,'Feito no dia','Festa,Presenteavel',10,1),
('kit-mini-reuniao','doces','Kit Mini Reuniao',119.90,
  '8 mini pudins + 4 fatias de torta para reunir a turma.',
  'Kit com 8 mini pudins sortidos + 4 fatias de torta variadas (alfajor, chaja, chocolate belga e sorvete alfajor). Serve 10 a 12 pessoas.',
  NULL,'kit','doce',0,0,'','Caixa com 12 un.',0,'Feito no dia','Reuniao',11,1),
('kit-mini-caseiro','doces','Kit Mini Caseiro',59.90,
  '4 mini pudins para a semana em casa.',
  'Kit com 4 mini pudins sortidos para deixar a semana resolvida: tradicional, coco, cafe e doce de leite.',
  NULL,'kit','doce',0,0,'','Caixa com 4 un.',0,'Feito no dia','Casa',12,1),
('kit-mini-aniversario','doces','Kit Mini Aniversario',99.90,
  '6 mini pudins + 1 geladinho para cantar parabens.',
  'Kit aniversario com 6 mini pudins sortidos + 1 geladinho gourmet de Leite Moca. Ready para a velinha.',
  NULL,'kit','doce',0,0,'','Caixa com 7 un.',0,'Feito no dia','Aniversario,Kids',13,1),
('kit-mini-cafe-tarde','doces','Kit Mini Cafe da Tarde',79.90,
  '4 mini pudins + 2 fatias de torta para o cafe.',
  'Kit cafe da tarde com 4 mini pudins sortidos + 2 fatias de torta (chaja e alfajor). Combina com cafe fresquinho.',
  NULL,'kit','doce',0,0,'','Caixa com 6 un.',0,'Feito no dia','Cafe',14,1)
ON DUPLICATE KEY UPDATE cat_id=VALUES(cat_id), name=VALUES(name),
  base_price=VALUES(base_price), description=VALUES(description),
  long_desc=VALUES(long_desc), type=VALUES(type),
  addon_group=VALUES(addon_group), size_label=VALUES(size_label),
  time_label=VALUES(time_label), tags=VALUES(tags),
  position=VALUES(position), active=VALUES(active);

INSERT INTO product_sizes (product_id, size_id, label, factor, price, position) VALUES
('kit-mini-festa','u','Caixa com 8 un.',1,NULL,0),
('kit-mini-reuniao','u','Caixa com 12 un.',1,NULL,0),
('kit-mini-caseiro','u','Caixa com 4 un.',1,NULL,0),
('kit-mini-aniversario','u','Caixa com 7 un.',1,NULL,0),
('kit-mini-cafe-tarde','u','Caixa com 6 un.',1,NULL,0)
;

INSERT INTO product_components (product_id, label, position) VALUES
('kit-mini-festa','2x Pudim Tradicional da Casa 100g',0),
('kit-mini-festa','1x Pudim de Coco 130g',1),
('kit-mini-festa','1x Pudim de Cafe 130g',2),
('kit-mini-festa','1x Pudim de Doce de Leite 130g',3),
('kit-mini-festa','1x Pudim Tradicional da Casa Familia 380g (fatiado)',4),
('kit-mini-festa','1x Torta Alfajor na Fatia',5),
('kit-mini-festa','1x Torta de Chocolate Belga',6),
('kit-mini-reuniao','3x Pudim Tradicional da Casa 100g',0),
('kit-mini-reuniao','2x Pudim de Coco 130g',1),
('kit-mini-reuniao','2x Pudim de Cafe 130g',2),
('kit-mini-reuniao','1x Pudim de Doce de Leite 130g',3),
('kit-mini-reuniao','1x Torta Alfajor na Fatia',4),
('kit-mini-reuniao','1x Torta Chaja',5),
('kit-mini-reuniao','1x Torta de Chocolate Belga',6),
('kit-mini-reuniao','1x Torta de Sorvete Alfajor',7),
('kit-mini-caseiro','1x Pudim Tradicional da Casa 100g',0),
('kit-mini-caseiro','1x Pudim de Coco 130g',1),
('kit-mini-caseiro','1x Pudim de Cafe 130g',2),
('kit-mini-caseiro','1x Pudim de Doce de Leite 130g',3),
('kit-mini-aniversario','2x Pudim Tradicional da Casa 100g',0),
('kit-mini-aniversario','2x Pudim de Coco 130g',1),
('kit-mini-aniversario','2x Pudim de Doce de Leite 130g',2),
('kit-mini-aniversario','1x Geladinho Gourmet Leite Moca',3),
('kit-mini-cafe-tarde','2x Pudim Tradicional da Casa 100g',0),
('kit-mini-cafe-tarde','1x Pudim de Cafe 130g',1),
('kit-mini-cafe-tarde','1x Pudim de Doce de Leite 130g',2),
('kit-mini-cafe-tarde','1x Torta Chaja',3),
('kit-mini-cafe-tarde','1x Torta Alfajor na Fatia',4);

-- ---------- 8. Eventos: 5 kits do zero (C7) ----------
INSERT INTO products (id, cat_id, name, base_price, description, long_desc,
  old_price, type, addon_group, encomenda, frete_gratis, badge, size_label,
  discount, time_label, tags, position, active) VALUES
('kit-festa-doce-10un','eventos','Kit Festa Doce (10 un)',149.90,
  '10 porcoes de pudins e tortas para a festa.',
  'Kit festa com 6 mini pudins sortidos + 4 fatias de torta variadas. Serve 10 pessoas. Encomenda com 24h.',
  NULL,'kit','doce',1,0,'','10 porcoes',0,'Feito no dia','Festa,Evento',20,1),
('kit-casamento-mini','eventos','Kit Casamento Mini',189.90,
  'Lembrancinhas doces para os convidados.',
  'Kit casamento com 10 mini pudins em potinhos individuais (tradicional, coco e doce de leite) + etiqueta personalizada. Encomenda com 48h.',
  NULL,'kit','doce',1,0,'','10 potinhos',0,'Feito no dia','Casamento,Lembrancinha',21,1),
('kit-aniversario-kids','eventos','Kit Aniversario Kids',99.90,
  'Festa kids com pudim e geladinho.',
  'Kit kids com 4 mini pudins + 4 geladinhos gourmet (leite moca e coco). Faz a alegria da criancada. Encomenda com 24h.',
  NULL,'kit','doce',1,0,'','8 porcoes',0,'Feito no dia','Kids,Aniversario',22,1),
('kit-escritorio','eventos','Kit Escritorio',119.90,
  'Coffee break doce para a equipe.',
  'Kit escritorio com 6 mini pudins + 2 fatias de torta grande (chocolate belga e chaja). Ideal para coffee break de 8 pessoas. Encomenda com 24h.',
  NULL,'kit','doce',1,0,'','8 porcoes',0,'Feito no dia','Empresa,Coffee',23,1),
('kit-degustacao','eventos','Kit Degustacao',79.90,
  'Prove todos os sabores da casa.',
  'Kit degustacao com 1 mini de cada sabor: tradicional, coco, cafe, doce de leite + 1 fatia de torta alfajor + 1 geladinho. Para conhecer a casa inteira.',
  NULL,'kit','doce',0,0,'','6 porcoes',0,'Feito no dia','Degustacao',24,1)
ON DUPLICATE KEY UPDATE cat_id=VALUES(cat_id), name=VALUES(name),
  base_price=VALUES(base_price), description=VALUES(description),
  long_desc=VALUES(long_desc), type=VALUES(type),
  addon_group=VALUES(addon_group), size_label=VALUES(size_label),
  time_label=VALUES(time_label), tags=VALUES(tags),
  position=VALUES(position), active=VALUES(active);

INSERT INTO product_sizes (product_id, size_id, label, factor, price, position) VALUES
('kit-festa-doce-10un','u','10 porcoes',1,NULL,0),
('kit-casamento-mini','u','10 potinhos',1,NULL,0),
('kit-aniversario-kids','u','8 porcoes',1,NULL,0),
('kit-escritorio','u','8 porcoes',1,NULL,0),
('kit-degustacao','u','6 porcoes',1,NULL,0)
;

INSERT INTO product_components (product_id, label, position) VALUES
('kit-festa-doce-10un','4x Pudim Tradicional da Casa 100g',0),
('kit-festa-doce-10un','2x Pudim de Coco 130g',1),
('kit-festa-doce-10un','2x Torta Alfajor na Fatia',2),
('kit-festa-doce-10un','2x Torta de Chocolate Belga',3),
('kit-casamento-mini','4x Pudim Tradicional da Casa 100g (potinho)',0),
('kit-casamento-mini','3x Pudim de Coco 130g (potinho)',1),
('kit-casamento-mini','3x Pudim de Doce de Leite 130g (potinho)',2),
('kit-aniversario-kids','2x Pudim Tradicional da Casa 100g',0),
('kit-aniversario-kids','2x Pudim de Doce de Leite 130g',1),
('kit-aniversario-kids','2x Geladinho Gourmet Leite Moca',2),
('kit-aniversario-kids','2x Geladinho Gourmet de Coco',3),
('kit-escritorio','3x Pudim Tradicional da Casa 100g',0),
('kit-escritorio','3x Pudim de Cafe 130g',1),
('kit-escritorio','1x Torta de Chocolate Belga',2),
('kit-escritorio','1x Torta Chaja',3),
('kit-degustacao','1x Pudim Tradicional da Casa 100g',0),
('kit-degustacao','1x Pudim de Coco 130g',1),
('kit-degustacao','1x Pudim de Cafe 130g',2),
('kit-degustacao','1x Pudim de Doce de Leite 130g',3),
('kit-degustacao','1x Torta Alfajor na Fatia',4),
('kit-degustacao','1x Geladinho Gourmet Leite Moca',5);

-- ---------- 9. Sobremesas: +2 para fechar 11 ativas ----------
INSERT INTO products (id, cat_id, name, base_price, description, long_desc,
  old_price, type, addon_group, encomenda, frete_gratis, badge, size_label,
  discount, time_label, tags, position, active) VALUES
('pudim-pacoca-130g','sobremesas','Pudim de Pacoca 130g',15.90,
  'Cremoso com crocante de pacoca.',
  'Pudim cremoso de Leite Moca com pacoca de verdade e crocante por cima. O queridinho junino o ano todo.',
  NULL,'reg','doce',0,0,'','130g - 1 porcao',0,'Feito no dia','130g',79,1),
('pudim-limao-130g','sobremesas','Pudim de Limao 130g',15.90,
  'Azedinho na medida, refrescante.',
  'Pudim de limao siciliano com Leite Moca: azedinho na medida e super refrescante depois do almoco.',
  NULL,'reg','doce',0,0,'','130g - 1 porcao',0,'Feito no dia','130g',80,1)
ON DUPLICATE KEY UPDATE cat_id=VALUES(cat_id), name=VALUES(name),
  base_price=VALUES(base_price), description=VALUES(description),
  long_desc=VALUES(long_desc), addon_group=VALUES(addon_group),
  time_label=VALUES(time_label), tags=VALUES(tags),
  position=VALUES(position), active=VALUES(active);

INSERT INTO product_sizes (product_id, size_id, label, factor, price, position) VALUES
('pudim-pacoca-130g','u','130g - 1 porcao',1,NULL,0),
('pudim-limao-130g','u','130g - 1 porcao',1,NULL,0)
;

INSERT INTO product_ingredients (product_id, label, position, is_ficha) VALUES
('pudim-pacoca-130g','Leite condensado',0,0),
('pudim-pacoca-130g','Pacoca',1,0),
('pudim-pacoca-130g','Calda de caramelo',2,0),
('pudim-limao-130g','Leite condensado',0,0),
('pudim-limao-130g','Limao siciliano',1,0),
('pudim-limao-130g','Calda de caramelo',2,0);

-- ---------- 10. Bebidas: +1 para fechar 5 ativas ----------
INSERT INTO products (id, cat_id, name, base_price, description, long_desc,
  old_price, type, addon_group, encomenda, frete_gratis, badge, size_label,
  discount, time_label, tags, position, active) VALUES
('suco-maracuja','bebidas','Suco de Maracuja',8.90,
  'Natural da fruta, feito na hora.',
  'Suco de maracuja natural 400ml, feito na hora com fruta selecionada. Azedinho e gelado.',
  NULL,'reg','',0,0,'','400ml - natural',0,'Gelada','Natural',85,1)
ON DUPLICATE KEY UPDATE cat_id=VALUES(cat_id), name=VALUES(name),
  base_price=VALUES(base_price), description=VALUES(description),
  long_desc=VALUES(long_desc), time_label=VALUES(time_label),
  tags=VALUES(tags), position=VALUES(position), active=VALUES(active);

INSERT INTO product_sizes (product_id, size_id, label, factor, price, position)
  VALUES ('suco-maracuja','u','400ml - natural',1,NULL,0)
  ;

-- ---------- 11. Tamanhos das bases de geladinho (caso faltem) ----------
INSERT INTO product_sizes (product_id, size_id, label, factor, price, position)
  SELECT * FROM (SELECT 'base-geladinho-leite-moca' AS pid, 'u' AS sid,
    'Unidade - geladinho' AS lbl, 1 AS f, NULL AS pr, 0 AS pos) s
  WHERE NOT EXISTS (SELECT 1 FROM product_sizes
    WHERE product_id='base-geladinho-leite-moca');
INSERT INTO product_sizes (product_id, size_id, label, factor, price, position)
  SELECT * FROM (SELECT 'base-geladinho-coco' AS pid, 'u' AS sid,
    'Unidade - geladinho' AS lbl, 1 AS f, NULL AS pr, 0 AS pos) s
  WHERE NOT EXISTS (SELECT 1 FROM product_sizes
    WHERE product_id='base-geladinho-coco');

-- ---------- 12. Ajustes finos ----------
-- Kits usam size_id 'kit' (filtro do painel + vitrine).
UPDATE product_sizes SET size_id = 'kit' WHERE product_id IN (
  'kit-mini-festa','kit-mini-reuniao','kit-mini-caseiro',
  'kit-mini-aniversario','kit-mini-cafe-tarde','kit-festa-doce-10un',
  'kit-casamento-mini','kit-aniversario-kids','kit-escritorio',
  'kit-degustacao') AND size_id = 'u';
-- Texto sem lasanha.
UPDATE products
  SET long_desc = 'Coca-Cola lata 350ml gelada, perfeita para acompanhar seu pudim.'
  WHERE id = 'coca-cola-350' AND long_desc LIKE '%lasanha%';
