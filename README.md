# HDU_Latex
The LaTeX template of thesis of HDU 

## 杭州电子科技大学计算机学院硕士研究生学位论文LaTeX模板
根据 @cughmy 的 hduthesis 修改

参考仓库：https://github.com/cughmy/hduthesis

## 一、简介

为了方便学位论文的排版，让作者专心于内容，
根据[《杭州电子科技大学研究生学位论文格式统一要求（杭电研[2012]311号）》](http://grs.hdu.edu.cn/2013/0507/c1730a51754/page.htm)，并结合实际，改造设计了相应的LaTeX模版。

建议有Latex基础的同学使用，避免不必要的麻烦。

## 二、可选参数

1.   `oneside`/`twoside`：选择单面打印还是双面打印
2.   `blindreview`：盲审时填入该参数，用于屏蔽个人信息。在论文中提到个人信息时使用 `\bmask{}` 包裹。 
3.   `nocpsupervisor`：无合作导师时填入该参数，用于屏蔽合作导师的部分。
4.   `eng` ：论文使用英文写作时填入该参数。该参数会调整部分文章样式，并设置 `\langext` 为 `eng`（默认情况下为 `chi`）

## 三、编译方法

1.   Typeset Engine: XeTex

2.   推荐的编辑器

     1.   macOS 推荐使用 [Texifier](https://www.texifier.com)

     2.   其它系统推荐使用 [Overleaf](https://www.overleaf.com/)

## 四、相关资源文件说明

```tex
├── contents  % 被引用的内容 不可嵌套引用
│   ├── Abstract.chi.tex 	% 中文摘要
│   ├── Abstract.eng.tex	% 英文摘要
│   ├── xxx.chi.tex			% 中文论文引用 chi 后缀的文件
│   ├── xxx.eng.tex			% 英文论文引用 eng 后缀的文件
│   ├── Appendix.chi.tex
│   ├── Appendix.eng.tex	% 附录部分，使用 \appendixsec{} 创建标题
│   └── Aknowledge.tex		% 致谢部分
├── hduthesis.tex % 论文主源码（通过 include 以上文件来组成论文内容）
├── figures  % 引用图片目录
│   ├── ...
│   ├── ...
│   └── ...
├── gbt7714-2005.bst   % 参考文献样式（南京大学胡海星）
├── logo
│   ├── HDUlogo_BW.pdf
│   └── HDUlogo.pdf
├── references % 论文引文数据库 自行维护
│   └── references.bib
├── hduthesis.cls       % 论文全书样式 小心查看和修改 避免手残
└── ...
```

通过 `latexmk main` 将论文编译出来后，请检视内容尝试理解本论文模板。

## 5、许可权和贡献

**MIT** 

欢迎 issue 和 PR，方便大家一起探讨
