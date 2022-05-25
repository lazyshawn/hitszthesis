## ✨ ChangeLog
All notable changes to this project will be documented in this file (Since 2021.05.24).

<!-- The format is based on Keep a [Changelog](https://keepachangelog.com/en/1.0.0/). -->

## ✨ Logs
### 220525
> commit[](
)
1. `fix`: 修复字体bug。新增公式字体`\mathcal`、`\mathscr`。

### 
> commit []()

1. `fix`: 修复了中英文摘要右端未与页边框对齐的问题。
1. `chore`: 修改文档结构，将论文正文放入 `main` 文件夹，方便用户使用 `git` 管理
自己的论文内容。
1. `perf`: 为博士文档新增单双面打印的模板选项`openany/openright`。
1. `feat`: 新增公式宏包，支持空心体、手写体，并在`tutorial`中补充说明。
1. `perf`: 子浮动体垂直对齐问题。
1. `feat`: 新增检测模板版本的脚本命令。

### 210913
> commit [](
)

1. `fix`: 设置单元格内表格命令`\tabincell`顶端对齐，修复英文页面专业换行时垂
直居中对齐问题。
1. `revert`: 回滚了参考文献的宋体方括号。
1. `feat`: 博士论文新增列表环境的格式。
1. `chore`: 脚本新增删除文件夹下的过程文件。

### 210717
> commit [d671093](
https://github.com/lazyshawn/hitszthesis/commit/d67109363c390f1e878b04f09d7f0b7a822a38dc)

1. `fix`: 临时修复了硕士中文摘要页的版心变小的问题。

### 210625
> commit [8cbeb0b](
https://github.com/lazyshawn/hitszthesis/commit/8cbeb0b89c4d4e71a9271ab9bd902f9d3b1c8843)

1. `fix`: 子图图注格式修改: 单行文本居中，多行文本左右边界10pt，第二行开始缩进
到编号之后。

### 210610
> commit [ec601d0](
https://github.com/lazyshawn/hitszthesis/commit/ec601d04e81aafae2354148ec0c025871650c80d)

日常维护。
1. 完善说明文档。
1. 添加表格内换行命令 `\tabincell{}{}`。解决英文封面专业名称的换行问题。

### 210526
> commit [2e2d98c](
https://github.com/lazyshawn/hitszthesis/commit/2e2d98c44593a708cafe084d5b48034308130d7b)

日常维护。
1. 补充了说明文档。
1. 脚本修改为用 `latexmk` 编译。
1. 添加了行内引用命令 `\inlinecite{foo}`。


### 210524
> commit [2724dc3](
https://github.com/lazyshawn/hitszthesis/commit/2724dc38a52d08d6004452fb89a725092436e15a), [ba9bb24](
https://github.com/lazyshawn/hitszthesis/commit/ba9bb24fbc0630abaca8881610b13853ecd3fba0)

根据学校新模板修改部分格式。
1. 外封加上学位类型，区分学硕/专硕。
1. 添加图书分类号。
1. 修改部分封面拼写错误，部分章节标题修改。
1. 子图编号修改为圆括号，如图1-1 (a)。
1. 添加列表类型: 无括号有缩进。
1. 修改所有的方括号，包括列表、参考文献、取得的成果。
1. 修复了使用方括号列表后，**参考文献** 超过一百时会出现缩进错误的问题。

