[toc]

## § 模板内定义的通用命令
> 大部分命令在demo中都有使用案例，如有描述不准之处请结合demo理解。

### 模板的引用
目前模板支持哈工大（深圳）的硕士、博士的中期和毕设的格式。
在你的`main.tex`文件的导言区（即\begin{document}之前）通过下面命令引用该模板：
```
\documentclass[option]{style/<thesis>}
```
其中`[option]`为可选参数，不填默认使用毕设格式，
选`midterm`为中期格式。

### 字体设置命令
注意在 Ubuntu 系统下需要安装相应的字体。

| 命令    | 功能               |
| ---     | ---                |
| `\kai`  | 设置字体格式为楷书 |
| `\song` | 设置字体格式为宋书 |
| `\xinwei` | 设置字体格式为华文新魏 |


### 个人信息填写
这些是用于填写个人信息的命令，参数不填默认为空。

| 命令               | 功能                           |
| ---                | ---                            |
| `\zhtitle{}{}`     | 论文中文标题, {第一行}{第二行} |
| `\entitle`         | 论文英文标题                   |
| `\autor{}{}`       | 作者姓名, {中文名}{英文名}     |
| `\studentid`       | 学号                           |
| `\teacher`         | 导师名称, {中文名}{英文名}     |
| `\department`      | 学院名称                       |
| `\speciality`      | 专业名称                       |
| `\enrollment`      | 入学时间                       |
| `\defensedate{}{}` | 答辩时间, {中文}{英文}         |



### 论文特殊章节标题

这些章节 (chapter) 通常是没有编号但是需要添加到目录中的章节，
如中英文摘要、原创性声明、参考文献等。

| 命令                 | 功能         |
| ---                  | ---          |
| `\abstract`          | 中文参考文献 |
| `\enabstract`        | 英文参考文献 |
| `\conclusion`        | 结论         |
| `\tableofencontents` | 英文目录     |
| `\authorization`     | 原创性声明   |
| `\acknowledgement`   | 致谢         |
| `\resume`            | 个人简历     |
| `\publication`       | 发表论文及成果  |


### 浮动体环境中的常用命令
1. 公式  

在插入行间公式后，本模板定义了用于解释公式参数的环境 (note)。
```tex
% Equation
$$ foo $$
% Note
\begin{note}
  \para{$a$}{description for a}
  \para{$b$}{description for b}
\end{note}
```

2. 图  

demo 中有子图的设置例程。
```tex
% 双语图名
\figCaption{label}{Chinese caption}{English caption}
```

3. 表
```tex
% 双语表名
\tabCaption{label}{Chinese caption}{English caption}
```

4. 列表(待补充)

本模板预定义了若干列表格式。可通过以下格式调用相应格式的列表环境。
```tex
\begin{enumerate}
  \item foo
  \item bar
\end{enumerate}
```

5. 伪代码(待补充)

### 章节命令的重载
命令`\chapter`,`\section`,`\subsection`添加了新的可选参数。
```tex
\chapter*[name_in_toc]{name}[en_name]
```
其中星号和方括号内为可选参数，花括号内为必选参数。  

\*: 不编号且不列入目录的章节，如果有英文标题则会将标题不编号列入目录；
name\_in\_toc: 章节在目录中的名称;  
name: 正文中的章节名称;  
en\_name: 章节在英文目录中的名称。  

## § 注意事项
1. 需要注意的是在博士论文中期模板中，章节命令从`\section`开始，
并且`\section`命令会自动在小节前添加分节线。

1. 如果出现某页面空白过大，基本是由连续的浮动体环境导致的，
可以通过适量增加或删减文章内容调整空白；或者通过调整浮动体位置解决。


