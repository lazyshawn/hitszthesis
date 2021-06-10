
## ✨ hitszthesis
This project is a dissertation template for masters and doctors
in Harbin Institute of Technology, ShenZhen (HITSZ).

You can check the screenshots at [pics/demo\_x.png](
https://github.com/lazyshawn/hitszthesis_master/tree/master/demo/pics).

## ✨ Usage
> For Windows users, [git-bash](https://gitforwindows.org/) are highly recommended.

1. Download repository.
```shell
git clone https://github.com/lazyshawn/hitszthesis.git
```

2. Load demo (optional).

These commands will get a copy of a default project to current path,
which may help you get started.
```shell
cd hitszthesis
bash thesis.sh -l
```

3. Code your tex project.
> For more information, please refer to [tutorial.md](
https://github.com/lazyshawn/hitszthesis/blob/master/doc/tutorial.md).

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
Also make sure you are using the `<thesis>.cls` file under `./style`.
```shell
git pull origin master
```


## ✨ Documentation
Here is the structure of this project after loading demo:
```git
│
├─ appendix                   % 附录
│  └─ ...                     
│
├─ demo                       % 存放示例文件
│  └─ ...                     
│
├─ doc
│  ├─ changeLog.md            % 更新日志
│  └─ tutorial.md             % 帮助文档
│
├─ main                       % 正文部分
│  ├─ abstract.tex            % 摘要
│  ├─ introduction.tex        % 绪论
│  ├─ demo.tex                % 示例
│  ├─ ...                     
│  └─ acknowledgment.tex      % 致谢
│                             
├─ pics                       % 存放图片
│  └─ ...                     
│
├─ refs                       % 参考文献
│  └─ ...                     
│
├─ style
│  ├─ gbt7714.bst             % 参考文献格式
│  ├─ gbt7714.sty             % 参考文献格式宏包
│  ├─ fontSetting.sty         % 字体设置宏包
│  ├─ thesis.cfg              % 文档类常量设置
│  ├─ thesis_master.cls       % 硕士论文格式文档类
│  └─ thesis_doctor.cls       % 博士论文格式文档类
│
├─ main.tex                   % 主函数
├─ preamble.tex               % 导言区设置
├─ thesis.sh                  % 脚本文件
├─ README.md
├─ LICENSE
└─ ...                        % 编译过程文件
```


## ✨ Tex
Files under `style` are the class files, **do not** delete or edit them. 
You need to load the documentclass in your main.tex,
using `\documentclass{style/<thesis>}`.

Modify `preamble.tex`, and write your information at first.
Under the root directory, `mian.tex` is the main function for the template,
where we organize the whole project.
You can put your `tex` file under folder `main`,
including them in `main.tex`.
Folder `pics` and `appendix` is used to store your pics and appendices respectively.


## ✨ Code & Compile
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


## ✨ Scripts manual
A script is offered to make work easier.
```bash
bash thesis.sh [option]
```

| Options                     | Descriptions        |
| ---                         | ---                 |
| `-l` / `--load`             | Load demo           |
| `-b<main>`/`--build=<main>` | Build \<main\>.tex  |
| `-c` / `--clean`            | Clean process files |


## ✨ About hitszthesis
### Features
* Easy to use.
* Correct format.
* Update in time.

### Recent efforts
> Check [doc/changeLog.md](
https://github.com/lazyshawn/hitszthesis/blob/master/doc/changeLog.md) for more details.

* [x] Finish the Demo and Manual.
* [x] Modify compile scripts.
* [x] Listing environment.
* [ ] Pseudo code.
* [ ] Issues templates.

### Contacts
Email: 20s053030@stu.hit.edu.cn

### Donation
I would really appreciate it if you could financially support this project.

| WeChat  | Alipay |
|-|-|
| <img src="https://gitee.com/lazyshawn/piclink/raw/master/payment/wechat.jpg" width = "900" alt="wechat" align=center /> | <img src="https://gitee.com/lazyshawn/piclink/raw/master/payment/alipay.jpg" width = "900" alt="alipay" align=center /> |

