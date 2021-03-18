
## hitszthesis\_master
This project is a dissertation template for masters and doctors
in Harbin Institute of Technology, ShenZhen (HITSZ).

You can check the screenshots at [pics/demo\_x.png](
https://github.com/lazyshawn/hitszthesis_master/tree/master/demo/pics).

## Usage
1. Download repository.
```shell
git clone https://github.com/lazyshawn/hitszthesis_master.git
```

2. Load demo (optional).

These commands will get a copy of a default project to current path,
which may help you get started.
```shell
cd hitszthesis_master
bash thesis.sh -l
```

3. Code your tex project.
> For more information, please refer to [tutorial.md](
https://github.com/lazyshawn/hitszthesis_master/blob/master/tutorial.md).

In the case that you are using the default project,
you should modify a tex file named `preamble.tex` to fill your information,
then include all chapters in `main.tex`.

Otherwise, make sure the `style/<thesis>.cls` is set as your documentclass,
where the `<thesis>` means `thesis_master` for master or `thesis_doctor` for doctor.
And informations about your dissertation should be provided by special directives
(please refer to `demo/preamble.tex` and `tutorial.md`).

4. Compile / Build.

Compile tex project in the way you are prefer to.
Optionally, you can use command line to finish it by running:
```shell
bash thesis.sh -b
```

5. Update.

Pull this repository to get update.
Note that update only change the `style` and `demo` folders,
will **not** vanish your previous work.
Also make sure you are using the `.cls` file under `./style`.
```shell
git pull origin master
```


## Documentation
Here is the structure of this project after loading demo:
```git
│
├─ style
│  ├─ gbt7714.bst             % 参考文献格式
│  ├─ gbt7714.sty             % 参考文献格式宏包
│  ├─ hitszthesis_master.cls  % 文档类
│  └─ hitszthesis_master.cfg  % 文档类常量设置
│
├─ demo                       % 存放示例文件
│  └─ ...                     
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
├─ thesis.sh                  % 脚本文件
├─ README.md
└─ ...                        % 编译过程文件
```


## Tex
Files under `style` are the class files, **do not** delete or edit them. 
You need to load the documentclass in your main.tex,
using `\documentclass{style/<thesis>}`.

Modify `preamble.tex`, and write your information at first.
Under the root directory, `mian.tex` is the main function for the template,
where we organize the whole project.
You can put your `tex` file under folder `main`,
including them in `main.tex`.
Folder `pics` and `appendix` is used to store your pics and appendices respectively.


## Code & Compile
1. Coding: UTF-8;
1. Using **xelatex** as your complier. 
Run `xelatex` and `bibtex` once to define citations and references.
Then run `xelatex` twice to get your final `pdf` file.

There is a simple script named `compile.sh`.
If your are not familiar with `xelatex`,
running the following command may help:
```bash
bash thesis.sh -b
```


## Scripts manual
A script is offered to make work easier.
```bash
bash thesis.sh [option]
```

| Options                     | Descriptions        |
| ---                         | ---                 |
| `-l` / `--load`             | Load demo           |
| `-b<main>`/`--build=<main>` | Build \<main\>.tex  |
| `-c` / `--clean`            | Clean process files |


## Features
* Easy to use.
* Correct format.
* Update in time.

## Contacts
Email: 20s053030@stu.hit.edu.cn


## Todos
* [ ] Finish the Demo and Manual.
* [x] Modify compile scripts.


## Donation
I would really appreciate it if you could financially support this project.
(疯狂暗示)

WeChat  | Alipay
|-|-|
|![wechat](https://raw.githubusercontent.com/lazyshawn/hitszthesis_master/master/demo/pics/wechat.jpg =900x)|![alipay](https://raw.githubusercontent.com/lazyshawn/hitszthesis_master/master/demo/pics/alipay.jpg =900x)|


