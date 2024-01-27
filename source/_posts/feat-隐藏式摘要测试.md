---
title: 隐藏式摘要测试
date: 2024-01-27 11:58:32
tags: text
category: featTest
cover: assets/hozen-durdledoor.jpg
abstract: "该文章测试隐藏式摘要功能，此文本只会在文章列表展示，文章正文中不再出现"
---

本段是文章的节录 (excerpt)，正常情况下会展示在文章列表页，但由于本文设置了 `abstract`，本段内容会被 `abstract` 内容覆盖作为文章摘要显示在文章列表中。

<!--more-->

通过在[Front-matter](https://hexo.io/zh-cn/docs/front-matter)中设置 `abstract` 字段来设置隐藏式摘要，abstract 的设置不同于通过在正文使用 `<!--more-->` 隔断的节录（excerpt）。abstract 的内容不会再出现在正文中，并且 abstrct 会覆盖 excerpt 在文章列表的中的展示。

```yml
---
title: 隐藏式摘要测试
date: 2024-01-27 11:58:32
tags: text
category: featTest
cover: assets/hozen-durdledoor.jpg
abstract: "该文章测试隐藏式摘要功能，此文本只会在文章列表展示，文章正文中不再出现。"
---
```

![hozen, Durdle Door, 2023.6](/tranquility/assets/hozen-durdledoor-l.jpg)
