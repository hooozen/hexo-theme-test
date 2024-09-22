---
title: markdown 绘图测试
date: 2024-01-09 11:02:00
tags: markdown
category: featTest
---

本文测试 markdwon 的绘图扩展 mermaid，该插件支持在 markdown 中插入各类图表。

<!--more-->

## 准备工作

- 首先安装依赖

```bash
npm install hexo-filter-mermaid-diagrams
```

- 在配置文件中启用

```yml
mermaid:
  enable: true # 启用 Mermaid 增强
  version: latest
  options: 
    startOnload: true
```

## 使用

 然后就可以在 markdown 文章中绘图了（用法就是代码块设置为 mermaid）

<pre class="md">
&#96;&#96;&#96;mermaid
  graph LR
    A --> B
    A --> D
&#96;&#96;&#96;
</pre>

渲染为：

```mermaid

graph LR
  A --> B
  A --> D

```

## 其他

- 如果想要在本地预览 mermaid 的渲染结果，需要支持 mermaid 的 markdown 编译器。如果使用 vscode，需要下载 [Markdown Preview Mermaid Support](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid) 这个插件。

- Mermaid 的具体的用法可参考 [Mermaid 指引](http://mermaid.js.org/intro/)。

