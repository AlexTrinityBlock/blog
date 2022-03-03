---
title: "LaTex畫出矩陣"
date: 2022-03-03T14:43:44+08:00
draft: true
featured_image: "/secure.jpg"
tags: ["math"]
---

# 繪製出普通的矩陣

```latex
\documentclass{article}
\usepackage{amsmath}
\begin{document}

$\begin{bmatrix}
    a & b & d\\ 
    c & d & d
\end{bmatrix}$

\end{document}
```
<p>
$\begin{bmatrix}
    a & b & d\\ 
    c & d & d
\end{bmatrix}$
</p>

# 繪製出有線的矩陣

```latex
\documentclass{article}
\usepackage{amsmath}
\begin{document}

$\begin{bmatrix}
	\begin{array}{cc|c}
		  a & b & d\\ 
		  c & d & d
	\end{array}
\end{bmatrix}$

\end{document}
```

<p>
$\begin{bmatrix}
	\begin{array}{cc|c}
		  a & b & d\\ 
		  c & d & d
	\end{array}
\end{bmatrix}$

</p>

<script>
MathJax = {
  tex: {
    inlineMath: [['$', '$'], ['\\(', '\\)']]
  }
};
</script>
<script id="MathJax-script" async
  src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js">
</script>