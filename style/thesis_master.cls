%! TEX root = ./main.tex

%===========================================================================%
%->> Shawn's personal template.
%->> Compile: XeLatex
%->> For more infomation:
%    https://github.com/lazyshawn/hitszthesis_master.git
%->> HOWTOs & Demo:
%
%===========================================================================%

%===========================================================================%
%->> Version
%===========================================================================%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\newcommand*\@iflatexlater{\@ifl@t@r\fmtversion}%
\@iflatexlater{2017/01/01}{}{%
  \ClassError{hitszthesis}{TeXLive/MikTex >= 2017 is required ...}{}%
}
\ProvidesClass{style/thesis_master}[
  2020/03/30 v1.0
  My custom class for master thesis.
]


%===========================================================================%
%->> Condition & Constant
%===========================================================================%
\newif\ifhitsz@midterm\hitsz@midtermfalse
\def\hitsz@info@degree{硕士}


%===========================================================================%
%->> Declare Options
%===========================================================================%
\PassOptionsToClass{openany}{book}%
% \PassOptionsToClass{twoside}{book}%
\PassOptionsToClass{\CurrentOption}{book}
\DeclareOption{midterm}{%
  \hitsz@midtermtrue
}

% ----- Handle non-implemented options
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{book}%
}

% ----- Terminates all options processing
\ProcessOptions\relax%



%===========================================================================%
%->> LoadClass
%===========================================================================%
\LoadClass[a4paper]{book}
\@ifclasslater{book}{2017/01/01}{}{%
  \ClassError{hitszthesis}{ctex >= 2017/01/01 is required \ldots}{}%
}


%===========================================================================%
%->> Load Class Configuration
%===========================================================================%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
  \makeatletter
  \InputIfFileExists{style/thesis.cfg}{}{}
  \makeatother
}


%===========================================================================%
%->> Load Packages
%===========================================================================%
\RequirePackage{ifxetex}    % LaTeX engine detection
\RequirePackage{geometry}   % 页面布局
\RequirePackage{fancyhdr}   % 页眉页脚
\RequirePackage{hyperref}   % 超链接
\RequirePackage{ulem}       % 下划线
\RequirePackage{enumitem}   % 列表环境
\RequirePackage{calc}       % 算术宏包
\RequirePackage{style/gbt7714}  % 参考文献标准: GB/T 7714 (包含natbib宏包)
\RequirePackage{graphicx}   % 插入图片
\RequirePackage{subfig}     % 子浮动体宏包，包含|\caption|宏包
\RequirePackage[export]{adjustbox} % 子浮动体对齐
\RequirePackage{booktabs}   % 表格线宏包
\RequirePackage[linesnumbered,boxed,ruled]{algorithm2e}
\RequirePackage{pdfpages}   % 插入PDF页面
\RequirePackage{amsmath,amsfonts,amssymb,bm}    % 数学公式
\RequirePackage{tabularx}   % 表格自动列宽
\RequirePackage{tikzpagenodes}  % 页边框
\RequirePackage{tikz}       % 绘图宏包
\usetikzlibrary{calc}       % tikz计算宏包
\RequirePackage{style/fontSetting} % 自定义的中文字体设置，记得最后导入


%===========================================================================%
%->> Page Layout
%===========================================================================%
% Pkg: geometry
\geometry{
  a4paper, % 210 * 297mm
  hcentering,
  ignoreall,
  nomarginpar,
}
\ifhitsz@midterm
  \geometry{% 版芯高度 = textheight(224) + head(5) + headsep(3) + footskip(8) = 240 mm
    text={160true mm,242true mm},
    top=25.5true mm,
    left=25true mm,
    head=5true mm,
    headsep=3true mm,
    footskip=10true mm,
  }
\else
  \geometry{% 版芯高度 = textheight(224) + head(5) + headsep(3) + footskip(8) = 240 mm
    text={150true mm,224true mm},
    top=37.5true mm,
    left=30true mm,
    head=5true mm,
    headsep=3true mm,
    footskip=8true mm,
  }
\fi


%===========================================================================%
%->> Define Domain
%===========================================================================%
% ----- Clear Pagestyle
\let\hitsz@cleardoublepage\cleardoublepage
\newcommand{\hitsz@clearemptydoublepage}{%
  \clearpage{\pagestyle{fancy@empty}\hitsz@cleardoublepage}
}
\let\cleardoublepage\hitsz@clearemptydoublepage

% ----- Front Domain
% 关闭章节序号， 页码使用罗马数字;
\renewcommand\frontmatter{%
  \if@openright\hitsz@clearemptydoublepage\else\clearpage\fi
  \setcounter{secnumdepth}{-1}
  % \ctexset{chapter/numbering=false}
  \pagenumbering{Roman}
  \ifhitsz@midterm
    \hitsz@pagestyle{fancy@plain}
  \else
    \hitsz@pagestyle{fancy@front}
  \fi
}

% ----- Main Domain
% 开启章节序号计数，重置页码，页码使用阿拉伯数字;
\renewcommand\mainmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \setcounter{secnumdepth}{3}
  \pagenumbering{arabic}
  \hitsz@pagestyle{fancy@main}
  \ctexset{chapter/number=\arabic{chapter}}
  % 中期报告章节格式
  \ifhitsz@midterm
    \ctexset{
      chapter/name={},
      chapter/format={\heiti\zihao{-2}},
    }
  \fi
}

% ----- Appendix
% 重置章节序号计数， 章节序号使用字母，对页码没有影响；
\let\hitsz@appendix\appendix
\renewcommand{\appendix}{%
  \ctexset{%
    chapter/name={\appendixname},
    appendix/number=\Alph{chapter}
  }
  \hitsz@appendix
}


%===========================================================================%
%->> Headers & Footers
%===========================================================================%
% Pkg: fancyhdr
% ----- 空白页面格式
\let\hitsz@headrule\headrule
\fancypagestyle{fancy@empty}{\fancyhf{}%
  % 清空页眉
  \let\headrule\hitsz@headrule%
  \renewcommand{\headrulewidth}{\z@}
  % 无页脚
}

% ----- 书前部分格式
\fancypagestyle{fancy@plain}{\fancyhf{}%
  % 清空页眉
  \let\headrule\hitsz@headrule%
  \renewcommand{\headrulewidth}{\z@}
  % 页脚
  \fancyfoot[C]{\song\zihao{-5} -~\thepage~-}
}
\fancypagestyle{fancy@front}{\fancyhf{}%
  \fancyfoot[C]{\song\zihao{-5} -~\thepage~-}
  \fancyhead[EC]{\song\zihao{-5} \leftmark}
  \fancyhead[OC]{\song\zihao{-5} \rightmark}
  % \fancyhead[C]{\song\zihao{-5}
  % \hitsz@info@school 工学\hitsz@info@degree \hitsz@info@thesis}
  % 双页眉线
  \renewcommand{\headrule}{%
  \hrule width\headwidth height2.276pt \vspace{1pt}\hrule width\headwidth}
  \setlength{\headheight}{20pt}
}

% ----- 正文区格式
\fancypagestyle{fancy@main}{\fancyhf{}%
  \fancyfoot[C]{\zihao{5} -~\thepage~-}
  \ifhitsz@midterm
    \fancyhead[C]{\song\zihao{-5} \hitsz@info@school （深圳）中期报告}
  \else
    \fancyhead[C]{\song\zihao{-5}
    \hitsz@info@school 工学\hitsz@info@degree \hitsz@info@thesis}
  \fi
  \renewcommand{\headrule}{%
  \hrule width\headwidth height2.276pt \vspace{1pt}\hrule width\headwidth}
  \setlength{\headheight}{20pt}
}

% ----- 修改 pagestyle
\newcommand{\hitsz@pagestyle}[1]{%
  \ctexset{chapter/pagestyle=#1}
  \pagestyle{#1}
}


%===========================================================================%
%->> Title and Caption
%===========================================================================%
% Pkg: [heading]ctex
\ctexset{%
  chapter={
    name={第,章},
    afterindent=true,
    % 文类book将每一新章另起一页，该页的默认版式为plain
    beforeskip={18.74658bp},%一个空行 1.57481 × 18
    afterskip={24.74658bp},%0.8应该不计算间距 0.8 × 18 + 0.57481×18
    aftername=\enspace,
    format={\centering\heiti\zihao{-2}},
    % nameformat=\bfseries,
    numberformat=\normalfont,
    % titleformat=\bfseries,
    fixskip=true, % 添加这一行去除默认间距
  },
  section={
    afterindent=true,
    beforeskip={20.25bp plus 1.677267bp minus 1.157391bp}, % 原为13.5bp
    % afterskip={3.5ex plus 1ex minus .2ex}, % 原为13.5bp
    afterskip={20.25bp plus 1.677267bp minus 1.157391bp},
    format={\zihao{-3}\bfseries},
    numberformat=\normalfont,
    aftername=\enspace,
    fixskip=true,
    break={},
  },
  subsection={
    afterindent=true,
    beforeskip={16.5bp \@plus 1.842609bp \@minus 0.9920497bp}, % 原为11bp
    afterskip={16.5bp \@plus 2.33863bp \@minus 0.49602bp},
    format={\zihao{4}\bfseries},
    numberformat=\normalfont,
    aftername=\enspace,
    fixskip=true,
    break={},
  }
}

%===========================================================================%
%->> Abstract ENV
%===========================================================================%
% ----- 中文摘要
\newcommand{\abstract}{
  \chapter*{\hitsz@cap@abstract}[\hitsz@entoc@abstract]
  \@mkboth{\MakeUppercase\hitsz@cap@abstract}{\hitsz@cap@abstract}%
}
\newcommand\keyword[1]{%
  % 输入参数为所有关键字
	\renewcommand{\hitsz@token@keywords}{#1}
	\par
  \vspace{\baselineskip}
  \noindent\makebox[4em][l]{\zihao{-4}\hitsz@cap@keywords}%
  \begin{minipage}[t]{132mm}{
    \hitsz@token@keywords
  }
  \end{minipage}
}

% ----- 英文摘要
\newcommand{\enabstract}{
  \chapter*{\hitsz@cap@enabstract}[\hitsz@entoc@enabstract]
  \@mkboth{\hitsz@cap@enabstract}{\hitsz@cap@enabstract}%
}
\newcommand\enkeyword[1]{%
	\renewcommand{\hitsz@token@enkeywords}{#1}
  \par\vskip2ex
  \noindent\makebox[5em][l]{\zihao{-4}\hitsz@cap@enkeywords}%
  \begin{minipage}[t]{128mm}{
    \hitsz@token@enkeywords
  }
  \end{minipage}
}


%===========================================================================%
%->> Table of Contents
%===========================================================================%
% Pkg: hyperref
\setcounter{tocdepth}{2}
% 以章节格式添加目录
\renewcommand\tableofcontents{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \phantomsection    % 虚拟章节
  \chapter*{\hitsz@cap@contents}
  \@mkboth{\hitsz@cap@contents}{\hitsz@cap@contents}%
  \normalsize\@starttoc{toc}
}
\def\@pnumwidth{1.55em}  % 页码宽度
\def\@tocrmarg{2.55em}  % 标题行左缩进宽度
\def\@dotsep{0.3}
\ifhitsz@midterm
  \setlength\@tempdima{1em} % 序号盒子宽度 (第n章)
\else
  \setlength\@tempdima{4em} % 序号盒子宽度 (第n章)
\fi

\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth > \m@ne \relax
    \addpenalty{-\@highpenalty}%
    % \setlength\@tempdima{4em} % 序号盒子宽度 (第n章)
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode %\bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \heiti #1 \nobreak\hfil % 章节标题内禁止换行
      \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
% \@dettedtocline{层次深度}{缩进宽度}{序号宽度}
\renewcommand*\l@section{\@dottedtocline{1}{1em}{1.8em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{2em}{2.5em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{3\ccwd}{3.1em}}

% 英文目录
\newcommand\tableofencontents{
% 此处添加英文目录的章标题格式，默认细点
% 控制英文目录：细点\@dottedtocline，粗点\@dottedtoclinebold
  \def\l@chapter{\@dottedtocline{0}{0em}{5em}}
  \@restonecolfalse
  \chapter*{\hitsz@cap@encontents}
  \@mkboth{\hitsz@cap@encontents}{\hitsz@cap@encontents}%
  \@starttoc{entoc}%
  \if@restonecol\twocolumn\fi
}

% 设置章节命令。s: 星号，表示在目录中出不出现序号。m: 必须要有的选项，中文章
% 节名称也即目录中名称，页眉中名称，书签中的名称。o: 可选内容，没有就默认是正
% 文章节，如果有，则是英文目录中显示的内容。
% ----- 双语Chapter
\let\hitsz@chapter\chapter
\RenewDocumentCommand{\chapter}{s o m o}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \IfBooleanTF{#1}{%	if \chapter*
    \IfNoValueTF{#4}{%
      \hitsz@chapter*{#3}}
     {\hitsz@chapter*{#3}
      % 此处添加保护选项
      \addcontentsline{toc}{chapter}{\texorpdfstring{\bfseries #3}{#3}}
      \addcontentsline{entoc}{chapter}{\texorpdfstring{\bfseries #4}{#4}}
    }
  }{%	if \chapter
    \IfNoValueTF{#2}
    {\hitsz@chapter{#3}}%
    {\hitsz@chapter[#2]{#3}}%
    \IfValueT{#4}{%
%    此处需删除章节的空白
      \addcontentsline{entoc}{chapter}{%
        \texorpdfstring{\bfseries\relax Chapter \thechapter\hspace{0.5em}\ignorespaces #4}{%
          Chapter \thechapter\hspace{0.5em}\ignorespaces #4}}
    }
  }
}
% ----- 双语Section
\let\hitsz@section\section
\RenewDocumentCommand\section{s o m o}{
  \IfBooleanTF{#1}{%	if \section*
    \hitsz@section*{#3}%
    \IfValueT{#4}
    {\addcontentsline{entoc}{section}{#4}}
  }{%	if \section
    \IfNoValueTF{#2}%
    {\hitsz@section{#3}}%
    {\hitsz@section[#2]{#3}}%
    \IfValueT{#4}{%
    % 此处需删除章节的空白
    \addcontentsline{entoc}{section}
    {\protect\numberline{\csname thesection\endcsname}\ignorespaces #4}
    }
  }
}
% ----- 双语Subsection
\let\hitsz@subsection\subsection
\RenewDocumentCommand\subsection{s o m o}{
  \IfBooleanTF{#1}{%	if \subsection*
    \hitsz@subsection*{#3}%
    \IfValueT{#4}{%
      \addcontentsline{entoc}{subsection}{#4}
    }
  }{%	if \subsection
    \IfNoValueTF{#2}%
    {\hitsz@subsection{#3}}%
    {\hitsz@subsection[#2]{#3}}%
    \IfValueT{#4}{%
    % 此处需删除章节的空白
    \addcontentsline{entoc}{subsection}{%
      \protect\numberline{\csname thesubsection\endcsname}\ignorespaces #4}
    }
  }
}


%===========================================================================%
%->> Authorization & Conclusion & Acknowledgement & Resume
%===========================================================================%
% 原创性申明
\newcommand{\authorization}{
  \chapter*{\hitsz@info@school \hitsz@cap@authorization}[\hitsz@cap@enauthorization]
  \@mkboth{\MakeUppercase\hitsz@info@school \hitsz@cap@authorization}{}%
  \vspace{20pt}
  {\bf\zihao{-3}\centering 学位论文原创性声明\par}
  \vspace{\baselineskip}
  \hitsz@txt@declare
  \vspace{1\baselineskip}
  \par\hspace{6em}
  \hitsz@txt@authorsign\hfill\hitsz@date@date\hitsz@date@datefill\par
  % 使用权限
  \vspace{48pt}
  {\bf\zihao{-3}\centering 学位论文使用权限\par}
  \vspace{\baselineskip}
  \hitsz@txt@usage
  \vspace{2\baselineskip}
  \par\hspace{6em}
  \hitsz@txt@authorsign\hfill\hitsz@date@date\hitsz@date@datefill
  \vspace{\baselineskip}
  \par\hspace{6em}
  导师签名：\hfill\hitsz@date@date\hitsz@date@datefill
}

% 结论
\newcommand{\conclusion}{
  \chapter*{\hitsz@cap@conclusion}[\hitsz@cap@enconclusion]
  \@mkboth{\MakeUppercase\hitsz@cap@conclusion}{}%
}

% 致谢
\newcommand{\acknowledgement}{
  \chapter*{\hitsz@cap@acknowledgement}[\hitsz@cap@enacknowledgement]
  \@mkboth{\MakeUppercase\hitsz@cap@acknowledgement}{}%
}

% 个人简历
\newcommand{\resume}{
  \chapter*{\hitsz@cap@resume}[\hitsz@cap@enresume]
  \@mkboth{\MakeUppercase\hitsz@cap@resume}{}%
}


%===========================================================================%
%->> Publicaton
%===========================================================================%
% 攻读博士学位期间发表的论文及其他成果
\newcommand{\publication}{%
  \chapter*{\hitsz@cap@publication}[\hitsz@cap@enpublication]
  \@mkboth{\MakeUppercase\hitsz@cap@publication}{}%
  % 修改标题格式
  \ctexset{%
    section={
      beforeskip={14bp plus 1.677267bp minus 1.157391bp},
      afterskip={14bp plus 1.677267bp minus 1.157391bp},
      format={\zihao{-4}\song\bfseries},
    }
  }
}


%===========================================================================%
%->> Bibliography ENV
%===========================================================================%
% 使用style/gbt7714宏包可默认选择unsrt文献格式
% \bibliographystyle{unsrt}
% 重定义参考文献命令
% 参考文献编号
% \renewcommand\@biblabel[1]{［#1］\hfill}
\renewcommand\@biblabel[1]{[#1]\hfill}
\renewenvironment{thebibliography}[1]{
  \ctexset{chapter/numbering=false}
  \chapter*{\hitsz@cap@ref}[\hitsz@cap@enref]%
  \@mkboth{\MakeUppercase\hitsz@cap@ref}{\MakeUppercase\hitsz@cap@ref}%

  \normalsize
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    % 当用中文括号［#1］时，序号一百以上的参考文献缩进出现问题。
    % 加上一定非空字符后长度正确(如下方的x)。原理未知。
    \settowidth\labelwidth{\@biblabel{#1}x}%
    \setlength{\labelsep}{0em}
    \setlength{\itemindent}{0pt}
    \setlength{\leftmargin}{\labelsep+\labelwidth}
    \addtolength{\itemsep}{-0.8em}
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy\frenchspacing
  \flushbottom
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
  }
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}


%===========================================================================%
%->> Appendix
%===========================================================================%
% 附录中的章节格式（标号但不记入目录）
% 标题计数器
\newcounter{appchapter}
\newcounter{appsection}
\setcounter{appchapter}{0}
\setcounter{appsection}{0}
% Chapter标题命令
\newcommand{\appchapter}[1]{
  \stepcounter{appchapter}
  \setcounter{appsection}{0}
  \vspace{12bp}
  \centerline{\heiti\zihao{-2}
    \makebox[1em][c]{\arabic{appchapter}}  #1
    \vspace{8bp}
    }
}
% Section标题命令
\newcommand{\appsection}[1]{
  \stepcounter{appsection}
  \vspace{8bp}\noindent\hspace{-6pt}
  {\heiti\zihao{-3}
    \makebox[2em][c]{\arabic{appchapter}. \arabic{appsection}}  #1
    \vspace{8bp}} \par
}


%===========================================================================%
%->> Equation ENV
%===========================================================================%
% ----- 修改公式编号
\renewcommand\theequation{%
  \ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}

% ----- 公式参数解释
% tabularx: P4
% http://mirrors.ibiblio.org/CTAN/macros/latex/required/tools/tabularx.pdf
\newenvironment{note}{
  \noindent\makebox[2em][l]{式中}%
  \tabularx{\textwidth-2em}[t]{r@{\;------\;}X}
}{\endtabularx
  \par\vspace{5pt}
}


%===========================================================================%
%->> Algorithm ENV
%===========================================================================%
\renewcommand{\algorithmcfname}{算法}
\SetAlgoLined\SetArgSty{}
\SetAlgoNlRelativeSize{-1.5}


%===========================================================================%
%->> Enumitem Settings
%===========================================================================%
% enumitem:
% http://www.texnia.com/archive/enumitem.pdf
% --- 正文中的排序列表
\newlist{listNormal}{enumerate}{3}
\setlist[listNormal]{
  font       = \normalsize,
  labelsep   = .6em,
  leftmargin = 0pt,
  itemindent = 3.4em,
  partopsep  = 0pt,
  topsep     = 0pt,
  itemsep    = 0pt,
  parsep     = 0pt,
}
\setlist[listNormal,1,2,3]{%
  label = \arabic*.,
  ref   = \arabic*,
}
% --- 正文中的排序列表
\newlist{listParentheses}{enumerate}{3}
\setlist[listParentheses]{
  font       = \normalsize,
  labelsep   = 0em,
  leftmargin = 0pt,
  itemindent = 4.6em,
  partopsep  = 0pt,
  topsep     = 0pt,
  itemsep    = 0pt,
  parsep     = 0pt,
}
\setlist[listParentheses,1,2,3]{%
  label = （\arabic*）,
  ref   = \arabic*,
}
% 发表论文及其他成果章节中的列表
\newlist{listSquare}{enumerate}{1}
\setlist[listSquare,1]{
  label = ［\arabic*］,
  ref = \arabic*,
  font=\normalsize,
  labelsep = .6em, 
  leftmargin = 38pt,
  itemindent = 0em,
  partopsep = 0pt, 
  topsep = 5pt, 
  itemsep = 5pt, 
  parsep = 0pt,
}


%===========================================================================%
%->> Floatting ENV
%===========================================================================%
% ----- 通用设置
% 每页文字占据的最小比例(默认0.2，即20%)
\renewcommand*{\textfraction}{0.05}
% 顶端和底端的浮动环境的最大比例，防止多个连续浮动体分页
 \renewcommand*{\topfraction}{0.9}
 \renewcommand*{\bottomfraction}{0.8}
% 浮动体单独放一页时占据的最小比例, 必须小于|\topfraction|
 \renewcommand*{\floatpagefraction}{0.85}

% 图表标题设置可参考：
% https://www.latexstudio.net/archives/8652.html
\DeclareCaptionFont{song}{\song}
\DeclareCaptionFont{wuhao}{\zihao{5}}

% 浮动体的间距控制
% 文本行之间的浮动体与上下文之间的间距
\setlength{\intextsep}{8.5bp \@plus 2.8bp \@minus 2bp}
% 版心顶部或底部浮动体之间的垂直距离
\setlength{\textfloatsep}{8.5bp \@plus 2.8bp \@minus 2bp}
\setlength{\floatsep}{12bp \@plus 2.8bp \@minus 4bp}

% Caption 间距
\setlength{\abovecaptionskip}{8pt}
\setlength{\belowcaptionskip}{8pt}

% ----- 图
% 如果图片没有指定后缀, 依次按下列顺序搜索
\DeclareGraphicsExtensions{.eps,.jpg,.png,.pdf}
% 设置图表搜索路径, 可以给图表文件夹取如下名字
\graphicspath{
  {content/}{content/pics/}{content/imgs/}{main/pics/}{main/imgs/}
}
\renewcommand*{\thefigure}{\thechapter-\arabic{figure}}
\renewcommand{\figurename}{图}
\captionsetup[figure]{%
	format=hang,   % 标题从第二行开始都有缩进, 应该和 justification=raggedright 的效果一样.
	labelsep=quad, % 分隔符是一个空格
	font={song,wuhao}, % 图的字体, 宋体小四
	position=bottom % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
}

% ----- 子图
\renewcommand*{\thesubfigure}{(\alph{subfigure})}
\captionsetup[subfigure]{%
  font={song,wuhao},
  labelformat=simple,
  % 单行图注不受影响
  singlelinecheck=true,
  % 缩进到编号之后
  format=hang,
  labelsep=space,
  % 左右边界缩进
  margin=10pt,
  position=bottom,
  captionskip=5pt,
  farskip=5pt,
}

% ----- 表格
\renewcommand{\tablename}{表}
\renewcommand*{\thetable}{\thechapter-\arabic{table}}
\captionsetup[table]{%
	format=hang,
  labelformat=simple,
	labelsep=quad,
	font={song,wuhao},
	position=bottom
}


%===========================================================================%
%->> Make Cover & Titlepage
%===========================================================================%
% Pkg: ulem
\renewcommand{\maketitle}{%
  \hitsz@pagestyle{fancy@empty}
  \ifhitsz@midterm
    \hitsz@maketitle@midterm
  \else{
    \hitsz@maketitle@cover
    \hitsz@maketitle@titlepage
    \hitsz@maketitle@entitlepage
  }
  \fi
}

% ----- 中期报告封面
\newdimen\infowidth
\infowidth = 190pt            % 下划线长度
\setlength{\ULdepth}{4pt}    % 下划线与文字之间的距离
\newcommand{\hitsz@cmd@uline}[1]{
  \uline{\makebox[\infowidth][l]{\hspace*{1em}{\textbf{#1}}}}
}

\newcommand{\hitsz@maketitle@midterm}{%
  \begin{center}
  \parbox[t][250pt][t]{\textwidth}{%
    \begin{center}
      \vspace{55pt}
      \makebox[150pt][s]{\zihao{-2}\kai\textbf{哈尔滨工业大学}}
      \par\vspace{37pt}
      \makebox[300pt][s]{\zihao{2}\song\textbf{硕士学位论文中期报告}}
      \par\vspace{30pt}\zihao{-2}\song
      \newlength{\titleLength} \settowidth{\titleLength}{\hitsz@info@titleA}
      \makebox[2.5em][s]{\textbf{题目}}\textbf:\hspace{6pt}
      \begin{minipage}[t]{\titleLength}{
        \textbf{\hitsz@info@titleA}\par
        \textbf{\hitsz@info@titleB}
      }\end{minipage}
    \end{center}
  }
  \end{center}
  
  \song\zihao{3}\hspace{5pt}
  \renewcommand{\arraystretch}{1.37} %表格间距
  \begin{tabular}{@{\song}r@{ }@{}l@{}}%
    \textbf{院\hfill{}\makebox[33pt][s]{（系）}} & \hitsz@cmd@uline{\hitsz@info@department} \\
     \textbf{学\hfill{}科} & \hitsz@cmd@uline{\hitsz@info@specialty} \\
     \textbf{导\hfill{}师} & \hitsz@cmd@uline{\hitsz@info@teacher} \\
     \textbf{研\hfill{}究\hfill{}生} & \hitsz@cmd@uline{\hitsz@info@author} \\
     \textbf{学\hfill{}号} & \hitsz@cmd@uline{\hitsz@info@studentid} \\
     \textbf{中期报告日期} & \hitsz@cmd@uline{\hitsz@info@defensedate} \\
  \end{tabular}
  \renewcommand{\arraystretch}{1} %表格间距
  \normalsize
}

% ----- 封面一
\newcommand{\hitsz@maketitle@cover}{
  \begin{center}
    % 论文信息
    \parbox[t][19.35cm][t]{\textwidth}{%
      \begin{center}
        \vspace{28pt}
        \zihao{-1}\song\bfseries 硕士学位论文\par
        \vspace{26pt}
        \zihao{-2}\song\bfseries （\hitsz@info@degreetype \hitsz@info@thesis）\par
        \vspace{35pt}
        \zihao{2}\song{\hitsz@info@titleA\par\hitsz@info@titleB}\par
        \vspace{42pt}
        \zihao{-2}\textbf{\hitsz@info@entitle}\par
        \vspace{54pt}
        \zihao{2}\song\textbf{\hitsz@info@author}\par
      \end{center}
    }

    % 学校名称
    \zihao{-2}\kai\textbf{\hitsz@info@school}\par
    % 日期
    \zihao{-2}\song\textbf{\hitsz@info@defensedate}
  \end{center}
  \if@openright\cleardoublepage\else\clearpage\fi
}

% ----- 封面二
\newcommand{\hitsz@maketitle@titlepage}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \begin{center}
    \parbox[t][4.0cm][t]{\textwidth}{%
        \setlength{\baselineskip}{16pt}  % 设置特殊行间距
        国内图书分类号： \hitsz@info@classification
        \hfill
        学校代码：\makebox[3em][l]{10213}
        \par
        国际图书分类号： \hitsz@info@enclassification
        \hfill
        密级：\makebox[3em][l]{公开}
    }

    % 标题
    \parbox[t][9.4cm][t]{\textwidth}{%
      \begin{center}
        \zihao{-2}\song\textbf{工学\hitsz@info@degree\hitsz@info@thesis}
        \par\vspace{42pt}
        \zihao{2}\heiti{\hitsz@info@titleA\par \hitsz@info@titleB}
      \end{center}
    }
  \end{center}
  
  % 论文信息
  \song\zihao{4}\hspace{50pt}
  \renewcommand{\arraystretch}{1.26} %表格间距
  \begin{tabular}{@{}r@{：}@{}l@{}}%
    \heiti 硕\hfill{}士\hfill{}研\hfill{}究\hfill{}生 & \hitsz@info@author \\
    \heiti 导\hfill{}师 & \hitsz@info@teacher  \\
    \heiti 申\hfill{}请\hfill{}学\hfill{}位 & 工学硕士 \\
    \heiti 学\hfill{}科 & \hitsz@info@specialty \\
    \heiti 所\hfill{}在\hfill{}单\hfill{}位 & \hitsz@info@school \hitsz@token@shenzhen \\
    \heiti 答\hfill{}辩\hfill{}日\hfill{}期 & \hitsz@info@defensedate \\
    \heiti 授予学位单位 & \hitsz@info@school \\
  \end{tabular}
  \renewcommand{\arraystretch}{1} %表格间距
  \normalsize
}


% ----- 封面三
% 表格内换行命令
\newcommand{\tabincell}[2]{\begin{tabular}[t]{@{}#1@{}}#2\end{tabular}}
\newcommand{\hitsz@maketitle@entitlepage}{
  % 设置单页版面，消除盒子警告
  \newgeometry{
    left=30true mm,
  }
  \if@openright\cleardoublepage\else\clearpage\fi
  \hspace{-24pt}
  \begin{minipage}[t]{10\ccwd}
    \zihao{-4}
    Classified Index: \hitsz@info@classification\\
    U.D.C: \hitsz@info@enclassification
  \end{minipage}

  \begin{center}
    \vspace{32pt}
    \parbox[t][11.2cm][t]{\textwidth}{%
      \begin{center}
        \renewcommand*{\baselinestretch}{1}% 行距设置
        \zihao{-2}{
          A dissertation submitted in partial fulfillment of\par
          the requirements for the academic degree of\par 
          Master of Engineering}\par
        % 标题
        \vspace{66pt}
        \zihao{2}\heiti\textbf{\hitsz@info@entitle}
      \end{center}
    }
    \zihao{4}\hspace{-40pt}
    \renewcommand{\arraystretch}{0.89} %表格间距
    \begin{tabular}{@{}l@{\hspace{1em}}p{235pt}@{}}%
      \bfseries Candidate: & \hitsz@info@enauthor \\
      \bfseries Supervisor: & \hitsz@info@enteacher \\
      \bfseries Academic Degree Applied for: & Master of Engineering \\
      \bfseries Specialty: & \hitsz@info@enspecialty\\
      \bfseries Affiliation: & \hitsz@info@enschool, Shenzhen \\
      \bfseries Data of Defense: & \hitsz@info@endefensedate \\
      \bfseries Degree-Conferring-Institution: & \hitsz@info@enschool \\
    \end{tabular}
    \renewcommand{\arraystretch}{1} %表格间距
  \end{center}
  % 恢复版面设置(中文摘要页的版面小于理论值)
  % \restoregeometry
}



\endinput

%%
%% End of file 'hitszthesis_master.cls'
