1. [✨ 注意事项](#✨-注意事项)
1. [✨ 模板内定义的通用命令](#✨-模板内定义的通用命令)
    * [模板的引用](#模板的引用)
    * [字体设置命令](#字体设置命令)
    * [个人信息的填写](#个人信息的填写)
    * [特殊章节的声明](#特殊章节的声明)
    * [浮动体环境中的常用命令](#浮动体环境中的常用命令)
    * [章节命令的重载](#章节命令的重载)
    * [引用](#引用)
1. [✨ 用户自定义命令和引用其他宏包](#✨-用户自定义命令和引用其他宏包)


## ✨ 注意事项
1. 绝大部分命令在 demo 中都有使用案例，如有描述不准之处请结合 demo 理解。

1. 需要注意的是在博士论文中期模板中，章节命令从 `\section` 开始，
并且 `\section` 命令会自动在小节前添加分节线。

1. 如果出现某页面空白过大，基本是由连续的浮动体环境导致的，
可以通过适量增加或删减文章内容调整空白；或者通过人为调整浮动体位置解决。

1. 使用模板的过程中如有任何疑问，欢迎提交
[Issues](https://github.com/lazyshawn/hitszthesis/issues) 。

## ✨ 模板内定义的通用命令
> **Remark:** 大部分命令在demo中都有使用案例，如有描述不准之处请结合demo理解。

### 模板的引用
目前模板支持哈工大（深圳）的硕士、博士的中期和毕设的格式。
在你的 `main.tex` 文件的导言区（即\begin{document}之前）通过下面命令引用该模板。
引用模板之后方可正常使用后文定义的命令。
```tex
\documentclass[option]{style/<thesis>}
```
其中`[option]`为可选参数，不填默认使用毕设格式，选`midterm`为中期格式。
`<thesis>`为对应的学位，硕士选`thesis_master`，博士选`thesis_doctor`。

### 字体设置命令
注意在 **Linux 系统下** 需要安装相应的字体。把 Windows 下的字体 ( C:\Windows\Fonts ) 
拷贝到 Linux 下并更新字体库即可。详情请自行百度或参考
[lazyshawn/config](https://github.com/lazyshawn/config/blob/master/TODOs.md#字体配置)。

| 命令    | 功能               |
| ---     | ---                |
| `\kai`  | 设置字体格式为楷书 |
| `\song` | 设置字体格式为宋书 |


### 个人信息的填写
这些是用于填写封面上个人信息的命令，参数不填默认为空。

| 命令                  | 功能                           |
| ---                   | ---                            |
| `\zhtitle{}{}`        | 论文中文标题, {第一行}{第二行} |
| `\entitle`            | 论文英文标题                   |
| `\autor{}{}`          | 作者姓名, {中文名}{英文名}     |
| `\studentid`          | 学号                           |
| `\teacher`            | 导师名称, {中文名}{英文名}     |
| `\department`         | 学院名称                       |
| `\speciality{}{}`     | 专业名称, {中文名}{英文名}     |
| `\enrollment`         | 入学时间                       |
| `\defensedate{}{}`    | 答辩时间, {中文}{英文}         |
| `\classification{}{}` | 图书分类号, {国内}{国际}       |
| `\degreetype`         | 专业类型(学硕/专硕)            |



### 特殊章节的声明
这些章节 (chapter) 通常是没有编号但是需要添加到目录中的章节，
或有固定格式和内容的章节等，
如中英文摘要、原创性声明、参考文献等。

| 命令                 | 功能           |
| ---                  | ---            |
| `\abstract`          | 中文参考文献   |
| `\enabstract`        | 英文参考文献   |
| `\conclusion`        | 结论           |
| `\tableofencontents` | 英文目录       |
| `\authorization`     | 原创性声明     |
| `\acknowledgement`   | 致谢           |
| `\resume`            | 个人简历       |
| `\publication`       | 发表论文及成果 |


### 浮动体环境中的常用命令
1. 公式  

在插入行间公式后，本模板定义了用于解释公式参数的环境 (note)。
环境中用`&`分隔参数与释义，用`\\`换行和区分各条目。
```tex
% Equation
$$ function(a,b) $$
% Note
\begin{note}
  $a$ & description for a； \\
  $b$ & description for b； \\
\end{note}
```

2. 图表

在 demo 中有子图的设置例程。
```tex
% 双语图名
\figCaption{label}{Chinese caption}{English caption}
% 双语表名
\tabCaption{label}{Chinese caption}{English caption}
```

表格内需要换行可以使用 `\tabincell{<align>}{<subtab>}` 命令。其中 `<align>` 为
对齐方式，`<subtab>` 为单元格内的内容，以 `\\` 换行。在填写封面内的个人信息时可
能会用到。
```tex
% Break line in a table.
\tabincell{l}{foo \\ bar}
```


3. 列表

本模板预定义了若干列表格式。可通过特定的环境调用不同格式的列表。
```tex
\begin{<list_env>}
  \item foo
  \item bar
\end{<list_env>}
```
其中`<list_env>`提供了如下选项：  

`listNormal`: 正文中的列表选项。
无括号、小数点分隔、阿拉伯数字序号，列表第二行开始无缩进。  
`listSquare`: 发表论文与研究成果中的列表选项。
方括号、阿拉伯数字序号，列表内容缩进到编号右侧且对齐。  
`listParenthesis`: 正文中的列表选项。
圆括号、阿拉伯数字序号，列表第二行开始无缩进。  


4. 伪代码(待补充)

### 章节命令的重载
命令`\chapter`,`\section`,`\subsection`添加了新的可选参数。
```tex
\chapter*[name_in_toc]{name}[en_name]
```
其中星号和方括号内为可选参数，花括号内为必选参数。  

`*`: 不编号且不列入目录的章节，如果有英文标题则会将标题不编号列入目录；  
`name_in_toc`: 章节在目录中的名称;  
`name`: 正文中的章节名称;  
`en_name`: 章节在英文目录中的名称。  

### 引用
使用命令`\cite{foo}`进行上标引用，使用命令`\inlinecite{bar}`添加行内引用。


## ✨ 用户自定义命令和引用其他宏包
> 为便于模板的更新和使用的方便，请谨慎修改本模板的源文件，即[该项目的所有文件](
https://github.com/lazyshawn/hitszthesis)。

用户自定义命令和额外的宏包请在 **导言区** ( \begin{document} 之前) 声明，而不要
修改模板的源文件。

本模板已经尽量减少了命令冲突的问题，只定义了少量新命令，也尽可能实现了可能需要
的排版方式，有需要的用户可酌情修改。对于宏包问题，本模板只使用了必要的宏包，如
需使用其他宏包，请自行添加。

