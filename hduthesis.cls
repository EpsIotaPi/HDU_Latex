% !Mode:: "TeX:UTF-8"
% !TEX root = main.tex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hduthesis}[2015/08/23 hduthesis document class.
Created: 2014.09.15 by Sky and Hamburger,  Modified by Kwen String at 2016.04.08, Introduced to HDU and then modified by Mingying Huang in 07.07.2018]

%---------- Option ----------
% 可选参数，用于区别格式
\newif\if@cpsupervisor\@cpsupervisortrue
\newif\if@englishversion\@englishversionfalse
\newif\if@listoftabfig\@listoftabfigfalse
\newif\if@blindreview\@blindreviewfalse

%\DeclareOption{master}{\@doctorfalse}
\DeclareOption{nocpsupervisor}{\@cpsupervisorfalse}
\DeclareOption{eng}{\@englishversiontrue}
\DeclareOption{listoftabfig}{\@listoftabfigtrue}
\DeclareOption{blindreview}{\@blindreviewtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\LoadClass[cs4size,fancyhdr,fntef,openright,cap]{ctexbook}


\newcommand{\langext}{}
\if@englishversion
	\renewcommand{\langext}{eng}
\else
	\renewcommand{\langext}{chi}
\fi

\RequirePackage{setspace}
\newcommand{\titlepagelinespacing}{1.0} %中英文扉页行距设置，默认为1.0

% 用于防止孤行
\widowpenalty=10000   % 尾行分页惩罚值
\clubpenalty=10000    % 首行分页惩罚值

%---------- 加载宏包 ----------
% 数学公式
\RequirePackage{amsmath, amssymb}
% 公式中的粗体
\RequirePackage{bm}
% 公式中的括号，例如subnumcases环境
\RequirePackage{cases}
%  pifont 宏包提供带圈的数字符号，这里用作脚注的标号，根据GB/T 7713.1-2006要求。
\RequirePackage{pifont}
% 插图
\RequirePackage{graphicx}
% svg 宏包默认使用了subfig与本模板引用的subcaption冲突，修改之
% 一直搞不好 越扯越麻烦 Give Up
% \RequirePackage[clean, pdf]{svg}

% 插图路径设置，图片放在figures 文件夹下。
% 一般来说论文的插图比较多时通常按章节存放，
% 此处全文引用图片皆从./figures目录搜索
\graphicspath{{./figures/}}
% \setsvg{svgpath=./figures/}

\RequirePackage[section]{placeins} % 确保图片排版不越过一节
% 设置图片，表格头字体选项
\RequirePackage{caption}
% 并排图形。subfigure、subfig 已经不再推荐，并与新的 subcaption不兼容！！！
\RequirePackage{subcaption}
%\RequirePackage{subfigure}
% 三线表
\RequirePackage{booktabs}
% 长表格宏包，tabu宏包longtabu环境需要。
\RequirePackage{longtable}
% 制表宏包，推荐使用，不使用其他制表宏包。
\RequirePackage{tabu}
% 下划线
\RequirePackage{ulem}
% 表格处理必备宏包
\RequirePackage{array}
% hyperref 宏包可根据交叉引用生成超链接，同时生成 PDF 文档的书签。
\RequirePackage{hyperref}

%\RequirePackage{prettyref}
%\AtBeginDocument{
%	\let\oldref\ref%
%	\renewcommand*{\ref}[1]{\prettyref{#1}}
%	\newrefformat{eq}{（\oldref{#1}）}
%}
	



\RequirePackage{notoccite} % 解决在图片中插入交叉应用，并使用图目录时导致的顺序错乱问题

% 代码排印
\RequirePackage{listings}
\lstset{
	basicstyle=\ttfamily\footnotesize, % 等宽字体
	breaklines=true,
	framextopmargin=30pt,
	framexleftmargin=37pt,
	framexrightmargin=5pt,
	framexbottommargin=5pt,
	%frame=bottomline, % 显示下框线
    columns=fixed,
    stringstyle=\rmfamily\slshape\color[RGB]{128,0,0},   % 设置字符串格式
    showstringspaces=false,                              % 不显示字符串中的空格
	showspaces=false,
	showtabs=false
}

\RequirePackage[algoruled, algosection]{algorithm2e}

\renewcommand{\lstlistingname}{代码}
\renewcommand\figureautorefname{图}
\renewcommand\tableautorefname{表}
\SetAlgorithmName{算法}{算法}

\RequirePackage{pgfplots}
\RequirePackage{pgfplotstable}
\pgfplotsset{compat=newest}
\RequirePackage{tikz}
\usetikzlibrary{chains,scopes,decorations.markings,intersections,patterns,shapes.geometric,shapes.symbols,through,positioning,calc,calendar,arrows,fit,backgrounds,matrix,pgfplots.groupplots,pgfplots.units,spy,pgfplots.colormaps}


% 树状图
\usetikzlibrary{trees}
\newcount\dirtree@lvl
\newcount\dirtree@plvl
\newcount\dirtree@clvl
\def\dirtree@growth{%
  \ifnum\tikznumberofcurrentchild=1\relax
  \global\advance\dirtree@plvl by 1
  \expandafter\xdef\csname dirtree@p@\the\dirtree@plvl\endcsname{\the\dirtree@lvl}
  \fi
  \global\advance\dirtree@lvl by 1\relax
  \dirtree@clvl=\dirtree@lvl
  \advance\dirtree@clvl by -\csname dirtree@p@\the\dirtree@plvl\endcsname
  \pgf@xa=1cm\relax
  \pgf@ya=-1cm\relax
  \pgf@ya=\dirtree@clvl\pgf@ya
  \pgftransformshift{\pgfqpoint{\the\pgf@xa}{\the\pgf@ya}}%
  \ifnum\tikznumberofcurrentchild=\tikznumberofchildren
  \global\advance\dirtree@plvl by -1
  \fi
}

\tikzset{
  dirtree/.style={
    growth function=\dirtree@growth,
    every node/.style={anchor=north},
    every child node/.style={anchor=west},
    edge from parent path={(\tikzparentnode\tikzparentanchor) |- (\tikzchildnode\tikzchildanchor)}
  }
}

\AtEndOfClass{
	\hypersetup{
		unicode,
		% hyperfootnotes=false,
	    pdfstartview=FitH,
	    CJKbookmarks=true,
	    bookmarksnumbered=true,
	    bookmarksopen=true,
	    % colorlinks=true,		% 链接颜色默认关闭，hidelink打开。
	    % citecolor=blue,
	    % linkcolor=blue,
	    % anchorcolor=blue,
	    % urlcolor=blue,
		hidelinks,			% 隐藏超链接的颜色和边框。
		% draft,				% 草稿模式，提高编译速度，需要时注释掉就可以了。
	}
}
\AtBeginDocument{
	\hypersetup{%
		pdftitle={\HDU@title},%
		pdfauthor={\HDU@author},%
		pdfkeywords={},%
		pdfcreator={XeLaTeX, using HDUAwesome Project}
	}
}
\urlstyle{same}
% 参考文献正文上标样式设置
\RequirePackage[sort&compress,numbers]{natbib}
% hypernat 可以让hyperref 和natbib 混合使用，但它需要放在这两者之后。
\RequirePackage{hypernat}
% 修复图表超链接不准的问题
\RequirePackage[all]{hypcap}
% footmisc 宏包提供了对脚注样式的控制功能。
% stable参数主要使脚注\footnote可以用在章节命令中；
% perpage
\RequirePackage[stable,perpage,symbol*]{footmisc}

%---------- 全局命令定义 ----------
% 修改原来CTEX@spaceChar为HDU@spcaeChar，ctex2.0宏包已经没有CTEX@spaceChar命令。
\@namedef{HDU@spaceChar}{\hspace{1em}}
% 用以产生2个字符空格。
\newcommand\HDUspace{\protect\HDU@spaceChar\protect\HDU@spaceChar}

% 封面
\renewcommand*\title[1]{\gdef\HDU@title{#1}}				       % 论文中文标题
\newcommand*\englishtitle[1]{\long\gdef\HDU@englishtitle{#1}}	       % 论文英文标题
\newcommand*\blindreviewhead[1]{\gdef\HDU@blindreviewhead{#1}}	% 论文英文标题 全日制专业型研究生，全日制学术型研究生，...

\renewcommand*\author[1]{\gdef\HDU@author{#1}}			       % 作者姓名
\newcommand*\englishauthor[1]{\long\gdef\HDU@englishauthor{#1}}	% 作者英文名
\newcommand*\classification[1]{\gdef\HDU@classification{#1}}	       % 分类号
\newcommand*\serialnumber[1]{\gdef\HDU@serialnumber{#1}}		% 单位代码
\newcommand*\secretlevel[1]{\gdef\HDU@secretlevel{#1}}			% 密级
\newcommand*\studentnumber[1]{\gdef\HDU@studentnumber{#1}}		% 学号
\newcommand*\supervisor[1]{\gdef\HDU@supervisor{#1}}			% 指导教师
\newcommand*\englishsupervisor[1]{\gdef\HDU@englishsupervisor{#1}}	% 指导教师英文名
\newcommand*\spvtitle[1]{\gdef\HDU@spvtitle{#1}}			    		% 指导教师职称 
\newcommand*\englishspvtitle[1]{\gdef\HDU@englishspvtitle{#1}}	       % 指导教师英文职称 
\newcommand*\cpsupervisor[1]{\gdef\HDU@cpsupervisor{#1}}		% 合作导师
\newcommand*\cspvtitle[1]{\gdef\HDU@cspvtitle{#1}}		        	% 合作导师职称
\newcommand*\englishcpsupervisor[1]{\gdef\HDU@englishcpsupervisor{#1}}	% 合作导师英文名
\newcommand*\englishcpvtitle[1]{\gdef\HDU@englishcpvtitle{#1}}	% 合作导师英文职称
\newcommand*\major[1]{\gdef\HDU@major{#1}}				 	% 专业名称
\newcommand*\research[1]{\gdef\HDU@research{#1}}				% 研究方向
\newcommand*\institute[1]{\gdef\HDU@institute{#1}}				% 所在学院
\newcommand*\submitdate[1]{\gdef\HDU@submitdate{#1}}			% 提交日期
  
% 中文题名页
\newcommand*\reviewerA[1]{\gdef\HDU@reviewerA{#1}}				% 论文评阅人1
\newcommand*\reviewerB[1]{\gdef\HDU@reviewerB{#1}}				% 论文评阅人2
\newcommand*\reviewerC[1]{\gdef\HDU@reviewerC{#1}}			% 论文评阅人3
\newcommand*\reviewerD[1]{\gdef\HDU@reviewerD{#1}}				% 论文评阅人4
\newcommand*\reviewerE[1]{\gdef\HDU@reviewerE{#1}}				% 论文评阅人5
\newcommand*\chairperson[1]{\gdef\HDU@chairperson{#1}}			% 答辩委员会主席
\newcommand*\commissionerA[1]{\gdef\HDU@commissionerA{#1}}		% 委员1
\newcommand*\commissionerB[1]{\gdef\HDU@commissionerB{#1}}		% 委员2
\newcommand*\commissionerC[1]{\gdef\HDU@commissionerC{#1}}		% 委员3
\newcommand*\commissionerD[1]{\gdef\HDU@commissionerD{#1}}		% 委员4
\newcommand*\commissionerE[1]{\gdef\HDU@commissionerE{#1}}		% 委员5
\newcommand*\defencedate[1]{\gdef\HDU@defencedate{#1}}			% 答辩日期

% 英文题名页
\newcommand*\enreviewerA[1]{\gdef\HDU@enreviewerA{#1}}			% 评阅人1英文名
\newcommand*\enreviewerB[1]{\gdef\HDU@enreviewerB{#1}}			% 评阅人2英文名
\newcommand*\enreviewerC[1]{\gdef\HDU@enreviewerC{#1}}			% 评阅人3英文名
\newcommand*\enreviewerD[1]{\gdef\HDU@enreviewerD{#1}}			% 评阅人4英文名
\newcommand*\enreviewerE[1]{\gdef\HDU@enreviewerE{#1}}			% 评阅人5英文名
\newcommand*\enchairperson[1]{\gdef\HDU@enchairperson{#1}}		% 委员会主席英文名
\newcommand*\encommissionerA[1]{\gdef\HDU@encommissionerA{#1}}	% 委员1英文名
\newcommand*\encommissionerB[1]{\gdef\HDU@encommissionerB{#1}}	% 委员2英文名
\newcommand*\encommissionerC[1]{\gdef\HDU@encommissionerC{#1}}	% 委员3英文名
\newcommand*\encommissionerD[1]{\gdef\HDU@encommissionerD{#1}}	% 委员4英文名
\newcommand*\encommissionerE[1]{\gdef\HDU@encommissionerE{#1}}	% 委员5英文名
\newcommand*\eendefencedate[1]{\gdef\HDU@eendefencedate{#1}}	% 答辩日期英文版


% 正文部分文字的行距设置
\renewcommand\baselinestretch{1.54}

%---------- 版面设置 ----------
% 纸张大小按照A4paper
\RequirePackage[paper=a4paper]{geometry}
%\setlength\paperheight{297mm}
%\setlength\paperwidth {210mm}	%  \paperwidth = h + \oddsidemargin+\textwidth+\evensidemargin + h
% 版心尺寸
\setlength\voffset{20\p@}
%\setlength\hoffset{10\p@}
\setlength\headheight{12\p@}	% 页眉高度
\setlength\headsep{14\p@}		% 页眉与正文间距
\setlength\topskip{20\p@}		% 每页第一行的行间距
\setlength\footskip{30\p@}		% 页脚基线与每一页最后一行文本基线的距离
\setlength\maxdepth{.2\topskip}	% \maxdepth + \topskip = typesize × 1.5
% 软件学院要求版心左、右外边距3.2cm （無理無茶! 简直丑爆了！不能忍）
% 此处缩小了版心外边距到处女座可以接受的值 左边距25mm 右边距23mm 2mm差值消除胶装影响
\setlength\textwidth{16.2cm}	% book.cls文档对texthight和textwidth的
\setlength\textheight{23.7cm}	% 定义比较复杂，但是比较合理
\setlength\marginparsep{10\p@}	% 边注与正文区域的间距
%\setlength\marginparpush{7\p@}	% 两个边注之间的距离，感觉设不设置无所谓
% 单双页面边栏设置
\if@twoside
	\setlength\oddsidemargin{2.6cm}
	\addtolength\oddsidemargin {-1in}
	\setlength\evensidemargin{2cm}
	\addtolength\evensidemargin {-1in}
	\setlength\marginparwidth{45\p@}
\else
	\setlength\oddsidemargin{2.5cm}		% 根据要求，默认单面打印左边距为2.5cm。
	\addtolength\oddsidemargin {-1in}	% 发现latex2e默认在页面四周各留出1in的空白，所以要减去这1in。
	\setlength\evensidemargin{2.0cm}	
	\addtolength\evensidemargin {-1in}	% oneside下奇偶页侧边空白相同。
	\setlength\marginparwidth{50\p@}
\fi
% 设置topmargin的尺寸
\setlength\topmargin{\paperheight}
\addtolength\topmargin{-2in}
\addtolength\topmargin{-\headheight}
\addtolength\topmargin{-\headsep}
\addtolength\topmargin{-\textheight}
\addtolength\topmargin{-\footskip}
\addtolength\topmargin{-.5\topmargin}

% 双面打印时空白页中间显示文本
\newcommand*{\HDU@blankpage}{%
	\par\vspace*{\fill}%
	\centerline{This page is intentionally left blank.}\par
	\vspace{\fill}}
% 重新定义cleardouble，其原始定义在
\def\cleardoublepage{%
	\clearpage
	\if@twoside
	    \ifodd
			\c@page
		\else
		% 下面这个命令，如果不需要强调这是空白页，或者学校不允许，则可将其注释掉。
			\HDU@blankpage
			\thispagestyle{HDU@empty}%
			\hbox{}\newpage
			\if@twocolumn
				\hbox{}\newpage
			\fi
		\fi
	\fi
}

%---------- 页眉页脚 ----------
% 采用latex2e的底层代码，不用fancyhdr宏包。
% 页眉标记
\if@blindreview
    \def\HDU@D@M@thesis{浙江省硕士学位论文}
\else
    \def\HDU@D@M@thesis{杭州电子科技大学硕士学位论文}
\fi


% 空白页：没有页眉页脚和页码
\def\ps@HDU@empty{%
	\let\@oddhead\@empty%
	\let\@evenhead\@empty%
	\let\@oddfoot\@empty%
	\let\@evenfoot\@empty}

% plain样式：只有页脚居中页码
\def\ps@HDU@plain{%
	\let\@oddhead\@empty%
	\let\@evenhead\@empty%
	\def\@oddfoot{\hfil\zihao{-5}\thepage\hfil}%
	\let\@evenfoot=\@oddfoot}

% 文章主样式：分单双面打印样式
\if@twoside
	\def\ps@HDU@headings{%
		\def\@oddhead{\vbox to\headheight{%
			\hb@xt@\textwidth{\zihao{-5}\songti\HDU@D@M@thesis\hfill\leftmark}%
			\vskip2pt\hbox{\vrule width\textwidth height0.4pt depth0pt}}}
		\def\@evenhead{\vbox to\headheight{.  
			\hb@xt@\textwidth{\zihao{-5}\songti\leftmark\hfill\HDU@D@M@thesis} %  
			\vskip2pt\hbox{\vrule width\textwidth height0.4pt depth0pt}}}
		\def\@oddfoot{\hfil\zihao{-5}\thepage\hfil}
		\let\@evenfoot=\@oddfoot
		\let\@mkboth\markboth}
\else
%%页眉为: 宋体五号字，居中，距边界2厘米；
	\def\ps@HDU@headings{%
		\def\@oddhead{\vbox to\headheight{  %%\def\HDU@D@M@thesis{杭州电子科技大学硕士学位论文}
			\hb@xt@\textwidth{\zihao{5}\songti\centerline{\HDU@D@M@thesis}\hfill}%将\leftmark放到大括号内即可
			\vskip2pt\hbox{\vrule width\textwidth height0.4pt depth0pt}}}
		\let\@evenhead=\@oddhead
		\def\@oddfoot{\hfil\zihao{-5}\thepage\hfil}
		\let\@evenfoot=\@oddfoot
		\let\@mkboth\markboth}
\fi
%如果页眉中需要标明每章的标题，可以使用下列命令定义\leftmark 然后将\leftmark放到310行\hfiil后即可
%重新定义\chaptermark，使其为\leftmark引用。
\renewcommand\chaptermark[1]{%
\markboth{\MakeUppercase{%
\ifnum \c@secnumdepth >\m@ne
	\if@mainmatter
		\@chapapp  \hskip1em%
	\fi
\fi
#1}}{}}

%---------- 本机字体设置 ----------
\RequirePackage{fontspec}
%\setmainfont{TeX Gyre Termes}	%相当于MS Word中的Times new Roman。
%\setsansfont{TeX Gyre Heros}	%相当于MS Word中的Helvetica。
%\setmonofont{TeX Gyre Cursor}	%相当于MS Word中的Curier。
\setmainfont{Times New Roman}[
%  UprightFont = *-regular,
%  BoldFont = *-bold,
%  ItalicFont = *-italic,
%  BoldItalicFont = *-bolditalic,
%  Extension = .otf,
  Scale = 1.0]
\setsansfont{texgyreheros}[
  UprightFont = *-regular,
  BoldFont = *-bold,
  ItalicFont = *-italic,
  BoldItalicFont = *-bolditalic,
  Extension = .otf,
  Scale = 1.0]
\setmonofont{texgyrecursor}[
  UprightFont = *-regular,
  BoldFont = *-bold,
  ItalicFont = *-italic,
  BoldItalicFont = *-bolditalic,
  Extension = .otf,
  Scale = 1.0]
  
\RequirePackage{xeCJK}

% xeCJK 环境初始化
\xeCJKsetup{xeCJKactive=true}

% 打开/关闭CJK文字之间的空格，tex 源码中汉字间的换行符和空格都会被编译成空格 
% 作者编写论文 tex 源码时一般写到一个逗号就换行再写 这样能最大限度的保证清晰
% 如不符合您的需求请自行解注释
%\xeCJKsetup{CJKspace=true}

\xeCJKsetup{CheckSingle=true} % 避免单个CJK字符独占一行

% 非简体中文常用字处理(生僻字、繁体字、日本汉字)
% 发现实际排版时此类字框会相对于行内上移一个微小的单位
% 故当封面作者名称含此类字时，只能预留相应的字框宽度，待后期补上
%\xeCJKDeclareCharClass{Ext-B}{ "20000 -> "2A6DF } % 看XeLaTeX文档写的 没软用
%\xeCJKsetup{AutoFallBack=true} % 如果不加这句 非简体中文汉字在章节标题和论文标题上显示异常

% 标点处理格式 行末半角 所有标点占一个汉字宽度 行首行末对齐
\xeCJKEditPunctStyle{hangmobanjiao}{enabled-global-setting = false}

% 设置中文正文字体为仿宋，加粗为黑体，斜体为楷体
% 除非您使用windows操作系统编译论文，否则强烈不推荐使用微软系的字体
\setCJKmainfont[BoldFont={Adobe Heiti Std}, ItalicFont={Adobe Kaiti Std}]{SimSun}
%\setCJKfallbackfamilyfont{\CJKrmdefault}[BoldFont={Adobe Heiti Std}, ItalicFont={Adobe Kaiti Std}]{Adobe Fangsong Std}
% 由于汉字都是等宽的，等宽字体通常应用在代码段或verbatim环境中，故这里选用黑体后更改。
%\setCJKmonofont{Noto Sans CJK SC} % 十分优雅美观的思源黑体
\setCJKmonofont{Adobe Heiti Std}

\setCJKfamilyfont{songti}{SimSun}[AutoFakeBold=1.5, AutoFakeSlant=0.25]
\providecommand{\songti}{\CJKfamily{songti}}
%\setCJKfamilyfont{fangsong}{Adobe-Fangsong-Std.otf}[Path=template/fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
%\providecommand{\fangsong}{\CJKfamily{fangsong}}
%\setCJKfamilyfont{heiti}{Adobe-Heiti-Std.otf}[Path=template/fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
%\providecommand{\heiti}{\CJKfamily{heiti}}
%\setCJKfamilyfont{kaishu}{Adobe-Kaiti-Std.otf}[Path=template/fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
%\providecommand{\kaishu}{\CJKfamily{kaishu}}

%---------% 封面及中英标题页 ----------
% 定义封面及标题页设置中常用的下划线命令（默认宽度90pt）
\renewcommand\ULthickness{0.8pt}			% 重新定义下划线的厚度
\newcommand\HDUunderline[2][90pt]{\uline{\hbox to #1{\hss#2\hss}}\hskip3pt}
% 重新定义\maketitle命令
\renewcommand\maketitle{
    \if@blindreview
        \makeanonymouscover
	\else
		% \@mainmatterfalse
		\HDUmakecover
		\HDUmakeCNtitlepage % 中文扉页
		\if@englishversion
			\HDUmakeJPENtitlepage % 中日合作定制版英文扉页
		\else
			\HDUmakeENtitlepage % 英文扉页
		\fi
		\makeOSpage % 原创性声明
		
%		\HDUAbsturctmakecover  % 详细摘要封面
	\fi
}

% 盲审封面
\newcommand\makeanonymouscover{
    \cleardoublepage
    \pdfbookmark[0]{盲审封面}{anchor_os}
	\thispagestyle{empty}

	%\RequirePackage[paper=a4paper]{geometry}
    \newgeometry{left=2.7cm, right=2.7cm, top=2.5cm, bottom=2.5cm}

    \noindent{\bfseries\zihao{5}\songti{\text{\ding{72}}\HDU@blindreviewhead}}
    
    \vspace{2cm}
    
    \noindent{\fontsize{30pt}{0pt}\selectfont\bfseries\songti{浙\,\,\,江\,\,\,省\,\,\,硕\,\,\,士\,\,\,学\,\,\,位\,\,\,论\,\,\,文}}
    \vspace{4cm}
    
    \begin{flushright}
    % 宋体 小二
        {\zihao{-2}\bfseries\songti{论文题目：}} \zihao{-2}\parbox[t]{18em}{\zihao{-2}\songti{\HDU@title\hfill}} \\[1em]

        {\zihao{-2}\bfseries\songti{专业名称：}} \zihao{-2}\parbox[t]{18em}{\zihao{-2}\songti{\HDU@major\hfill}}  \\[1em]

        {\zihao{-2}\bfseries\songti{研究方向：}} \zihao{-2}\parbox[t]{18em}{\zihao{-2}\songti{\HDU@research\hfill}}
        
%        {\zihao{-2}\bfseries\songti{论文题目：}} \zihao{-2}\parbox[t]{18em}{\zihao{-2}\songti\uline{\HDU@title\hfill}} \\[1em]
%
%        {\zihao{-2}\bfseries\songti{专业名称：}} \zihao{-2}\parbox[t]{18em}{\zihao{-2}\songti\uline{\HDU@major\hfill}}  \\[1em]
%
%        {\zihao{-2}\bfseries\songti{研究方向：}} \zihao{-2}\parbox[t]{18em}{\zihao{-2}\songti\uline{\HDU@research\hfill}}
    \end{flushright}
    \restoregeometry
}

% 封面
\newcommand\HDUmakecover{
	\cleardoublepage
	\pdfbookmark[0]{封面}{anchor_cover}
	\thispagestyle{HDU@empty}
	%分类号：\HDUunderline[90pt]{\HDU@classification}
	%\hfill
	%单位代码：\HDUunderline[60pt]{\HDU@serialnumber} \par
	%密\quad 级：\HDUunderline[90pt]{\HDU@secretlevel}
	%\hfill
	%学\HDUspace 号：\HDUunderline[60pt]{\HDU@studentnumber} \par
	%\vspace{9mm}
	\begin{center}
		\includegraphics[width=160mm]{./logo/HDUlogo.pdf}\par
		\vspace{10mm}
		{
		    {\kaishu \zihao{-1}硕\hspace{1em}士\hspace{1em}学\hspace{1em}位\hspace{1em}论\hspace{1em}文}
		}\par
		\vspace{36mm}
		%\includegraphics[width=22.8mm]{./logo/QSY.pdf}
	\end{center}
	\vspace{6mm}
	% 新建一个长度寄存器，存放封面标题下划线宽度值
	\newlength{\titleulwidth@cover}
	\addtolength{\titleulwidth@cover}{260pt}
	\begin{center}
		\begin{tabular}[t]{>{\zihao{-2}\kaishu\mdseries}rl}
		     题\,\,\,目: &
			{\begin{minipage}[t][60pt][t]{\titleulwidth@cover}
				\zihao{-2} \kaishu%\bfseries
				\uline{\HDU@title\hfill}
			\end{minipage}} \\%[20pt]
			
			\iffalse %自己修改的 修改日期：2018.07.05
			\rule{0pt}{10mm}
			
			英文论文题目: &
			{\begin{minipage}[t][60pt][t]{\titleulwidth@cover}
				\newlength{\etitlelength}
				\fontsize{16}{23}\bfseries
				\settowidth{\etitlelength}{\HDU@englishtitle}
% 使封面英文标题下划线数量能够适应因英文标题内容长短变化而引起的英文标题行数变化
% 而引起的下划线行数变化，下划线行数就是英文标题行数。目前最大的支持行数为3行，
% 不过行数可以根据需要扩展，只要符合页面格式的美观即可。不过论文编写规则中提到：
% 英文标题翻译应简短准确，一般不应超过150个字母，学校规定不可以加副标题。
				\HDU@englishtitle\\*
				\ifdim\etitlelength<\titleulwidth@cover
					\raisebox{31pt}[0pt][0pt]{\parbox[t][][t]{\titleulwidth@cover}{
					\rule{\titleulwidth@cover}{\ULthickness}}}
				\else\ifdim\etitlelength<2\titleulwidth@cover
						\raisebox{67pt}[0pt][0pt]{\parbox[t][][t]{\titleulwidth@cover}{
						\rule{\titleulwidth@cover}{\ULthickness}\\*
						\rule{\titleulwidth@cover}{\ULthickness}}}
				\else\ifdim\etitlelength<3\titleulwidth@cover
						\raisebox{103pt}[0pt][0pt]{\parbox[t][][t]{\titleulwidth@cover}{
						\rule{\titleulwidth@cover}{\ULthickness}\\*
						\rule{\titleulwidth@cover}{\ULthickness}\\*
						\rule{\titleulwidth@cover}{\ULthickness}}}
				\fi\fi\fi
			\end{minipage}}\\*
			
			\fi %修改日期：2018.07.05
			
		\end{tabular}

		\vskip 9mm
		\begin{tabular}{>{\zihao{3}\kaishu}l>{\zihao{3}\kaishu}l}
			%申请人姓名: & \HDUunderline[200pt]{\HDU@author} \\[3mm]
			% 由于本模板无法整齐排印生僻字（原因不明）
			% 名字中有生僻字情况的 可以预留一个em框长度
            % 后期可以将字以文本框的形式贴上(OS X 下直接在Preview里就可以加入文本框)
            % 如果打印店的机器未安装Adobe Fangsong字体，这个文本框不会被实际打印出来
			研\,\,\,究\,\,\,生 & \HDUunderline[200pt]{\HDU@author \hspace{1em}} \\[3mm]
			%指导教师: & \HDUunderline[200pt]{\HDU@supervisor} \\[3mm]
			专\,\,\,\,\,\,\,\,\,\,\,\,业  & \HDUunderline[200pt]{\HDU@major \hspace{1em}} \\[3mm]
			指导教师  & \HDUunderline[200pt]{\HDU@supervisor \hspace{1em} \HDU@spvtitle} \\[3mm]
			\if@cpsupervisor
			合作导师  & \HDUunderline[200pt]{\HDU@cpsupervisor \hspace{1em} \HDU@spvtitle} \\[3mm]
			\fi
			%专业名称: & \HDUunderline[200pt]{\HDU@major} \\[3mm]
			%专业学位类别: & \HDUunderline[200pt]{\HDU@major} \\[3mm]
			%研究方向: & \HDUunderline[200pt]{\HDU@research} \\[3mm]
			%专业学位领域: & \HDUunderline[200pt]{\HDU@research} \\[3mm]
			%所在学院: & \HDUunderline[200pt]{\HDU@institute}
		\end{tabular}
	\end{center}
	\vskip 20mm
	\begin{center}
		{\zihao{4}\kaishu 完成日期 \hspace{1em} \HDUunderline[150pt]{%
		\HDU@submitdate}}
	\end{center}
	%清空变量节省空间
	\global\let\HDU@classification\@empty
	\global\let\HDU@serialnumber\@empty
	\global\let\HDU@secretlevel\@empty
	\global\let\HDU@studentnumber\@empty
	%\global\let\HDU@author\@empty
	%\global\let\HDU@supervisor\@empty
	%\global\let\HDU@cpsupervisor\@empty
	\global\let\HDU@major\@empty
	\global\let\HDU@research\@empty
	\global\let\HDU@institute\@empty
	\global\let\HDU@submitdate\@empty
	\global\let\classification\relax
	\global\let\serialnumber\relax
	\global\let\secretlevel\relax
	\global\let\studentnumber\relax
	\global\let\author\relax
	\global\let\supervisor\relax
	\global\let\cpsupervisor\relax
	\global\let\major\relax
	\global\let\research\relax
	\global\let\institute\relax
	\global\let\submitdate\relax
}

% 详细摘要封面
\newcommand\HDUAbsturctmakecover{
	\cleardoublepage
	\pdfbookmark[0]{封面}{anchor_cover}
	\thispagestyle{HDU@empty}
	%分类号：\HDUunderline[90pt]{\HDU@classification}
	%\hfill
	%单位代码：\HDUunderline[60pt]{\HDU@serialnumber} \par
	%密\quad 级：\HDUunderline[90pt]{\HDU@secretlevel}
	%\hfill
	%学\HDUspace 号：\HDUunderline[60pt]{\HDU@studentnumber} \par
	%\vspace{9mm}
	\begin{center}
		\includegraphics[width=160mm]{./logo/HDUlogo_BW.pdf}\par
		\vspace{10mm}
		{
		    {\kaishu \zihao{-1}硕\hspace{1em}士\hspace{1em}学\hspace{1em}位\hspace{1em}论\hspace{1em}文}
		}\par
		\vspace{10mm}
		{
		   	{\kaishu \zihao{-1}详\hspace{1em}细\hspace{1em}摘\hspace{1em}要}
		}\par
		\vspace{26mm}
		%\includegraphics[width=22.8mm]{./logo/QSY.pdf}
	\end{center}
	\vspace{6mm}
	% 新建一个长度寄存器，存放封面标题下划线宽度值
	\newlength{\titleulwidth@cover}
	\addtolength{\titleulwidth@cover}{260pt}
	\begin{center}
		\begin{tabular}[t]{>{\zihao{-2}\kaishu\mdseries}rl}
		     题\,\,\,目: &
			{\begin{minipage}[t][60pt][t]{\titleulwidth@cover}
				\zihao{-2} \kaishu%\bfseries
				\uline{\HDU@title\hfill}
			\end{minipage}} \\%[20pt]
			
			\iffalse %自己修改的 修改日期：2018.07.05
			\rule{0pt}{10mm}
			
			英文论文题目: &
			{\begin{minipage}[t][60pt][t]{\titleulwidth@cover}
				\newlength{\etitlelength}
				\fontsize{16}{23}\bfseries
				\settowidth{\etitlelength}{\HDU@englishtitle}
% 使封面英文标题下划线数量能够适应因英文标题内容长短变化而引起的英文标题行数变化
% 而引起的下划线行数变化，下划线行数就是英文标题行数。目前最大的支持行数为3行，
% 不过行数可以根据需要扩展，只要符合页面格式的美观即可。不过论文编写规则中提到：
% 英文标题翻译应简短准确，一般不应超过150个字母，学校规定不可以加副标题。
				\HDU@englishtitle\\*
				\ifdim\etitlelength<\titleulwidth@cover
					\raisebox{31pt}[0pt][0pt]{\parbox[t][][t]{\titleulwidth@cover}{
					\rule{\titleulwidth@cover}{\ULthickness}}}
				\else\ifdim\etitlelength<2\titleulwidth@cover
						\raisebox{67pt}[0pt][0pt]{\parbox[t][][t]{\titleulwidth@cover}{
						\rule{\titleulwidth@cover}{\ULthickness}\\*
						\rule{\titleulwidth@cover}{\ULthickness}}}
				\else\ifdim\etitlelength<3\titleulwidth@cover
						\raisebox{103pt}[0pt][0pt]{\parbox[t][][t]{\titleulwidth@cover}{
						\rule{\titleulwidth@cover}{\ULthickness}\\*
						\rule{\titleulwidth@cover}{\ULthickness}\\*
						\rule{\titleulwidth@cover}{\ULthickness}}}
				\fi\fi\fi
			\end{minipage}}\\*
			
			\fi %修改日期：2018.07.05
			
		\end{tabular}

		\vskip 9mm
		\begin{tabular}{>{\zihao{3}\kaishu}l>{\zihao{3}\kaishu}l}
			%申请人姓名: & \HDUunderline[200pt]{\HDU@author} \\[3mm]
			% 由于本模板无法整齐排印生僻字（原因不明）
			% 名字中有生僻字情况的 可以预留一个em框长度
            % 后期可以将字以文本框的形式贴上(OS X 下直接在Preview里就可以加入文本框)
            % 如果打印店的机器未安装Adobe Fangsong字体，这个文本框不会被实际打印出来
			研\,\,\,究\,\,\,生 & \HDUunderline[200pt]{\HDU@author \hspace{1em}} \\[3mm]
			%指导教师: & \HDUunderline[200pt]{\HDU@supervisor} \\[3mm]
			专\,\,\,\,\,\,\,\,\,\,\,\,业  & \HDUunderline[200pt]{\HDU@major \hspace{1em}} \\[3mm]
			指导教师  & \HDUunderline[200pt]{\HDU@supervisor \hspace{1em} \HDU@spvtitle} \\[3mm]
			\if@cpsupervisor
			合作导师  & \HDUunderline[200pt]{\HDU@cpsupervisor \hspace{1em} \HDU@spvtitle} \\[3mm]
			\fi
			%专业名称: & \HDUunderline[200pt]{\HDU@major} \\[3mm]
			%专业学位类别: & \HDUunderline[200pt]{\HDU@major} \\[3mm]
			%研究方向: & \HDUunderline[200pt]{\HDU@research} \\[3mm]
			%专业学位领域: & \HDUunderline[200pt]{\HDU@research} \\[3mm]
			%所在学院: & \HDUunderline[200pt]{\HDU@institute}
		\end{tabular}
	\end{center}
	\vskip 20mm
	\begin{center}
		{\zihao{4}\kaishu 完成日期 \hspace{1em} \HDUunderline[150pt]{%
		\HDU@submitdate}}
	\end{center}
	%清空变量节省空间
	\global\let\HDU@classification\@empty
	\global\let\HDU@serialnumber\@empty
	\global\let\HDU@secretlevel\@empty
	\global\let\HDU@studentnumber\@empty
	%\global\let\HDU@author\@empty
	%\global\let\HDU@supervisor\@empty
	%\global\let\HDU@cpsupervisor\@empty
	\global\let\HDU@major\@empty
	\global\let\HDU@research\@empty
	\global\let\HDU@institute\@empty
	\global\let\HDU@submitdate\@empty
	\global\let\classification\relax
	\global\let\serialnumber\relax
	\global\let\secretlevel\relax
	\global\let\studentnumber\relax
	\global\let\author\relax
	\global\let\supervisor\relax
	\global\let\cpsupervisor\relax
	\global\let\major\relax
	\global\let\research\relax
	\global\let\institute\relax
	\global\let\submitdate\relax
}


% 中文题名页 中文扉页上论文题目为黑体小一号字，研究生姓名、指导教师姓名、职称为楷体三号字，完成日期为楷体四号字；
\newcommand\HDUmakeCNtitlepage{
	\cleardoublepage
	\pdfbookmark[0]{中文题名页}{anchor_cntitle}
	\thispagestyle{HDU@empty}
	{
	\linespread{1.3}
	\vspace*{2mm}
	
	%该项字体设置在《杭州电子科技大学研究生学位论文格式统一要求（杭电研[2012]311号）》没有明确规定 默认为楷体二号字
	\begin{center}
		{\zihao{2}\kaishu\bfseries 杭州电子科技大学硕士学位论文}
		
	\end{center}
	\vspace{60mm}
	
	\begin{spacing}{\titlepagelinespacing}
	\begin{center}
			{\zihao{-1}\heiti\HDU@title}
	\end{center}
	\end{spacing}
	\vspace{40mm}
	
	\begin{center}
		\begin{tabular}{>{\zihao{3}\kaishu}r>{\zihao{3}\kaishu}l}
			研\,\,\,究\,\,\,生： & {\HDU@author \hspace{1em}} \\[10mm]
			指导教师：  & {\HDU@supervisor \hspace{1em} \HDU@spvtitle} \\
		    合作导师：  & {\HDU@cpsupervisor \hspace{1em} \HDU@spvtitle} \\
		\end{tabular}
	\end{center}
	\vspace{40mm}
	
	\begin{center}
	%\hfill{\zihao{4}\songti 答辩日期: \HDUunderline[150pt]{\HDU@defencedate}}
	{\zihao{4}\kaishu 答辩日期: {\HDU@defencedate}}
       \end{center}
  
	
	\iffalse
	
	\begin{center}
		\newlength{\ctitlelength}
		\newlength{\bk@ctitlelength}
		\settowidth{\ctitlelength}{\zihao{-2}\HDU@title}
		\settowidth{\bk@ctitlelength}{\zihao{-2}\HDU@title}
		% 新建一个长度寄存器，存放中文题名页标题宽度值
		\newlength{\ctitle@width}
		\setlength{\ctitle@width}{300pt}
		% 因为根据规定，中文标题字符数不超过50个字，这里最多为28字，严格适配50字
		% 将
		\ifdim\ctitlelength>2\titleulwidth@cover
			\ClassError{hduthesis}{%
				Your Chinese title name is too long, please \MessageBreak
				make it a bit shorter. It must be less than \MessageBreak
				28 characters.
			}{%
				Oh dear! If your ctitle is still too long, \MessageBreak
				You must send me an email to report the need. \MessageBreak
				My email is niyayuan@outlook.com. o(∩_∩)o
			}
		\else\ifdim\ctitlelength<\ctitle@width
			\addtolength{\ctitlelength}{30pt}
			\begin{minipage}[b][50pt][b]{\ctitle@width}
				\centering
				\zihao{-2}\fangsong\bfseries
				\HDU@title\\*	% 这个就是中文标题，隐藏的很深。
				\raisebox{23pt}[0pt][0pt]{\parbox[t][][t]{\ctitle@width}{
				\centering
				\rule{\ctitlelength}{\ULthickness}}}
			\end{minipage}
			\else\ifdim\ctitlelength<2\ctitle@width
				\addtolength{\ctitlelength}{-\ctitle@width}
				% 这里尺寸是控制换行后第二行字数的，若小于4个，则不换行。
				\ifdim\ctitlelength<4em
					\addtolength{\bk@ctitlelength}{30pt}
					\begin{minipage}[b][50pt][b]{\bk@ctitlelength}
						\centering
						\zihao{1}\heiti\bfseries
						\HDU@title\\*	% 这个就是中文标题，隐藏的很深。
						\raisebox{23pt}[0pt][0pt]{\parbox[t][][t]{\bk@ctitlelength}{
						\centering
						\rule{\bk@ctitlelength}{\ULthickness}}}
					\end{minipage}
				\else
					\begin{minipage}[b][50pt][b]{\ctitle@width}
						\centering
						\zihao{-2}\fangsong\bfseries
						\HDU@title\\*	% 这个就是中文标题，隐藏的很深。
						\addtolength{\ctitlelength}{40pt}
						\raisebox{52pt}[0pt][0pt]{\parbox[t][][t]{\ctitle@width}{
						\centering
						\rule{\ctitle@width}{\ULthickness}\\*
						\rule{\ctitlelength}{\ULthickness}}}
					\end{minipage}
				\fi
		\fi\fi\fi
	\end{center}
	
	\fi
	%\begin{center}
		%\includegraphics[width=22.8mm]{./logo/QSY.pdf}
	%\end{center}
	
	\iffalse  % 修改日期：2018.07.05
	
	\vspace{4mm}
	\begin{center}
		{\zihao{3}\songti\bfseries 论文作者签名：\HDUunderline[120pt]{\hfill}}\\[8mm]
		{\zihao{3}\songti\bfseries 指导教师签名：\HDUunderline[120pt]{\hfill}}
	\end{center}
	\vspace{8mm}
	\begin{center}
		\begin{tabular}{>{\zihao{4}\songti}r>{\zihao{4}\songti}l}
			论文评阅人1: & \HDUunderline[260pt]{\HDU@reviewerA}\\[3mm]
			评阅人2: & \HDUunderline[260pt]{\HDU@reviewerB}\\[3mm]
			评阅人3: & \HDUunderline[260pt]{\HDU@reviewerC}\\[3mm]
			评阅人4: & \HDUunderline[260pt]{\HDU@reviewerD}\\[3mm]
			评阅人5: & \HDUunderline[260pt]{\HDU@reviewerE}\\[12mm]
			答辩委员会主席: & \HDUunderline[260pt]{\HDU@chairperson}\\[3mm]
			委员1: & \HDUunderline[260pt]{\HDU@commissionerA}\\[3mm]
			委员2: & \HDUunderline[260pt]{\HDU@commissionerB}\\[3mm]
			委员3: & \HDUunderline[260pt]{\HDU@commissionerC}\\[3mm]
			委员4: & \HDUunderline[260pt]{\HDU@commissionerD}\\[3mm]
			委员5: & \HDUunderline[260pt]{\HDU@commissionerE}
		\end{tabular}
	\end{center}
	\vspace{10mm}
	\begin{center}
	%\hfill{\zihao{4}\songti 答辩日期: \HDUunderline[150pt]{\HDU@defencedate}}
	{\zihao{4}\songti 答辩日期: \HDUunderline[150pt]{\HDU@defencedate}}
    \end{center}
	}
	%清空变量节省空间
	\global\let\HDU@reviewerA\@empty
	\global\let\HDU@reviewerB\@empty
	\global\let\HDU@reviewerC\@empty
	\global\let\HDU@reviewerD\@empty
	\global\let\HDU@reviewerE\@empty
	\global\let\HDU@chairperson\@empty
	\global\let\HDU@commissionerA\@empty
	\global\let\HDU@commissionerB\@empty
	\global\let\HDU@commissionerC\@empty
	\global\let\HDU@commissionerD\@empty
	\global\let\HDU@commissionerE\@empty
	\global\let\HDU@defencedate\@empty
	\global\let\HDU@title\@empty
	\global\let\title\relax
	\global\let\reviewerA\relax
	\global\let\reviewerB\relax
	\global\let\reviewerC\relax
	\global\let\reviewerD\relax
	\global\let\reviewerE\relax
	\global\let\chairperson\relax
	\global\let\commissionerA\relax
	\global\let\commissionerB\relax
	\global\let\commissionerC\relax
	\global\let\commissionerD\relax
	\global\let\commissionerE\relax
	\global\let\defencedate\relax
	
	\fi  %修改日期：2018.07.05
}

% 英文题名页
\newcommand\HDUmakeENtitlepage{
	\cleardoublepage
	\pdfbookmark[0]{英文题名页}{anchor_entitle}
	\thispagestyle{HDU@empty}
	{
	\linespread{1.3}
	%\vspace*{8mm}
	\vspace*{2mm}
	
	\begin{spacing}{\titlepagelinespacing}
	\begin{center}
		{\zihao{2}\bfseries Dissertation Submitted to Hangzhou Dianzi University for the Degree of Master}
	\end{center}
	\end{spacing}
	\vspace{50mm}
	
	\begin{spacing}{\titlepagelinespacing}
	\begin{center}
		{\zihao{-1}\bfseries \HDU@englishtitle}
	\end{center}
	\end{spacing}
	\vspace{40mm}
	
	\begin{center}
		\begin{tabular}{>{\zihao{3}\bfseries}r>{\zihao{3}\bfseries }l}
			Candidate: & {\HDU@englishauthor \hspace{1em}}\\[10mm]
			Supervisor: & {\HDU@englishspvtitle\,\,\,\HDU@englishsupervisor \hspace{1em}}\\
			Cooperate Supervisor: & {\HDU@englishcpvtitle\,\,\,\HDU@englishcpsupervisor \hspace{1em}}\\
			
		\end{tabular}
	\end{center}
	\vspace{40mm}
	
	\begin{center}
	%\hfill{\zihao{4}\songti 答辩日期: \HDUunderline[150pt]{\HDU@defencedate}}
	{\zihao{4}\bfseries{\HDU@eendefencedate}}
       \end{center}



	\iffalse % 自己修改的 修改日期：2018.07.05
	
	\begin{center}
		% 新建一个长度寄存器，存放英文题名页标题宽度值
		\newlength{\etitle@width}
		\addtolength{\etitle@width}{300pt}
		\begin{minipage}[b][50pt][b]{\etitle@width}
			\centering
			\fontsize{16}{23}\bfseries
			\settowidth{\etitlelength}{\HDU@englishtitle}
			\HDU@englishtitle\\*	% 这个就是英文标题，隐藏的也很深。
			\ifdim\etitlelength<\etitle@width
				\addtolength{\etitlelength}{30pt}
				\raisebox{25pt}[0pt][0pt]{\parbox[t][][t]{\etitle@width}{
				\centering
				\rule{\etitlelength}{\ULthickness}}}
			\else\ifdim\etitlelength<2\etitle@width
					\addtolength{\etitlelength}{-\etitle@width}
					\addtolength{\etitlelength}{40pt}
					\raisebox{55pt}[0pt][0pt]{\parbox[t][][t]{\etitle@width}{
					\centering
					\rule{\etitle@width}{\ULthickness}\\*
					\rule{\etitlelength}{\ULthickness}}}
			\else\ifdim\etitlelength<3\etitle@width
					\addtolength{\etitlelength}{-2\etitle@width}
					\addtolength{\etitlelength}{80pt}
					\raisebox{85pt}[0pt][0pt]{\parbox[t][][t]{\etitle@width}{
					\centering
					\rule{\etitle@width}{\ULthickness}\\*
					\rule{\etitle@width}{\ULthickness}\\*
					\rule{\etitlelength}{\ULthickness}}}
			\fi\fi\fi
		\end{minipage}
	\end{center}
	
	\fi % 自己修改的 修改日期：2018.07.05
	
	\iffalse
	
	\begin{center}
		\includegraphics[width=22.8mm]{./logo/QSY.pdf}
	\end{center}
	%\vspace{6mm}
	\vspace{5mm}
	\begin{center}
		\begin{tabular}{>{\zihao{3}\bfseries}rl}
			Author's signature: & \HDUunderline[120pt]{\hfill}\\[10mm]
			Supervisor's signature: & \HDUunderline[120pt]{\hfill}
		\end{tabular}
	\end{center}
	%\vspace{8mm}
	\vspace{7mm}
	\begin{center}
		\begin{tabular}{>{\zihao{4}}r>{\zihao{4}}l}
		%External Reviewers: & \HDUunderline[260pt]{\HDU@enreviewerA}\\[2mm]
		Thesis Reviewer 1: & \HDUunderline[240pt]{\HDU@enreviewerA}\\[2mm]
	    Thesis Reviewer 2: & \HDUunderline[240pt]{\HDU@enreviewerB}\\[2mm]
		Thesis Reviewer 3: & \HDUunderline[240pt]{\HDU@enreviewerC}\\[2mm]
	    Thesis Reviewer 4: & \HDUunderline[240pt]{\HDU@enreviewerD}\\[2mm]
		Thesis Reviewer 5: & \HDUunderline[240pt]{\HDU@enreviewerE}\\[10mm]
		Examining Committe Chair: & \HDUunderline[240pt]{\HDU@enchairperson}\\[2mm]
	    Committeeman 1: & \HDUunderline[240pt]{\HDU@encommissionerA}\\[2mm]
	    Committeeman 2: & \HDUunderline[240pt]{\HDU@encommissionerB}\\[2mm]
	    Committeeman 3: & \HDUunderline[240pt]{\HDU@encommissionerC}\\[2mm]
	    Committeeman 4: & \HDUunderline[240pt]{\HDU@encommissionerD}\\[2mm]
	    Committeeman 5: & \HDUunderline[240pt]{\HDU@encommissionerE}
		\end{tabular}
	\end{center}
	\vspace{12mm}
	\begin{center}
	{\zihao{4} Date of oral defence: \HDUunderline[150pt]{\HDU@eendefencedate}}
    \end{center}
  }
		%清空变量节省空间
	\global\let\HDU@enreviewerA\@empty
	\global\let\HDU@enreviewerB\@empty
	\global\let\HDU@enreviewerC\@empty
	\global\let\HDU@enreviewerD\@empty
	\global\let\HDU@enreviewerE\@empty
	\global\let\HDU@enchairperson\@empty
	\global\let\HDU@encommissionerA\@empty
	\global\let\HDU@encommissionerB\@empty
	\global\let\HDU@encommissionerC\@empty
	\global\let\HDU@encommissionerD\@empty
	\global\let\HDU@encommissionerE\@empty
	\global\let\HDU@eendefencedate\@empty
	\global\let\HDU@englishtitle\@empty			
	\global\let\englishtitle\relax
	\global\let\enreviewerA\relax
	\global\let\enreviewerB\relax
	\global\let\enreviewerC\relax
	\global\let\enreviewerD\relax
	\global\let\enreviewerE\relax
	\global\let\enchairperson\relax
	\global\let\encommissionerA\relax
	\global\let\encommissionerB\relax
	\global\let\encommissionerC\relax
	\global\let\encommissionerD\relax
	\global\let\encommissionerE\relax
	\global\let\eendefencedate\relax
	
	\fi	%修改日期：2018.07.05
}

% 中日合作定制版英文扉页
\newcommand\HDUmakeJPENtitlepage{
	\cleardoublepage
	\pdfbookmark[0]{英文题名页}{anchor_entitle}
	\thispagestyle{HDU@empty}
	{
	\linespread{1.3}
	%\vspace*{8mm}
	\vspace*{2mm}
	
	\begin{center}
		{\zihao{-1}\bfseries \MakeUppercase{\HDU@englishtitle}}
		
		\vspace{25mm}
	
		{\zihao{3}\bfseries BY}
		
		\vspace{15mm}
		
		{\zihao{3}\bfseries \MakeUppercase{\HDU@englishauthor} \hspace{1em}}\\
		\vspace{30mm}
		
		{\zihao{-2}\bfseries THESIS}\\
		\vspace{15mm}

		presented to the faculty of \\  %[10mm]
		the Graduate School of Hangzhou Dianzi University\\
		in partial fulfillment of the requirements\\
		for the degree of Master of Science\\[10mm]
		Under the Supervision of \HDU@englishspvtitle\,\HDU@englishsupervisor \,and \HDU@englishcpvtitle\,\HDU@englishcpsupervisor\\
	\end{center}
	\vspace{10mm}
	
	\begin{center}
	%\hfill{\zihao{4}\songti 答辩日期: \HDUunderline[150pt]{\HDU@defencedate}}
	{\zihao{4}\bfseries{\HDU@eendefencedate}}
       \end{center}



	\iffalse % 自己修改的 修改日期：2018.07.05
	
	\begin{center}
		% 新建一个长度寄存器，存放英文题名页标题宽度值
		\newlength{\etitle@width}
		\addtolength{\etitle@width}{300pt}
		\begin{minipage}[b][50pt][b]{\etitle@width}
			\centering
			\fontsize{16}{23}\bfseries
			\settowidth{\etitlelength}{\HDU@englishtitle}
			\HDU@englishtitle\\*	% 这个就是英文标题，隐藏的也很深。
			\ifdim\etitlelength<\etitle@width
				\addtolength{\etitlelength}{30pt}
				\raisebox{25pt}[0pt][0pt]{\parbox[t][][t]{\etitle@width}{
				\centering
				\rule{\etitlelength}{\ULthickness}}}
			\else\ifdim\etitlelength<2\etitle@width
					\addtolength{\etitlelength}{-\etitle@width}
					\addtolength{\etitlelength}{40pt}
					\raisebox{55pt}[0pt][0pt]{\parbox[t][][t]{\etitle@width}{
					\centering
					\rule{\etitle@width}{\ULthickness}\\*
					\rule{\etitlelength}{\ULthickness}}}
			\else\ifdim\etitlelength<3\etitle@width
					\addtolength{\etitlelength}{-2\etitle@width}
					\addtolength{\etitlelength}{80pt}
					\raisebox{85pt}[0pt][0pt]{\parbox[t][][t]{\etitle@width}{
					\centering
					\rule{\etitle@width}{\ULthickness}\\*
					\rule{\etitle@width}{\ULthickness}\\*
					\rule{\etitlelength}{\ULthickness}}}
			\fi\fi\fi
		\end{minipage}
	\end{center}
	
	\fi % 自己修改的 修改日期：2018.07.05
	
	\iffalse
	
	\begin{center}
		\includegraphics[width=22.8mm]{./logo/QSY.pdf}
	\end{center}
	%\vspace{6mm}
	\vspace{5mm}
	\begin{center}
		\begin{tabular}{>{\zihao{3}\bfseries}rl}
			Author's signature: & \HDUunderline[120pt]{\hfill}\\[10mm]
			Supervisor's signature: & \HDUunderline[120pt]{\hfill}
		\end{tabular}
	\end{center}
	%\vspace{8mm}
	\vspace{7mm}
	\begin{center}
		\begin{tabular}{>{\zihao{4}}r>{\zihao{4}}l}
		%External Reviewers: & \HDUunderline[260pt]{\HDU@enreviewerA}\\[2mm]
		Thesis Reviewer 1: & \HDUunderline[240pt]{\HDU@enreviewerA}\\[2mm]
	    Thesis Reviewer 2: & \HDUunderline[240pt]{\HDU@enreviewerB}\\[2mm]
		Thesis Reviewer 3: & \HDUunderline[240pt]{\HDU@enreviewerC}\\[2mm]
	    Thesis Reviewer 4: & \HDUunderline[240pt]{\HDU@enreviewerD}\\[2mm]
		Thesis Reviewer 5: & \HDUunderline[240pt]{\HDU@enreviewerE}\\[10mm]
		Examining Committe Chair: & \HDUunderline[240pt]{\HDU@enchairperson}\\[2mm]
	    Committeeman 1: & \HDUunderline[240pt]{\HDU@encommissionerA}\\[2mm]
	    Committeeman 2: & \HDUunderline[240pt]{\HDU@encommissionerB}\\[2mm]
	    Committeeman 3: & \HDUunderline[240pt]{\HDU@encommissionerC}\\[2mm]
	    Committeeman 4: & \HDUunderline[240pt]{\HDU@encommissionerD}\\[2mm]
	    Committeeman 5: & \HDUunderline[240pt]{\HDU@encommissionerE}
		\end{tabular}
	\end{center}
	\vspace{12mm}
	\begin{center}
	{\zihao{4} Date of oral defence: \HDUunderline[150pt]{\HDU@eendefencedate}}
    \end{center}
  }
		%清空变量节省空间
	\global\let\HDU@enreviewerA\@empty
	\global\let\HDU@enreviewerB\@empty
	\global\let\HDU@enreviewerC\@empty
	\global\let\HDU@enreviewerD\@empty
	\global\let\HDU@enreviewerE\@empty
	\global\let\HDU@enchairperson\@empty
	\global\let\HDU@encommissionerA\@empty
	\global\let\HDU@encommissionerB\@empty
	\global\let\HDU@encommissionerC\@empty
	\global\let\HDU@encommissionerD\@empty
	\global\let\HDU@encommissionerE\@empty
	\global\let\HDU@eendefencedate\@empty
	\global\let\HDU@englishtitle\@empty			
	\global\let\englishtitle\relax
	\global\let\enreviewerA\relax
	\global\let\enreviewerB\relax
	\global\let\enreviewerC\relax
	\global\let\enreviewerD\relax
	\global\let\enreviewerE\relax
	\global\let\enchairperson\relax
	\global\let\encommissionerA\relax
	\global\let\encommissionerB\relax
	\global\let\encommissionerC\relax
	\global\let\encommissionerD\relax
	\global\let\encommissionerE\relax
	\global\let\eendefencedate\relax
	
	\fi	%修改日期：2018.07.05
}


% 独创声明与版权协议转让页 原创性声明：采用杭电的统一格式，标题为宋体四号，内容为宋体小四号字体
\newcommand\makeOSpage{%
	\cleardoublepage
	\pdfbookmark[0]{原创性声明}{anchor_os}
	\thispagestyle{HDU@empty}
	{
		\newcommand\signature@date{日期：%
			\hspace{8ex}年\hspace{4ex}月\hspace{4ex}日}
		\linespread{1.7}			% 相当于word中的1.5倍行距。
		\songti\zihao{-4}
		\vspace*{1ex} % 1 ex = 当前字体尺寸中 x 的高度
		\begin{center}
			\songti\zihao{4}\bfseries 杭州电子科技大学学位论文原创性声明和使用授权说明
		\end{center}
		\vspace{20pt}
		
		\begin{center}
			\songti\zihao{4}原创性声明
		\end{center}
		\vspace{20pt}

		本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得%
		的成果。除文中已经注明的引用的内容外，本论文不含任何其他个人或集体已经发表%
		或撰写过的作品和成果。对本文的研究做出重要贡献的个人和集体，均已在文中以%
		明确方式标明。申请学位论文与资料若有不实之处，本人承担一切相关责任。
		\vspace{30pt}
		
		\begin{center}
		学位论文作者签名：\hspace{13ex} \signature@date
		\end{center}
		
		\vspace{30pt}
		\begin{center}
			\songti\zihao{4} 学位论文使用授权说明
		\end{center}
		\vspace{20pt}
		本人完全了解杭州电子科技大学关于保留和使用学位论文的规定，即：研究生在校攻读%
		学位期间论文工作的知识产权单位属杭州电子科技大学。本人保证毕业离校后，发表论文%
		或使用论文工作成果时署名单位仍然为杭州电子科技大学。学校有权保留送交论文的复应件，%
		允许查阅和借阅论文；学校可以公布论文的全部或者部分内容，可以允许采用影印、缩印或其它复制手段保存论文。%
		（保密的论文在解密后遵守此规定）\\[30pt]
		\begin{center}
		论文作者签名：\hspace{13ex} \signature@date \\[20pt]
		指导教师签名：\hspace{13ex} \signature@date
		\end{center}
	}
}

%---------- 层次标题格式设置 ----------
\setcounter{secnumdepth}{4}		%设置为四级标题
\if@englishversion
	\renewcommand\@chapapp{Chapter \thechapter}%
\else
	\renewcommand\@chapapp{第\zhnumber{\thechapter} 章}%
\fi

% 以下对标题格式采用laTeX2e底层命令主要是为了防止ctex宏包升级改变导致的命令不兼
% 容性，假如2.0之后宏包对1.02宏包命令不再支持，以后又要修改，不如一鼓作气。
% 现在以下命令可以正常工作，调整参数则慢慢来吧。

%% 章标题格式设置----小三仿宋加黑  %% 修改各章标题为黑体三号字%%
\renewcommand\chapter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\phantomsection			% hyperref宏包的命令，超链接用。
    % 软件学院和计算机学院规定每章的第一页也要有页眉
    % 可是为什么？为什么一定要这样呢？一点都不美观的说(￣^￣)
	% \thispagestyle{HDU@plain}
	\global\@topnum\z@%
	\@afterindenttrue%
	\secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
	\NR@gettitle{#1}
	\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
			\refstepcounter{chapter}%
			\addcontentsline{toc}{chapter}{\songti\protect\numberline{\@chapapp}#1}
		\else
			\addcontentsline{toc}{chapter}{\songti#1}%
		\fi
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	% 在图目录和表目录中相应章节位置加垂直10pt的空白。
	%\addtocontents{lof}{\protect\addvspace{10\p@}}%
	%\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\@makechapterhead{#2}
	\@afterheading}		% 不知道这个\@afterheading有什么用，先放着。
\def\@makechapterhead#1{%
	\vspace*{20\p@}%
	{\parindent \z@ \centering
%	\heiti\zihao{4}   %\bfseries %% 修改各节标题为黑体四号字，各小节标题为黑体小四号字，均靠左。 %%
	\heiti\zihao{3}\bfseries %% 修改各章标题为黑体三号字%%
	\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
			\@chapapp \hskip1em%
		\fi
	\fi
	\interlinepenalty\@M
	 #1\par\nobreak
	\vskip 24\p@}}
\def\@schapter#1{%
	\@makeschapterhead{#1}
	\@afterheading}
\def\@makeschapterhead#1{%
	\vspace*{20\p@}%
	{\parindent \z@ \centering
	\fangsong \zihao{-3} \bfseries
	\interlinepenalty\@M
	#1\par\nobreak
    \vskip 24\p@}}

% 新建一个章节标题宏，用法跟\chapter一样，只不过在无星号时，标题插入目录，但是没
% 有页码和中间点线。加星号功能跟\chapter一样，主要为了兼容。\mainmatter中chapter
% 编号计数器不变\npchapter和\chapter都为chapter计数器。
\newcommand\npchapter{
	\if@openright\cleardoublepage\else\clearpage\fi%
	\phantomsection			% hyperref宏包的命令，超链接用。
	%\thispagestyle{HDU@plain}%
	\global\@topnum\z@%
	\@afterindenttrue%
	\secdef\@npchapter\@schapter}
\def\@npchapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
			\refstepcounter{chapter}%计数器不变
			\addcontentsline{toc}{nopagechapter}{\protect\numberline{\@chapapp}#1}
		\else
		    % Kwen 目录页码改造
			%\addcontentsline{toc}{nopagechapter}{#1}%
		\fi
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	% 在图目录和表目录中相应章节位置加垂直10pt的空白。
	%\addtocontents{lof}{\protect\addvspace{10\p@}}%
	%\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\@makechapterhead{#2}
	\@afterheading}

\if@englishversion
% 英语版本字体设置
	%%一级节标题格式设置----Times New Roman加粗四号字，居左，缩进0.5英寸，行距1.5倍，段前1行，段后0.5行；
	\renewcommand\section{\@startsection{section}{1}{\z@}%
										{3.5ex \@plus 1ex \@minus .2ex}%
										{2.3ex \@plus.2ex}%
										{\parindent \z@ \raggedright
										 \bfseries\zihao{4}}}
	
	%%二级节标题格式设置----Times New Roman加粗小四号字，居左，缩进0.5英寸，行距1.5倍，段前1行，段后0.5行；
	\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
										{3.25ex \@plus 1ex \@minus .2ex}%
										{1.5ex \@plus.2ex}%
										{\parindent \z@ \raggedright
										 \bfseries\zihao{-4}}}
	
	%%三级节标题格式设置---无要求
	\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
										{3.25ex \@plus 1ex \@minus .2ex}%
										{1.5ex \@plus.2ex}%
										{\parindent \z@ \raggedright
										 \zihao{-4}}}
										 
%	%%四级节标题格式设置---小4号黑体加粗
%	\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
%										{3.25ex \@plus 1ex \@minus .2ex}%
%										{1.5ex \@plus.2ex}%
%										{\parindent \z@ \raggedright
%										 \heiti\zihao{-4}\bfseries}}
\else
	%%一级节标题格式设置----3号黑体 
	\renewcommand\section{\@startsection{section}{1}{\z@}%
										{3.5ex \@plus 1ex \@minus .2ex}%
										{2.3ex \@plus.2ex}%
										{\parindent \z@ \raggedright
										 \heiti\zihao{3}}}
	
	%%二级节标题格式设置----小3号黑体 
	\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
										{3.25ex \@plus 1ex \@minus .2ex}%
										{1.5ex \@plus.2ex}%
										{\parindent \z@ \raggedright
										 \heiti\zihao{-3}}}
	
	%%三级节标题格式设置---4号黑体 
	\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
										{3.25ex \@plus 1ex \@minus .2ex}%
										{1.5ex \@plus.2ex}%
										{\parindent \z@ \raggedright
										 \heiti\zihao{4}}}
										 
	%%四级节标题格式设置---小4号黑体加粗
	\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
										{3.25ex \@plus 1ex \@minus .2ex}%
										{1.5ex \@plus.2ex}%
										{\parindent \z@ \raggedright
										 \heiti\zihao{-4}\bfseries}}
\fi									
									 

% \abstractmatter \frontmatter,\mainmatter,\backmatter重定义。
\newcommand\abstractmatter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
    \pagenumbering{Roman}
	\@mainmatterfalse
	\pagestyle{HDU@headings}}
\renewcommand\frontmatter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
    \pagenumbering{Roman}
	\@mainmatterfalse
	\pagestyle{HDU@headings}}
\renewcommand\mainmatter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\@mainmattertrue
	\pagenumbering{arabic}
	\pagestyle{HDU@headings}}
\renewcommand\backmatter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\@mainmatterfalse}
	
% 对\appendix进行重新定义，使之可以在\backmatter之后产生章节标题序号，且在书签栏
% 和目录上点击后可以正常跳转到相应的标题项。放弃原来对 \appendix的修改，在前部加
% 上\mainmattertrue会导致书签和目录项跳转产生问题。
\let\OLDappendix\appendix
\newif\if@appendixinbackmatter
\renewcommand\appendix{
	\if@mainmatter
		\@appendixinbackmatterfalse
		\OLDappendix
	\else
		\@appendixinbackmattertrue
		\@mainmattertrue
		\OLDappendix
%		\renewcommand\@chapapp{}
        \if@englishversion
		  \renewcommand{\appendixname}{Appendix}
    	  \renewcommand\thesubsubsection {\zihao{3} {\@arabic\c@subsubsection}.\hspace{-0.3cm}}
        \else
		  \renewcommand{\appendixname}{附\texorpdfstring{\HDUspace}{}录}
		  \renewcommand\thesubsubsection {\heiti\zihao{3} \zhnumber{\@arabic\c@subsubsection}、\hspace{-0.5cm}}
		\gdef\thechapter{\@Alph\c@chapter}
	\fi}
	
%\let\OLDappendix\appendix
%\newif\if@appendixinbackmatter
%\renewcommand\appendix{
%	\if@mainmatter
%		\@appendixinbackmatterfalse
%		\OLDappendix
%	\else
%		\@appendixinbackmattertrue
%		\@mainmattertrue
%		\OLDappendix
%		\renewcommand\@chapapp{附录~\thechapter}
%		\gdef\thechapter{\@Alph\c@chapter}
%	\fi}

%---------- 三种目录 ----------
\if@englishversion
	\renewcommand{\contentsname}{Contents}	% 重命名章节目录名。
	\renewcommand{\listfigurename}{List of Figures}	% 重命名插图目录名。
	\renewcommand{\listtablename}{List of Tables}	% 重命名表目录名。
	\renewcommand\bibname{References}                % 重命名参考文献名
\else
	\renewcommand{\contentsname}{目\texorpdfstring{\HDUspace}{}录}				% 重命名章节目录名。
	\renewcommand{\listfigurename}{图\texorpdfstring{\HDUspace}{}目\texorpdfstring{\HDUspace}{}录}			% 重命名插图目录名。
	\renewcommand{\listtablename}{表\texorpdfstring{\HDUspace}{}目\texorpdfstring{\HDUspace}{}录}				% 重命名表目录名。
\fi

% 下一条命令作用：在toc目录文件中插入‘\let\CTEX@spaceChar\relax’字符，用以删除目
% 录中的空格字符，其空格字符由\CTEX@spaceChar定义。
\addtocontents{toc}{\let\string\HDU@spaceChar\relax}

% 目录位置尺寸设置
\renewcommand\@pnumwidth{1.55em}		% 放页码page这个盒子的宽度
\renewcommand\@tocrmarg{2.55em}			% 这个参数怎么没用，改动后看不到效果
\renewcommand\@dotsep{2.2} 				% 目录点间的距离
\setcounter{tocdepth}{2}				% 目录深度，到subsection。

%% 章节目录
\renewcommand\tableofcontents{%
	% 使用\npchapter，将标题插入目录，但是不产生页码和中间点线。
	\npchapter{\contentsname}
	\markboth{\contentsname}{}
	\@starttoc{toc}
}

% 发现latex2e源码中有这么一行：\def\contentsline#1{\csname l@#1\endcsname}这样一
% 下子就明白了，以\l@*** 开头的命令的两个参数就是\contentsline使用说明的三个参数
% 中的后面两个参数，虽然定义的时候\contentsline只有一个参数。
% #1为目录内容，可以加上章节号title，\chapter中有定义；#2为页码page。
\renewcommand*\l@chapter[2]{%
	\ifnum \c@tocdepth >\m@ne
		\addpenalty{-\@highpenalty}%
		% 下一行增加新一章章节标题在目录中与前面部分的间距
		% \vskip 2\p@ \@plus\p@
		% 下一行是章节序号所在box的宽度
		\setlength\@tempdima{1.5em}%
		\begingroup
			\parindent \z@ \rightskip \@pnumwidth
			\parfillskip -\@pnumwidth
			\leavevmode
			\advance\leftskip\@tempdima
			\hskip -\leftskip
			\fangsong\zihao{-4} #1\nobreak
			% 下两行是增加章节标题项的中间点
			\leaders\hbox{$\m@th%
				\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
			\nobreak\hb@xt@\@pnumwidth{\hss #2}\par
			\penalty\@highpenalty
    	\endgroup
	\fi}

% 这个样式主要是为“目录”这个标题在目录页中的样式服务的，模板中要求“目录”没有页码
% 和中间点连接线，所以弄了这么个nopagechapter目录格式。你说我为什么不用其他方法，
% 这也是没办法，hyperref 宏包把\addcontentsline和\contentsline改了，主要是为了超
% 链接用，如果我把他们重新定义，超链接就会失效。
\newcommand*\l@nopagechapter[2]{%
	\ifnum \c@tocdepth >\m@ne
		\addpenalty{-\@highpenalty}%
		\setlength\@tempdima{1.5em}%
		\begingroup
			\parindent \z@ \rightskip \@pnumwidth
			\parfillskip -\@pnumwidth
			\leavevmode
			\advance\leftskip\@tempdima
			\hskip -\leftskip
			\fangsong\zihao{-4} #1\nobreak\hfill
			\nobreak\hb@xt@\@pnumwidth{\hss}\par
			\penalty\@highpenalty
    	\endgroup
	\fi}

% \@dottedtocline定义了5个参数，但是一下命令里只使用了两个，后面两个其实原理跟上
% 面介绍的一样，\contentsline带有3个参数，第一个参数展开后形成\l@***的命令，然后
% \l@***再展开，形成带有3个参数的\@dottedtocline{}{}{}，\@dottedtocline还需title
% 和page两个参数，而\contentsline剩下的两个参数刚好是title和page。
\renewcommand*\l@section{\@dottedtocline{1}{2em}{2.1em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{4em}{3em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{6em}{3.8em}}

%% 图目录
\renewcommand\listoffigures{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\chapter{\listfigurename}
	\@starttoc{lof}}

\renewcommand*\l@figure{\@dottedtocline{1}{0\p@}{2.3em}}

%% 表目录
\renewcommand\listoftables{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\chapter{\listtablename}
	\@starttoc{lot}}

\let\l@table\l@figure


%\newenvironment{tabnumberline}[2]{
%	\renewcommand{\numberline}[1]{Table ~#1\hspace*{1em}}
%}{}
%
%\newcommand\maketableofcontents{
%	\tableofcontents
%%	\listoffigures
%	\begin{tabnumberline}
%		\listoftables
%	\end{tabnumberline}
%}


% ---------- 参考文献样式 ----------
% 修改thebibliography 环境用于在目次中加入参考文献页。
\renewenvironment{thebibliography}[1]
     {\chapter{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \itemsep \z@ \@plus\p@ \@minus\p@
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

% 采用gbt7714-2005参考文献样式，
% 参考自https://github.com/githamburger/GBT7714-2005-BibTeX-Style
%\RequirePackage{gbt7714}
%\bibliographystyle{gbt7714-2005-numerical}
\bibliographystyle{gbt7714-2005}


% natbib宏包命令，设置参考文献交叉引用格式。
\if@englishversion
	\setcitestyle{square,comma}
\else
	\setcitestyle{super,square,comma}
\fi
% natbib宏包命令，参考文献上标设置。
% \setcitestyle{super,square,comma}
% \setcitestyle{square,comma}

%\RequirePackage{notoccite}
%\RequirePackage{cite}
%% \renewcommand \citeform[1]{[#1]}
%\def \citepunct{], [}
%\def \citedash{]--[}

% 重新定义 \ref 命令，使其前面自动加一个 ``~''。因为hyperref 宏包会通过 \AtBegin-
% Document 修改 \ref 的定义，因此我们对 \ref 的修改也必须使用\AtBeginDocument 命
% 令进行。同时我们需要修改 \eqref，使其括号前后不出现空隙。参考自njuthesis胡海星。
\AtBeginDocument{%
	\let\oldref\ref%
	\renewcommand*{\ref}[1]{\thinspace\oldref{#1}}%
	\renewcommand*{\eqref}[1]{(\oldref{#1})}
}

% ---------- 结尾相关内容的定义 ----------
\RequirePackage{comment}
%\excludecomment{environment}
%\let\endfigure\relax
\newenvironment{acknowledgment}{
    \if@englishversion
	   \chapter{Acknowledgments}{}
    \else
	   \chapter{致\texorpdfstring{\HDUspace}{}谢}{}
    \fi
}
	
\if@blindreview
	\excludecomment{acknowledgment}
	\let\endacknowledgment\relax
\fi

%\newcommand*\bibfile[1]{\long\gdef\HDU@bibfile{#1}}	
%\newcommand*\acknowledgmentfile[1]{\long\gdef\HDU@acknowledgmentfile{#1}}
\newcommand*\appendixfile[1]{\long\gdef\HDU@appendixfile{#1}}

\RequirePackage{zhnumber}
\RequirePackage{enumitem}

\setcounter{secnumdepth}{6}
\newcommand{\appendixsec}{\@startsection{subsubsection}{6}{\z@}%
									    {3.5ex \@plus 1ex \@minus .2ex}%
									    {2.3ex \@plus.2ex}%
									    {\parindent \z@ \raggedright
									     \heiti\zihao{3}}}
\newcommand{\bmask}[1]{
\if@blindreview
	*
\else
	#1
\fi}

\newcommand\makemyappendix{
	\appendix
	\chapter{}
    \if@englishversion
	   % \begin{center}
		  % {\zihao{4}     }
	   % \end{center}
    \else
	   \begin{center}
		  {\zihao{4} 作者在读期间发表的学位论文及参加的科研项目}
	   \end{center}
    \fi
	
	\input{\HDU@appendixfile}
%	\vspace{12mm}	
%	\begin{minipage}{36em}
%  		\input{\HDU@appendixfile}
%	\end{minipage}
}

% ---------- 浮动体相关定义 ----------
% 设置浮动环境标题的字体大小。根据学位论文格式要求，插图和表格标题字体需要比正文
% 字体略小。
\captionsetup{
	format=hang,        % 图表号悬挂
	% labelsep=quad,		% 去掉图表号后的冒号。图序与图名文字之间空一个汉字宽度。
	skip=10pt,			% 标题与图标之间空10pt距离。
	font=small,			% 标题字体比正文小一号，这里取small。
	width=0.75\textwidth,   % 标题最大宽度为0.75倍正文宽度。
    justification=centering
}

%\captionsetup[figure]{
%    format=plain,
%    % belowskip=-10pt
%    % justification=centering
%}

\if@englishversion
    \renewcommand\figurename{Figure}
    \renewcommand\tablename{Table}
\fi

% 根据学位论文格式要求，表格的标题必须位于表格上方，插图的标题必须位于插图下方。
%\captionsetup 容易出现失效的情况
%\captionsetup[table]{position=above}
%\captionsetup[figure]{position=below}
\RequirePackage{floatrow}
\floatsetup[table]{capposition=above}
\floatsetup[figure]{capposition=below}

%% 以下为设置浮动对象和文字之间的距离。
% 版心顶部或者版心底部浮动体之间的垂直距离，默认为12pt plus 2pt minus 2pt。
\setlength{\floatsep}{20bp \@plus4pt \@minus1pt}

% 文本行之间浮动体（使用h位置选项）与上下文之间的距离，默认为12pt plus 2pt minus
% 2pt。
\setlength{\intextsep}{20bp \@plus4pt \@minus2pt}

% 版心顶部或底部的浮动体与文本之间的距离，默认为12pt plus 2pt minus 2pt。
\setlength{\textfloatsep}{20bp \@plus4pt \@minus2pt}

% 浮动页中，版心顶部的浮动体与版心顶边之间的距离，默认为0pt plus 1fil。
\setlength{\@fptop}{0bp \@plus1.0fil}

% 浮动页中浮动体直接的距离，默认为8pt plus 2fil。
\setlength{\@fpsep}{12bp \@plus2.0fil}

% 浮动页中，版心底部的浮动体与版心底边之间的距离，默认为0pt plus 1fil。
\setlength{\@fpbot}{0bp \@plus1.0fil}

% 设置首行缩进
\if@englishversion
	\setlength{\parindent}{0.5in}
\else
	\setlength{\parindent}{2em}
\fi

\renewcommand{\baselinestretch}{1.5}

%% 下面这组命令使浮动对象的缺省值稍微宽松一点，从而防止幅度对象占据过多的文本页
%% 面，也可以防止在很大空白的浮动页上放置很小的图形。
% 默认情况下，LaTeX要求每页的文字至少占据 20%，否则该页就只单独放置一个浮动环境。
% 而这通常不是我们想要的。我们将这个要求降低到 5%。
\renewcommand{\textfraction}{0.05}

% 在一文本页中，被置于版心顶部的所有浮动体的高度与版心高度的最大比值，默认为0.7，
% 这里修改为0.9，任何造成高度超过版心高度90% 的浮动体都被将阻止置于当前版心顶部。
\renewcommand{\topfraction}{0.9}

% 同上，只不过变成了版心底部，默认为0.3.
\renewcommand{\bottomfraction}{0.8}

% 在任意一个“浮动页”中，所有的浮动体高度与版心的高度的最小比值，默认为 0.5，这里
% 设置成0.85。因此，浮动页中空白与版心的比值不会超过1-\floatpagefraction。
\renewcommand{\floatpagefraction}{0.85}

% ---------- 中英文摘要及关键词 ----------
% 中文摘要环境
\newenvironment{cabstract}{%
    \chapter{摘\texorpdfstring{\HDUspace}{}要}\songti}{}
\newenvironment{eabstract}{%
	\chapter{ABSTRACT}}{}


% 中英文关键词命令及其格式的自动定义；
% 参照thuthesis，薛瑞尼，P37/66，v4.8.1 (2014/12/09)。
% 这段宏定义搞了我一个下午才看懂，哎…… 这个 \@for 命令挺有用的。
\def\HDU@parse@keywords#1{
	\expandafter\gdef\csname HDU@#1\endcsname{} % todo: need or not?
	\expandafter\gdef\csname @#1\endcsname##1{
	\@for\reserved@a:=##1\do{
		\expandafter\ifx\csname HDU@#1\endcsname\@empty\else
	    	\expandafter\g@addto@macro\csname HDU@#1\endcsname{%
	    	\ignorespaces\csname HDU@#1@separator\endcsname}
	  	\fi
	  	\expandafter\expandafter\expandafter\g@addto@macro%
	    \expandafter\csname HDU@#1\expandafter\endcsname%
	    \expandafter{\reserved@a}}}}

% 根据以上宏定义，以下命令分别产生\@ckeywords{} 和 \@ekeywords{} 两个读取关
% 键词的宏，和加工后保存关键词的 \HDU@ckeywords 和 \HDU@ckeywords 的宏定义。
\HDU@parse@keywords{ckeywords}
\HDU@parse@keywords{ekeywords}

\if@englishversion
	\def\HDU@ckeywords@separator{，}
	\def\HDU@ekeywords@separator{;}
\else
	\def\HDU@ckeywords@separator{、}
	\def\HDU@ekeywords@separator{,}
\fi

% 用户界面命令，读取和排版关键词
\newcommand*\ckeywords[1]{%
	\@ckeywords{#1}
	\vspace{5ex}
%	\textbf{关键词：}\HDU@ckeywords}
    \noindent\textbf{关键词：}{\songti\HDU@ckeywords}}
\newcommand*\ekeywords[1]{%
	\@ekeywords{#1}
	\vspace{5ex}
%	\textbf{Keywords:}\ \HDU@ekeywords}
	\noindent\textbf{Keywords:}\ \HDU@ekeywords}

% ---------- 通用列表环境的重新定义 ----------
% 以下列表参数的修改主要是模仿book.cls，整体样式改动不大，只是修改了参数，但是去
% 掉了对twocolumn的支持。

%% 各级列表的缩进没有改变，所以注释掉了，如需改变，自己改。
% \setlength\leftmargini  {2.5em}
% \leftmargin  \leftmargini
% \setlength\leftmarginii  {2.2em}
% \setlength\leftmarginiii {1.87em}
% \setlength\leftmarginiv  {1.7em}
% \setlength\leftmarginv  {1em}
% \setlength\leftmarginvi {1em}

%% 标签与列表正文的间距和标签的宽度，因为参数没改，所以注释掉了。
% \setlength  \labelsep  {.5em}
% \setlength  \labelwidth{\leftmargini}
% \addtolength\labelwidth{-\labelsep}

% 鼓励在list前、后和item间分页。
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty

% 各级列表的参数结构参数设置
\def\@listi{\leftmargin\leftmargini
            \parsep\parskip
            \topsep\z@
            \itemsep\z@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep \z@
              \parsep \z@
              \itemsep \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep \z@
              \parsep \z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep \topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}

% ---------- 打算重新定义Enumerate，Itemize，先挖个坑 ----------


% ---------- 缩写、符号清单、术语表 ----------
% 以下尺寸详细说明见P33/112
\newenvironment*{denotation}[1][2.5cm]{
\chapter{缩写、符号清单、术语表}
\noindent
\begin{list}{}{
	\renewcommand\makelabel[1]{##1\hfil}
	\setlength{\itemindent}{0cm} 			% 标签缩进量
	\setlength{\labelsep}{1cm} 				% 标签与列表文本距离
	\setlength{\labelwidth}{#1} 			% 标签盒子宽度，如有需要可以自行修改
	\setlength{\listparindent}{0pt} 		% 同一\item 第二及以后段落缩进量
	\setlength{\rightmargin}{0cm}
	\setlength{\leftmargin}{\labelwidth}		% list环境整体向右推
	\addtolength{\leftmargin}{\labelsep}		% \labelwidth + \labelsep 的距离
	\setlength{\itemsep}{0pt plus2pt minus1pt}	% 标签间距
	\setlength{\parsep}{\itemsep} 				% 段落间距
	\setlength{\topsep}{0pt} 					% 标签与上文的间距
	\setlength{\partopsep}{3pt plus2pt minus2pt}
}}{\end{list}}

% ---------- 脚注样式 ----------
% 使用footmisc宏包和pifont宏包设置符合 GB/T 7713.1-2006 规范的脚注样式。注意，由
% 于pifont宏包提供的特殊符号的限制，一页之中最多只能有10个脚注。
% 这些命令设置跟脚注设置方法思路全都引用自南京大学计算机科学与技术系胡海星编写的
% 《NJU-Thesis:南京大学学位论文XeLaTeX模板》v1.1.18 (2015/7/16)版本。
\DefineFNsymbols*{circlednumber}[text]{%
	{\ding{192}} %
	{\ding{193}} %
	{\ding{194}} %
	{\ding{195}} %
	{\ding{196}} %
	{\ding{197}} %
	{\ding{198}} %
	{\ding{199}} %
	{\ding{200}} %
	{\ding{201}}}
\setfnsymbol{circlednumber}
