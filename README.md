
## What is this
This project is a dissertation template for masters 
in Harbin Institute of Technology, ShenZhen (HITSZ).

You can check the demo at [pics/demo\_x.png](
https://github.com/lazyshawn/hitszthesis_master/tree/master/pics).

## Documentation
Here is the structure of this project:
```git
├─ style
│  ├─ gbt7714.dtx             % 参考文献格式(.dtx)
│  ├─ gbt7714.bst             % 参考文献格式
│  ├─ gbt7714.sty             % 参考文献格式宏包
│  ├─ hitszthesis_master.cls  % 文档类
│  └─ hitszthesis_master.cfg  % 文档类常量设置
│
├─ pics                       % 存放图片
│  └─ ...                     
│
├─ appendix                   % 附录
│  └─ ...                     
│
├─ main
│  ├─ abstract.tex            % 摘要
│  ├─ introduction.tex        % 绪论
│  ├─ demo.tex                    
│  ├─ ...                     
│  └─ acknowledgment.tex      % 致谢
│                             
├─ main.tex                   % 主函数
├─ preamble.tex               % 导言区设置
├─ compile.sh                 % 编译
├─ clean.sh                   % 清理过程文件
└─ README.md
```


## Tex
Files under `style` is the class file, **do not** delete or edit them. 

Modify `preamble.tex`, and write your information at first.
Under the root directory, `mian.tex` is the main function for the template,
where we organize the whole project.
You can put your `tex` file under folder `main`,
adding them in `main.tex`.
Folder `pics` and `appendix` is used to store your pics and appendixes respectively.


## Code & Compile
1. Coding: UTF-8;
1. Using **xelatex** as your complier. 
Run `xelatex` and `bibtex` once to define citations and references.
Then run `xelatex` twice to get your final `pdf` file.

There is a simple script `compile.sh`.
If your are not familiar with `xelatex`,
running the following commands may help:
```bash
sudo chmod +x compile.sh
bash compile.sh
```


## Features
* Easy to use.
* Correct format.
* Update in time.

## Contacts
Email: 20s053030@stu.hit.edu.cn


## Todos
* [ ] Finish the Demo and Manual.
* [ ] Modify compile scripts.

