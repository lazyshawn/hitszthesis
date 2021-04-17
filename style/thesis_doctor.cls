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
\ProvidesClass{style/thesis_doctor}[
  2020/03/30 v1.0
  My custom class for master thesis.
]


%===========================================================================%
%->> Condition
%===========================================================================%
\newif\ifhitsz@midterm\hitsz@midtermfalse


%===========================================================================%
%->> Declare Options
%===========================================================================%
\PassOptionsToClass{openany}{book}%
\PassOptionsToClass{twoside}{book}%
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
% class cfg loaded after package to make preamble commands take effect
\AtEndOfPackage{
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
\RequirePackage{booktabs}   % 表格线宏包
\RequirePackage{pdfpages}   % 插入PDF页面
\RequirePackage{amsmath}    % 数学公式
\RequirePackage{tabularx}   % 表格自动列宽
\RequirePackage{tikzpagenodes}  % 页边框
\RequirePackage{tikz}       % 绘图宏包
\usetikzlibrary{calc}       % tikz计算宏包


% ----- 字体设置(宏包顺序可能导致字体问题)
\PassOptionsToPackage{quiet}{xeCJK}
% heading选项用以启用章节标题的格式设置功能
\RequirePackage[UTF8,heading]{ctex}
\RequirePackage[OT1]{fontenc}
\RequirePackage{fontspec}
\RequirePackage{xpatch}
\RequirePackage{mathptmx}   % 使用Times new romans


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
  \geometry{
    text={144true mm,238.8true mm},
    top=27.8true mm,
    left=33true mm,
    head=0true mm,
    headsep=0true mm,
    footskip=12.6true mm,
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
%->> Font Settings
%===========================================================================%
% ----- 基础字族
\setsansfont{Arial}   % 西文默认无衬线字体(sans serif)
\setCJKfamilyfont{kai}[AutoFakeBold]{KaiTi}
\newcommand*{\kai}{\CJKfamily{kai}}
\setCJKfamilyfont{song}[AutoFakeBold]{SimSun}
\newcommand*{\song}{\CJKfamily{song}}
\setCJKmainfont[BoldFont={SimHei}, ItalicFont={KaiTi}, BoldItalicFont={SimSun}]{SimSun}
% \setCJKfamilyfont{xinwei}[AutoFakeBold]{stxinwei.ttf}
% \newcommand*{\xinwei}{\CJKfamily{xinwei}}


% ----- 字号设置
% 常规字号
\renewcommand\normalsize{%
	\@setfontsize\normalsize{12.05}{14.45}%
	\abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
	\abovedisplayshortskip \z@ \@plus3\p@
	\belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@}

\setlength\parindent{2em}   % 每行缩进两个汉字
\renewcommand*{\baselinestretch}{1.38}% 行距设置
\ziju{0.076} % 调整汉字间距


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
  % \setcounter{secnumdepth}{-1}
  \ifhitsz@midterm
    \hitsz@pagestyle{fancy@plain}
    \hitsz@maketitle@note
    \pagenumbering{arabic}
  \else
    \hitsz@pagestyle{fancy@front}
    \pagenumbering{Roman}
  \fi
  \ctexset{chapter/numbering=false}
}

% ----- Main Domain
% 开启章节序号计数，重置页码，页码使用阿拉伯数字;
\renewcommand\mainmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \ifhitsz@midterm
    % 页面边框
    \AddToShipoutPicture{%
      \begin{tikzpicture}[remember picture,overlay]
        \draw ($(current page text area.south west)+(-5mm,-5mm)$) 
          rectangle ($(current page text area.north east)+(5mm,2mm)$);
      \end{tikzpicture}
    }
  \else
    \hitsz@pagestyle{fancy@main}
    \pagenumbering{arabic}
  \fi
  \setcounter{secnumdepth}{3}
  \ctexset{
    chapter/number=\arabic{chapter},
    chapter/numbering=true,
  }
}

% ----- Appendix
% 重置章节序号计数， 章节序号使用字母，对页码没有影响；
\let\hitsz@appendix\appendix
\renewcommand{\appendix}{%
  \ctexset{%
    chapter/name={\hitsz@cap@appendix},
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
  \renewcommand{\headrule}{%
  \hrule width\headwidth height2.276pt \vspace{1pt}\hrule width\headwidth}
  \setlength{\headheight}{20pt}
}
\fancypagestyle{fancy@contents}{\fancyhf{}%
  \fancyfoot[C]{\song\zihao{-5} -~\thepage~-}
  \fancyhead[OC]{\song\zihao{-5} \hitsz@cap@contents}
  \fancyhead[EC]{\song\zihao{-5} \hitsz@cap@encontents}
  \renewcommand{\headrule}{%
  \hrule width\headwidth height2.276pt \vspace{1pt}\hrule width\headwidth}
  \setlength{\headheight}{20pt}
}

% ----- 正文区格式
\fancypagestyle{fancy@main}{\fancyhf{}%
  \fancyfoot[C]{\zihao{5} -~\thepage~-}
  \fancyhead[EC]{\song\zihao{-5}\hitsz@info@school 工学\hitsz@info@doctorthesis}
  \fancyhead[OC]{\song\zihao{-5}\leftmark}
  % 双页眉线
  \renewcommand{\headrule}{%
  \hrule width\headwidth height2.276pt \vspace{1pt}\hrule width\headwidth}
  \setlength{\headheight}{20pt}
}

% ----- 修改 pagestyle
\newcommand{\hitsz@pagestyle}[1]{%
  % 文类book将每一新章另起一页，该页的默认版式为plain
  \ctexset{chapter/pagestyle=#1}
  \pagestyle{#1}
}

% ----- 特殊页眉的章节
\def\hitsz@fancy@abstract{fancy@abstract}
\def\hitsz@fancy@enabstract{fancy@enabstract}
% 不编号但是计入目录的章节
\newcommand{\mkChapter}{
  \ctexset{chapter/numbering=false}
  \setcounter{section}{0}
}
% 生成特殊页眉的章节命令
\newcommand{\fancyChapter}[1]{
  \if@openright\cleardoublepage\else\clearpage\fi
  % 定义页眉
  \fancypagestyle{\csname hitsz@fancy@#1\endcsname}{\fancyhf{}%
    \fancyfoot[C]{\song\zihao{-5} -~\thepage~-}
    \fancyhead[EC]{\song\zihao{-5} \csname hitsz@cap@#1\endcsname}
    \fancyhead[OC]{\song\zihao{-5} \csname hitsz@cap@#1\endcsname}
    \renewcommand{\headrule}{%
    \hrule width\headwidth height2.276pt \vspace{1pt}\hrule width\headwidth}
    \setlength{\headheight}{20pt}
  }
  % 页面格式
  \mkChapter
  \hitsz@pagestyle{\csname hitsz@fancy@#1\endcsname}
  % \chapter*{\csname hitsz@cap@#1\endcsname}[\csname hitsz@entoc@#1\endcsname]
}


%===========================================================================%
%->> Title and Caption
%===========================================================================%
% Pkg: [heading]ctex
\ifhitsz@midterm
\ctexset{%
  chapter={
    name={第,章},
    afterindent=true,
    beforeskip={18.74658bp},%一个空行 1.57481 × 18
    afterskip={24.74658bp},%0.8应该不计算间距 0.8 × 18 + 0.57481×18
    aftername=\enspace,
    format={\centering\heiti\zihao{-2}},
    numberformat=\normalfont,
    fixskip=true, % 添加这一行去除默认间距
  },
  section={
    name={,.},
    beforeskip={10bp plus 1.677267bp minus 1.157391bp}, % 原为13.5bp
    afterskip={10bp plus 1.677267bp minus 1.157391bp},
    format={\zihao{-4}},
    aftername=\enspace,
    fixskip=true,
  },
  subsection={
    name={,.},
    beforeskip={10bp \@plus 1.842609bp \@minus 0.9920497bp}, % 原为11bp
    afterskip={10bp \@plus 2.33863bp \@minus 0.49602bp},
    format={\zihao{-4}},
    aftername=\enspace,
    fixskip=true,
  },
  subsubsection={
    name={,.},
    beforeskip={10bp \@plus 1.842609bp \@minus 0.9920497bp}, % 原为11bp
    afterskip={10bp \@plus 2.33863bp \@minus 0.49602bp},
    format={\zihao{-4}},
    aftername=\enspace,
    fixskip=true,
}}\else
\ctexset{%
  chapter={
    name={第,章},
    afterindent=true,
    beforeskip={18.74658bp},%一个空行 1.57481 × 18
    afterskip={24.74658bp},%0.8应该不计算间距 0.8 × 18 + 0.57481×18
    aftername=\enspace,
    format={\centering\heiti\zihao{-2}},
    numberformat=\normalfont,
    % nameformat=\bfseries,
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
}}\fi

\ifhitsz@midterm
  % section 序号
  \renewcommand*{\thesection}{\arabic{section}}
  % 定义subsubsubsection
  \newcounter{subsubsubsection}
  \setcounter{subsubsubsection}{0}
  \renewcommand{\thesubsubsubsection}{
    \thesubsubsection .\arabic{subsubsubsection}
  }
  \newcommand{\subsubsubsection}[1]{
    \stepcounter{subsubsubsection}
    \noindent\makebox[3.4em][l]{\thesubsubsubsection.}
    \zihao{-4}\song #1 \par
  }
\fi


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
  \par\vspace{\baselineskip}
  \noindent\makebox[4em][l]{\zihao{-4}\hitsz@cap@keywords}%
  \begin{minipage}[t]{120mm}
    \hitsz@token@keywords
  \end{minipage}
}

% ----- 英文摘要
\newcommand{\enabstract}{
  \chapter*{\hitsz@cap@enabstract}[\hitsz@entoc@enabstract]
  \@mkboth{\hitsz@cap@enabstract}{\hitsz@cap@enabstract}%
}
\newcommand\enkeyword[1]{%
  \renewcommand{\hitsz@token@enkeywords}{#1}
  \par\vspace{\baselineskip}
  \noindent\makebox[5em][l]{\zihao{-4}\hitsz@cap@enkeywords}%
  \begin{minipage}[t]{120mm}
    \hitsz@token@enkeywords
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

\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth > \m@ne \relax
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{4em} % 序号盒子宽度 (第n章)
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
  \chapter*{\bfseries\hitsz@cap@encontents}
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
    \IfNoValueTF{#4}{% if english caption
      \hitsz@chapter*{#3}
    }{\hitsz@chapter*{#3}
      % 此处可以添加条目在目录的格式
      \addcontentsline{toc}{chapter}{\texorpdfstring{#3}{#3}}
      \addcontentsline{entoc}{chapter}{\texorpdfstring{\bfseries #4}{#4}}
    }
  }{\IfNoValueTF{#2}%	if \chapter
    {\ifhitsz@midterm\else\hitsz@chapter{#3}\fi}%
    {\hitsz@chapter[#2]{#3}}%

    \IfValueT{#4}{% if english caption
      % 此处需删除章节的空白
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
    {\ifhitsz@midterm
    \noindent\tikz[overlay] \draw (-5mm,5.5mm) -- (\textwidth+5mm,5.5mm);
    \setcounter{subsubsubsection}{0}
    \setcounter{figure}{0}
    \setcounter{table}{0}
    \vspace{-20pt}
    \fi
    \hitsz@section{#3}
    }%
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
    \addcontentsline{toe}{subsection}{%
      \protect\numberline{\csname thesubsection\endcsname}\ignorespaces #4}
    }
  }
}
% ----- 双语Subsubsection
\let\hitsz@subsubsection\subsubsection
\RenewDocumentCommand\subsubsection{s o m o}{
  \IfBooleanTF{#1}{%	if \subsection*
    \hitsz@subsection*{#3}%
    \setcounter{subsubsubsection}{0}
    \IfValueT{#4}{%
      \addcontentsline{entoc}{subsubsection}{#4}
      \setcounter{subsubsubsection}{0}
    }
  }{%	if \subsection
    \IfNoValueTF{#2}%
    {\hitsz@subsubsection{#3}
     \setcounter{subsubsubsection}{0}}%
    {\hitsz@subsubsection[#2]{#3}
     \setcounter{subsubsubsection}{0}}%
    \IfValueT{#4}{%
    % 此处需删除章节的空白
    \addcontentsline{toe}{subsubsection}{%
      \protect\numberline{\csname thesubsubsection\endcsname}\ignorespaces #4}
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
\renewenvironment{thebibliography}[1]{
  \ctexset{chapter/numbering=false}
  \chapter*{\hitsz@cap@ref}[\hitsz@cap@enref]%
  \@mkboth{\MakeUppercase\hitsz@cap@ref}{\MakeUppercase\hitsz@cap@ref}%

  \normalsize
  \list{\@biblabel{\@arabic\c@enumiv}}%
   {\settowidth\labelwidth{\@biblabel{#1}}%
    \setlength{\labelsep}{0.5em}
    \setlength{\itemindent}{0pt}
    \setlength{\leftmargin}{\labelsep+\labelwidth}
    \addtolength{\itemsep}{-0.8em}
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
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
%->> Enumitem Settings
%===========================================================================%
% enumitem:
% http://www.texnia.com/archive/enumitem.pdf
% --- 正文中的排序列表
\newlist{listNormal}{enumerate}{3}
\setlist[listNormal]{
  font       = \normalsize,
  labelsep   = .5em,
  leftmargin = 0pt,
  itemindent = 3em,
  partopsep  = 0pt,
  topsep     = 0pt,
  itemsep    = 0pt,
  parsep     = 0pt,
}
\setlist[listNormal,1,2,3]{%
  label = (\arabic*),
  ref   = \arabic*,
}
% 发表论文及其他成果章节中的列表
\newlist{listSquare}{enumerate}{1}
\setlist[listSquare,1]{
  label = [\arabic*],
  ref = \arabic*,
  font=\normalsize,
  labelsep = 1.2em, 
  leftmargin = 28.5pt,
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

% 图表序号
\ifhitsz@midterm
  \renewcommand*{\thefigure}{\thesection-\arabic{figure}}
  \renewcommand*{\thetable}{\thesection-\arabic{table}}
\else
  \renewcommand*{\thefigure}{\thechapter-\arabic{figure}}
  \renewcommand*{\thetable}{\thechapter-\arabic{table}}
\fi

% ----- 图
% 如果图片没有指定后缀, 依次按下列顺序搜索
\DeclareGraphicsExtensions{.eps,.jpg,.png,.pdf}
% 设置图表搜索路径, 可以给图表文件夹取如下名字
\graphicspath{
  {contents/}{pics/}{imgs/}{main/pics/}
  {front/pics/}{appendices/pics/}{back/pics/}
}
% 图标题
\renewcommand{\figurename}{图}
\newcommand{\figCaption}[3]{%
  \vspace{-6pt}
  \renewcommand{\figurename}{图}
  \caption{#2\label{#1}}
  \vspace{-20pt}
  \addtocounter{figure}{-1}
  \renewcommand{\figurename}{Fig}
  \caption{#3}
}
\captionsetup[figure]{%
  % 标题从第二行开始都有缩进, 应该和 justification=raggedright 的效果一样.
  % format=hang,
  labelsep=quad, % 分隔符是一个空格
  font={song,wuhao}, % 图的字体, 宋体小四
  % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
  position=bottom
}

% ----- 子图
\renewcommand*{\thesubfigure}{\ \alph{subfigure})}
\captionsetup[subfigure]{%
  % format=hang,
  labelformat=simple,
  labelsep=space,
  font={song,wuhao},
  position=bottom,
  margin=34pt,
  hangindent=10pt,
  indention=20pt,
  singlelinecheck=false,
}

% ----- 表格
% 表格标题
\renewcommand{\tablename}{表}
\newcommand{\tabCaption}[3]{%
  \renewcommand{\figurename}{表}
  \caption{#2\label{#1}}
  \vspace{-20pt}
  \addtocounter{table}{-1}
  \renewcommand{\tablename}{Table}
  \caption{#3}
  \vspace{-8pt}
}
\captionsetup[table]{%
  % format=hang,
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
  \else
    \hitsz@maketitle@cover
    \hitsz@maketitle@titlepage
    \hitsz@maketitle@entitlepage
    \mbox{}
  \fi
}

% 下划线
\ULdepth=11.5pt
\newcommand{\hitsz@cmd@duuline}[2]{
  \uline{\zihao{4}\song
    \makebox[89pt][s]{\textbf{#1}}
    \makebox[250pt][l]{\zihao{4}\hspace*{1em}{\textbf{#2}}}
  }
  \par\vspace{11.6pt}
}

% ----- 中期报告封面
\newcommand{\hitsz@maketitle@midterm}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \begin{center}
    \parbox[t][6.13cm][t]{\textwidth}{%
      \centering\vspace{65pt}
      \zihao{2}\song
      \makebox[11em][s]{\textbf{\hitsz@info@school \hitsz@token@shenzhen}}\par
      \vspace{-6pt}
      \makebox[15em][s]{\textbf{\hitsz@info@doctorthesis 中期检查报告}}\par
    }

    \vspace{50pt}
    \hitsz@cmd@duuline{研究生}{\hitsz@info@author}
    \hitsz@cmd@duuline{入学时间}{\hitsz@info@enrollment}
    \hitsz@cmd@duuline{论文题目}{\hitsz@info@titleA}
    \hitsz@cmd@duuline{}{\hitsz@info@titleB}
    \hitsz@cmd@duuline{学科专业}{\hitsz@info@speciality}
    \hitsz@cmd@duuline{中期报告时间}{\hitsz@info@defensedate}
    \hitsz@cmd@duuline{导师}{\hitsz@info@teacher}
  \end{center}
}

\newcommand{\hitsz@cmd@dubox}[2]{
  \makebox[17pt][l]{\zihao{4}#1} 
  \zihao{4}\renewcommand{\CJKglue}{\hskip 0.03mm plus 0.10\baselineskip}#2
}
% ----- 说明
\newcommand{\hitsz@maketitle@note}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \begin{center}
    \parbox[t][138pt][t]{\textwidth}{%
      \centering\song\zihao{3}\vspace{75pt}
      \textbf{说\hspace{2\ccwd}明}
    }
    \song\zihao{4}
    \renewcommand{\arraystretch}{1.35} %表格间距
    \begin{tabular}{@{\hspace{-3pt}}l@{}}%
      \hitsz@cmd@dubox{1.}{博士研究生学位论文中期报告一般在入学后的第五学期末完成。} \\
      \hitsz@cmd@dubox{2.}{此报告由学生本人填写，请导师签字后提交一份给检查小组。答} \\
      \hitsz@cmd@dubox{\hfill{}}{辩结束后由检查组长签署意见。} \\
      \hitsz@cmd@dubox{3.}{报告经中期报告检查组长签字同意后，由学科部保存，以备论文} \\
      \hitsz@cmd@dubox{\hfill{}}{答辩时参考。研究生院学生培养处将对研究生的学位论文中期报} \\
      \hitsz@cmd@dubox{\hfill{}}{告进行抽查。} \\
      \hitsz@cmd@dubox{4.}{报告统一用A4纸打印。}
    \end{tabular}
    \renewcommand{\arraystretch}{1} %表格间距
  \end{center}
  % 恢复版面设置
  % \restoregeometry
}

% ----- 封面一
\newcommand{\hitsz@maketitle@cover}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \begin{center}
    % 论文信息
    \parbox[t][18.75cm][t]{\textwidth}{%
      \begin{center}
        \vspace{16pt}
        \zihao{-1}{\song\bfseries\hitsz@info@doctorthesis}\par
        \vspace{44pt}
        \zihao{2}{\heiti\hitsz@info@titleA}\par
        \zihao{2}{\heiti\hitsz@info@titleB}\par
        \vspace{42pt}
        \zihao{2}\textbf{\hitsz@info@entitle}\par
        \vspace{42pt}
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
        国内图书分类号：
        \hfill
        学校代码：\makebox[3em][l]{10213}
        \par
        国际图书分类号：
        \hfill
        密级：\makebox[3em][l]{公开}
    }

    % 标题
    \parbox[t][255pt][t]{\textwidth}{%
      \begin{center}
        \zihao{-2}\song\textbf{工学\hitsz@info@doctorthesis}
        \par\vspace{42pt}
        \zihao{2}\heiti\hitsz@info@titleA\par
        \hitsz@info@titleB
      \end{center}
    }
  \end{center}
  
  % 论文信息
  \song\zihao{4}\hspace{50pt}
  \renewcommand{\arraystretch}{1.26} %表格间距
  \begin{tabular}{@{}r@{：}@{}l@{}}%
    \heiti 博\hfill{}士\hfill{}研\hfill{}究\hfill{}生 & \hitsz@info@author \\
    \heiti 导\hfill{}师 & \hitsz@info@teacher \\
    \heiti 申\hfill{}请\hfill{}学\hfill{}位 & 工学硕士 \\
    \heiti 学\hfill{}科 & \hitsz@info@speciality \\
    \heiti 所\hfill{}在\hfill{}单\hfill{}位 & \hitsz@info@school \hitsz@token@shenzhen \\
    \heiti 答\hfill{}辩\hfill{}日\hfill{}期 & \hitsz@info@defensedate \\
    \heiti 授予学位单位 & \hitsz@info@school \\
  \end{tabular}
  \renewcommand{\arraystretch}{1} %表格间距
  \normalsize
}


% ----- 封面三
\newcommand{\hitsz@maketitle@entitlepage}{
  % 设置单页版面，消除盒子警告
  \newgeometry{left=30true mm}
  \if@openright\cleardoublepage\else\clearpage\fi
  \hspace{-24pt}
  \begin{minipage}[t]{10\ccwd}
    \zihao{-4}
    Classified Index: \\
    U.D.C: 
  \end{minipage}

  \begin{center}
    \vspace{32pt}
    \parbox[t][323pt][t]{\textwidth}{%
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
    \renewcommand{\arraystretch}{0.88} %表格间距
    \begin{tabular}{@{}l@{\hspace{1em}}l@{}}%
      \bfseries Candidate: & \hitsz@info@enauthor \\
      \bfseries Supervisor: & \hitsz@info@enteacher \\
      \bfseries Academic Degree Applied for: & Master of Engineering \\
      \bfseries Speciality: & Mechanical Manufacturing and \\
                            & Automation \\
      \bfseries Affiliation: & \hitsz@info@enschool, Shenzhen \\
      \bfseries Data of Defence: & \hitsz@info@endefensedate \\
      \bfseries Degree-Conferring-Institution: & \hitsz@info@enschool \\
    \end{tabular}
    \renewcommand{\arraystretch}{1} %表格间距
  \end{center}
  % 恢复版面设置
  \restoregeometry
}


%===========================================================================%
%->> Review Table
%===========================================================================%
\newcommand{\reviewPage}{
  \if@openright\hitsz@clearemptydoublepage\else\clearpage\fi
  \hspace{-37pt} 指导教师意见：\par
  \vspace{180pt}\hspace{191.5pt} 指导教师签名：\par
  \vspace{26pt}\hspace{251pt}
  \hitsz@date@datefill\par
  \vspace{30pt}
  \noindent\tikz[overlay] \draw (-5mm,5.5mm) -- (\textwidth+5mm,5.5mm);
  \hspace{-14pt} 检查小组意见：\par
  \vspace{227.5pt}\hspace{230pt}组长（签字）：\par
  \vspace{26pt}\hspace{251pt}
  \hitsz@date@datefill\par
}


\endinput

