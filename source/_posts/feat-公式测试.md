---
title: 数学公式测试
date: 2023-07-03 10:26:00
toc: true
tags: math
mathjax: true
category: featTest
---
*原文来自 <www.hozen.site> [机器学习基础-“逻辑”回归 (logistic regression) 的数学原理](<https://www.hozen.site/archives/33/>*

通过使用 logistic regression 处理一个二分类问题来简要分析其中的数学原理。
<!--more-->

### 问题

假设我们有这样一个问题，根据医学图像来判断病人的肿瘤为恶性还是良性，这就是一个二分类问题。

相对于回归问题，分类问题的输出值为离散值。进一步地，二分类的输出值只有两个，通常称其为“正类”和“负类”，也可以用 1 和 0 分别表示。

### 思路

同回归问题一样，我们希望得到假设 $h_\boldsymbol\theta(\boldsymbol{x})$ 对应的代价函数 $J(\boldsymbol\theta)$，并通过最小化代价函数来确定合适的参数值 $\boldsymbol\theta$。

下面推导代价函数：

先明确一些记法：粗体字母代表向量，一般使用 $\boldsymbol{x}$ 表示一个样例的特征向量，$\boldsymbol{\theta}$ 表示参数向量，实数 $y\in\{0,1\}$ 表示该样例的标记。当处理多个样例时，使用 $\boldsymbol{x^{(j)}}$ 表示第 $j$ 个样例的特征向量, 对应的标记为 $y^{(j)}$。向量 $\boldsymbol{y}$ 表示多个样例的标记向量。具体的：

$$
\boldsymbol{x^{(j)}}=\left[\begin{matrix}
x^{(j)}_1 \\
x^{(j)}_2 \\
\vdots \\
x^{(j)}_n \\
\end{matrix}\right],\
\boldsymbol\theta=\left[\begin{matrix}
\theta_0 \\
\theta_1 \\
\vdots \\
\theta_n \\
\end{matrix}\right],\
\boldsymbol{y} = \left[\begin{matrix}
y^{(1)}\\
y^{(2)}\\
\vdots \\
y^{(m)}\\
\end{matrix}\right]
$$

#### [最大似然估计](https://baike.baidu.com/item/%E6%9C%80%E5%A4%A7%E4%BC%BC%E7%84%B6%E4%BC%B0%E8%AE%A1/4967925?fr=aladdin)（[Maximum Likelihood Estimation](https://en.wikipedia.org/wiki/Maximum_likelihood_estimation)）

与线性回归直接输出连续的结果不同，对于分类问题，我们期望能得到一个函数 $h_\boldsymbol\theta(\boldsymbol{x})$ 来表示特征 $\boldsymbol{x}$ 下结果为正类的概率，即 $h_\boldsymbol\theta(\boldsymbol{x}) = P\{Y=1|\boldsymbol{x}\}$。自然地，若 $h_\boldsymbol\theta(x) > 0.5$ 我们倾向于认为结果为正类，反之倾向于负类。

结合实例，这意味着我们输入病人医学图像的特征 $x$，便可以给出该病人肿瘤为恶性的概率(将恶性划分为正类)，若该值大于 $0.5$ 则倾向于认为肿瘤为恶性，反之认为良性。

由于二分类问题的结果非此即彼，所以应有：

$$
P\{Y=1|\boldsymbol{x}\} = h_\boldsymbol\theta(\boldsymbol{x})
$$
$$
P\{Y=0|\boldsymbol{x}\} = 1 - h_\boldsymbol\theta(\boldsymbol{x})
$$

上式等价于：
$$
P\{Y=y|\boldsymbol{x}\} = yh_\boldsymbol\theta(\boldsymbol{x}) + [1-y](1-h_\boldsymbol\theta(\boldsymbol{x})), \ y\in\{0,1\}
$$

对于 $m$ 个训练样本 $\{\boldsymbol{x}^{(j)}, y^{(j)}\},\ j=1,2,3,\cdots,m$，将其视为随机事件，则每一个样本的出现的概率为:
$$
P\{Y=y^{(j)}|\boldsymbol{x}^{(j)}\} = y^{(j)}h_\boldsymbol\theta(\boldsymbol{x}^{(j)})+(1-y^{(j)})[1-h_\boldsymbol\theta(\boldsymbol{x}^{(j)})],\ y^{(j)}\in\{0,1\}
$$

由于每个样本相互独立，则出现该样本的概率为：
$$
\prod_{j=1}^m P\{Y=y^{(j)}|\boldsymbol{x}^{(j)}\},\ y^{(j)} \in \{0, 1\}
$$
即：
$$
\prod_{j=1}^m \left\{ y^{(j)}h_\boldsymbol\theta(\boldsymbol{x}^{(j)}) + (1-y^{(j)})[1-h_\boldsymbol\theta(\boldsymbol{x}^{(j)})] \right\},\ y^{(j)} \in \{0,1\}
$$

至此我们得到一个关于 $\boldsymbol\theta$ 的函数，记为 $L(\boldsymbol\theta)$，该函数值代表了出现该训练样本的概率。最大似然估法计考虑这样一个问题，为什么会出现这样的样本分布而不是其他的分布呢？我们只能认为出现这样的分布概率是大于其他分布的，也就是说只有出现该样本分布的概率 $L(\boldsymbol\theta)$ 尽可能的大我们才得到了这个样本分布。因此我们只需求得 $j(\boldsymbol\theta)$ 取得最大值所对应的 $\hat{\boldsymbol\theta}$，便是我们对 $h_\boldsymbol\theta(\boldsymbol{x})$ 参数值 $\boldsymbol\theta$ 合理估计。这便是最大似然参数估计法的思想。

至此，我们可将代价函数看作 $-L(\boldsymbol\theta)$，我们只有使代价函数尽可能的小，即 $L(\boldsymbol\theta)$ 尽可能的大才能得到合理的 $\boldsymbol\theta$。而 $-L(\boldsymbol\theta)$ 中的 $h_\boldsymbol\theta(\boldsymbol{x})$ 还不明确，我们需要明确其形式。

#### 确定 $h_\boldsymbol\theta(\boldsymbol{x})$ 的形式

显然线性回归中的假设函数 $h_\boldsymbol\theta(\boldsymbol{x}) = \boldsymbol\theta_0 + \sum\limits_{i=1}^n\boldsymbol\theta_ix_i$ 的形式不满足分类问题，因为在分类问题中我们期望把得到的 $h_\boldsymbol\theta(\boldsymbol{x})$ 看作是一个概率，所以其值应该是在区间 $[0,1]$ 内的。为此，我们可以对原函数进行“挤压”，使其值域属于 $(0,1)$。此时便用到了 [S 型函数](https://baike.baidu.com/item/S%E5%9E%8B%E5%87%BD%E6%95%B0/19178062?fr=aladdin)（[Sigmoid function](https://en.wikipedia.org/wiki/Sigmoid_function)）:
$$
sigmod(z) = \frac{1}{1+e^{-z}},\ z \in \mathbf{R}
$$

所以令
$$
h_\boldsymbol\theta(\boldsymbol{x}) = \frac{1}{1 + e^{-z}},\
z = \boldsymbol\theta_0 + \sum\limits_{i=1}^n\boldsymbol\theta_ix_i
$$

其中 $z$ 也可记为矩阵形式：
$$
\ z = \boldsymbol{\theta}^T \left[ \begin{matrix}1 \\ \boldsymbol{x} \end{matrix} \right]
$$

至此我们就得到了 $h_\boldsymbol\theta(\boldsymbol{x})$ 的表达式。

#### 整理得到代价函数 $J(\boldsymbol\theta)$

确定了 $h_\boldsymbol\theta(\boldsymbol{x})$ 形式后，$L(\boldsymbol\theta)$ 的形式完全确定，在给定训练数据下是一个关于 $\boldsymbol\theta$ 的函数。我们可以使用 $-L(\boldsymbol\theta)$ 作为代价函数，但在最大似然估计法中更常用的方法是对 $L(\boldsymbol\theta)$ 取对数化简（$\ln$ 函数的单调性保证了化简前后同时取得最值），令
$$
J(\boldsymbol\theta) = -\frac1{m}\ln L(\boldsymbol\theta)
$$

进一步得到：
$$
J(\boldsymbol\theta) =
\begin{cases}
-\frac1{m}\sum\limits_{j=1}^m \ln[h_\boldsymbol\theta(\boldsymbol{x}^{(j)})], & y^{(j)} = 1.\\
-\frac1{m}\sum\limits_{j=1}^m \ln[1-h_\boldsymbol\theta(\boldsymbol{x}^{(j)})], & y^{(j)}=0.
\end{cases}
$$

同样可合并，写为:
$$
J(\boldsymbol\theta) = -\frac1{m}\sum_{j=1}^m\Big(y^{(j)}\ln[h_\boldsymbol\theta(\boldsymbol{x}^{(j)})] + (1-y^{(j)})\ln[1-h_\boldsymbol\theta(\boldsymbol{x}^{(j)})]\Big)
$$

至此便得到了代价函数 $J(\boldsymbol\theta)$ 的表达式，接下来就是最小化代价函数以得到合适的参数向量 $\boldsymbol{\theta}$

### 梯度下降

梯度下降的核心在于求得代价函数的梯度 $\mathbf{Grad}J(\boldsymbol\theta)$，由高等数学知识可知:
$$
\mathbf{Grad}J(\boldsymbol\theta) = (\frac{\partial{J}}{\partial\boldsymbol{\theta}_0}, \frac{\partial{J}}{\partial\boldsymbol{\theta}_1}, \cdots, \frac{\partial{J}}{\partial\boldsymbol{\theta}_n})
$$

下面求 $\frac{\partial J}{\partial\boldsymbol{\theta}_i}$：

先将 $h_\boldsymbol\theta(\boldsymbol{x}) = \frac1{1+e^{-z}}$ 带入 $J(\boldsymbol\theta)$，并化简，可得：

$$
J(\boldsymbol\theta) = \frac1{m}\sum\limits_{j=1}^m\left[\ln(1+e^{z^{(j)}}) - y^{(j)}z^{(j)}\right],\ z^{(j)} = \boldsymbol{\theta}^T\left[ \begin{matrix} 1 \\ \boldsymbol{x}^{(j)} \end{matrix} \right]
$$

则有：

$$
\begin{aligned}
\frac{\partial{J}}{\partial\boldsymbol\theta_i} &= \frac{\partial J}{\partial z} \cdot \frac{\partial z}{\partial\boldsymbol\theta_i} \\
&= \frac1{m}\sum\limits_{j=1}^m\Big(\frac{e^{z^{(j)}}}{1+e^{z^{(j)}}}-y^{(j)}\Big)x^{(j)}*i \\
&= \frac1{m}\sum*{j=1}^{m}\left[h_\boldsymbol\theta(x^{(j)}) - y^{(j)}\right]x_i^{(j)}
\end{aligned}
$$

至此我们就求出了代价函数对于每个参数 $\boldsymbol\theta_i$ 的偏导，我们就可以使用梯度下降法来求得使代价函数足够小时的所有参数了：

```bash
// 选取合适的下降率 alpha
repeat until converge {
  theta0 := theta0 - alpha * grad0;
  theta1 := theta1 - alpha * grad1;
  ...
  thetan := thetan - alpha * gradn;
}
```

在很多场景下使用矩阵运算往往具有更高的效率，下面根据 $\frac{\partial J}{\partial\boldsymbol\theta_i}$ 的计算公式可得到 $\frac{\partial J}{\partial\boldsymbol{\theta}}$ 的矩阵表示法：

首先记:
$$
\boldsymbol{X} = \left[
  \begin{matrix}
    1 & [x^{(1)}]^T \\
    1 & [x^{(2)}]^T \\
    \vdots & \vdots \\
    1 & [x^{(m)}]^T \\
  \end{matrix}
  \right]
$$

则有：
$$
\frac{\partial J}{\partial\boldsymbol{\theta}}
= \frac1m\boldsymbol{X}^T\left[h_\boldsymbol\theta(X\times\boldsymbol{\theta}) - y\right]
$$
