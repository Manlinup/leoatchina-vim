# leoatchina的vim配置文件
This is leoatchina's vim config forked from [spf13-vim:steve francia's vim distribution](https://github.com/spf13/spf13-vim).I sincerely thank him for great job. To meet my needs,I have changed lots of settings and plugins.
 You can find spf13's origin config at http://spf13.com


[spf13]()对他自己作品的介绍
> spf13-vim is a distribution of vim plugins and resources for Vim, Gvim and MacVim.
> It is a good starting point for anyone intending to use VIM for development running equally well on Windows, Linux, \*nix and Mac.
> The distribution is completely customisable using a `~/.vimrc.local`, `~/.vimrc.bundles.local`, and `~/.vimrc.before.local` Vim RC files.

## 背景
本人是生信工程师,主要使用的语言是`python`,`perl`,`shell`,经常要ssh到远程服务器上写代码,因此学习了vim,后来发现了[spf13-vim:steve francia's vim distribution](https://github.com/spf13/spf13-vim),大大提高了写代码的效率。
但是,原配置仍然有很多插件和配置不符合我的需要,因此,fork后进行了大量的修改.请访问[leoatchina的vim配置文件](https://github.com/leoatchina/spf13-vim-leoatchina).由于本人水平所限,一定有很多错误和bug,望各位指正.
**注意**使本配置文件后可能会影响vim运行流畅度,介意者要通过学习后,关闭某些特性以提高速度.

## 对使用者的要求
掌握vim的大部分操作,了解`Leader`,`map`,`hjkl`,`d`,`w`,`s`,`i`,`u`,`:`,`\`等操作命令

## 配置文件
**各配置文件**
* `.vimrc`      # 最主要的配置文件,配色、快捷键、显示方式等参数都在这里设置
* `.vimrc.local` # 自定义配置
* `.vimrc.plug`  # 插件管理文件

## 安装
*安装本配置 需要 Git 1.7+ 和 Vim 7.4+，部分插件如`ale`,`AsyncRun`,需要Vim8.0*

### Linux, \*nix, Mac OSX 下的安装

需要系统里安装好`git`,`curl`

```bash
  git clone https://github.com/leoatchina/spf13-vim-leoatchina.git
  cd spf13-vim-leoatchina
  ./install.sh   第一次安装要按`y`
```

### windows下的安装
```
点击setup.cmd
```

### 升级到最新版本
```bash
  vim +PlugUpdate
  或者在vim里直接  :PlugUpdate
```

## 一些功能
* 复制内容直接放到系统剪贴本
* 显示行号,多种语法高亮
* Visual模式下用`>`,`<`移动文字不会取消选择
* 不生成backup文件
* 关闭拼写检查
* 关闭声音
* 关闭列光标加亮
* 关闭行光标加亮
* 允许折行
* 不代码折叠
* 开启实时搜索功能
* 显示光标当前位置
* 高亮显示搜索结果
* 折叠模式下翻页的改进
* 智能缩进
* 没有滚动条
* 没有菜单和工具条
* 总是显示状态栏
* 根据系统情况，自动或手动设定补全插件

## 主要改动
我在spf13的基础上，做了一些*微小*的工作
- 大量精减，去除了`fork`,`before`功能
- 用`vim-plug`代替了原来的`vundle`作为插件管理器
- 修改了安装代码，变成直接从clone的目录中软链接到用户目录下，**不再支持XP**
- 按自己习惯修改了大量快捷键
- 去除了原来定义的一些函数
- 加入了6种补全插件：`youcompleteme`,`deoplete`,`completor`,`asyncomplete`,`neocomplete`,`neocomplcache`,默认会在后5种中选择一种。

## 基本快捷键
* `<Leader>`键改为空格键,这个在键盘上最大的按键就有了更强的作用;
* `<localLeader>`改为`\`
* `C-l`,`C-f`变成了两个`先导键`，其中`C-l`+a代替`C-a`,`C-l`+x代替`C-x`
* `~`作为进入`ex`模式的快捷键,`Q`键map为`退出当前buffer`
* `F1`: 为`:h `，方便启动帮助
* `F5`: 运行脚本（python、perl、c等）或 `<Leader>R`;
* `F6`: 打开关闭代码折叠 或 `<Leader>fd`
* `F7`: 打开关闭换行 或 `<Leader>fr`
* `F8`: 打开关闭搜索高亮 或 `<Leader>fh`
* `F11`: 全屏切换,如果是windows下的gvim,要把本目录下的`gvim_fullscreen.dll`放到`gvim`的安装目录下，此时<S+F11>为切换透明度
* `F12`: 切换paste模式,或者`<Leader>fp`
* 在`Visual`模式下按`.`为退出`Visual`模式
* n,v,i三种模式下，`Ctrl+e`移到一行的结尾;`Ctrl+a`移到一行的开头;`C-f`往右;`C-b`往左
* `Ctrl+m`括号之间跳转
* 标签页控制
```
  set tabpagemax=10 " Only show 10 tabs
  cmap Tabe tabe
  nnoremap <silent>-     :tabprevious<CR>  #前一个标签
  nnoremap <silent><Tab> :tabnext<CR> #后一个标签
  nnoremap <Leader>tp :tabprevious<CR> #前标签
  nnoremap <Leader>tn :tabnext<CR> #后标签
  nnoremap <Leader>-  :tabm -1<CR>
  nnoremap <Leader><Tab>  :tabm +1<CR>
  nnoremap <LocalLeader>- :tabfirst<CR>
  nnoremap <LocalLeader><Tab> :tablast<CR>
  nnoremap <Leader>te :tabe<Space>
  nnoremap <Leader>ts :tab split<CR>
  nnoremap <Leader>tS :tabs<CR>
  nnoremap <Leader>tm :tabm<Space>```
```
* 复制粘贴等
```
  " 设置快捷键将选中文本块复制至系统剪贴板
  vnoremap  <Leader>y  "+y
  nnoremap  <Leader>y  "+y
  nnoremap  <Leader>Y  "+yg
  nnoremap  <Leader>yy  "+yy
  " Yank from the cursor to the end of the line
  nnoremap Y y$
  " p and P for paste
  nnoremap <Leader>p "+p
  nnoremap <Leader>P "+P
  vnoremap <Leader>p "+p
  vnoremap <Leader>P "+P
```
* 其他一些快捷键
```
  " buffer switch
  nnoremap ) :bn<CR>
  nnoremap ( :bp<CR>
  " 定义快捷键保存当前窗口内容
  nmap <Leader>w :w<CR>
  nmap <Leader>W :wq!<CR>
  " 定义快捷键保存所有窗口内容并退出 vim
  nmap <Leader>WQ :wa<CR>:q<CR>
  " 定义快捷键关闭当前窗口
  nmap <Leader>q :q<CR>
  " 不做任何保存，直接退出 vim
  nmap <Leader>Q :qa!<CR>
  " 设置分割页面
  nmap <Leader>- :split<Space>
  nmap <Leader>\ :vsplit<Space>
  nmap <Leader>= <C-W>=
  "设置垂直高度减增
  nmap <Leader>{ :resize -3<CR>
  nmap <Leader>} :resize +3<CR>
  "设置水平宽度减增
  nmap <Leader>[ :vertical resize -3<CR>
  nmap <Leader>] :vertical resize +3<CR>
  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv
  " Ctrl-m for switch between brackets
  map <C-m> %
```


## 插件系统
我使用[vim-plug](https://github.com/junegunn/vim-plug)代替了spf13的[vundle](https://github.com/VundleVim/Vundle.vim),安装速度快了数倍。高级功能还在调试中

### 补全插件
- 用了6种补全插件,2种代码插件
#### [YouComplteMe](https://github.com/Valloric/YouCompleteMe)
  ![](https://camo.githubusercontent.com/1f3f922431d5363224b20e99467ff28b04e810e2/687474703a2f2f692e696d6775722e636f6d2f304f50346f6f642e676966)
  - 需要安装一系列编译用软件
  - 具体可参考[Vim 自动补全插件 YouCompleteMe 安装与配置](http://howiefh.github.io/2015/05/22/vim-install-youcompleteme-plugin/).
  - 在安装好各种编译用的工具后
  ```
     cd ~/.vim/bundle/YouCompleteMe
     python install.py
  ```
#### [asyncomplete](https://github.com/prabirshrestha/asyncomplete.vim)
在nvimcompletemangaer停止更新后，另一开发者fork后，直接利用了vim8内置的异步功能进行补全，不再需要python支持
这个提供了一个框架，补全功能要配合其他插件使用

#### [deoplete](https://github.com/Shougo/deoplete.nvim)

#### [completor](https://github.com/maralla/completor.vim)

#### [neocomplete](https://github.com/Shougo/neocomplete.vim)

#### [neocomplcache](https://github.com/Shougo/neocomplcache.vim)

### 内置多个主题
在有gui时，使用`hybrid_material`, 其他情况时使用`gruvbox`
使用`:colorscheme ` 再敲`tab`，可以看到内置的主题

### [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)
在侧边显示当前目录，Toggle快捷键为`<Leader>nn`
![](http://oxa21co60.bkt.clouddn.com/markdown-img-paste-20171011101641847.png)

### [majutsushi/tagbar](https://github.com/majutsushi/tagbar)
显示文档结构，在`python`,`vim`里肯定有用，要求在系统里安装`ctags`
用`<Leader>tt`切换在测边显示文档结构.在bar窗口里按`F1`调出帮助窗口
![](http://oxa21co60.bkt.clouddn.com/markdown-img-paste-20171011102150785.png)


### [vim-voom/VOoM](https://github.com/vim-voom/VOoM)
另一个显示文档结构的插件，和`TagBar`逻辑不一样，`python`里肯定有用，其他语言我还没有测试出来。快捷键`<Leader>vo`打开 `:Voom`命令;`<Leader>vt`为`:VoomToggle`voom状态切换
![](http://oxa21co60.bkt.clouddn.com/markdown-img-paste-20171012105213969.png)

### [mbbill/undotree](https://github.com/mbbill/undotree)
undotree顾名思义,增强版的回退插件，快捷键`<Leader>u`

### [airline](https://github.com/vim-airline-themes)
漂亮的状态栏,能够显示很多状态。
![](http://oxa21co60.bkt.clouddn.com/markdown-img-paste-20171011105655369.png)

### [ywvim中文输入法](https://github.com/leoatchina/ywvim)
`ywvim`中文输入法,直接在vim里内置,~~无意中发现要和[fcitx](https://github.com/fcitx/fcitx)配合使用否则会有bug~~,在`insert`模式下通过`CTRL+@`或`CTRL+\`开启,`CTRL+^`进行配置.`;`临时英文输入法;注意,默认只输入**英文状态**的标点,而且首选是`五笔`;`z`临时拼音;`,.-=`上下翻页;
![](http://oxa21co60.bkt.clouddn.com/markdown-img-paste-20171011215538461.png)
![](http://oxa21co60.bkt.clouddn.com/markdown-img-paste-20171011212612850.png)

### [markdown]()
默认开户对markdown语言的高亮支持,如`.vimrc.before.local`里指定`markdown`支持,按`<leadr>mk`调用`chrome`打开markdown预览,不过这个功能还要仔细测试过.

### [fugitive](https://github.com/tpope/vim-fugitive)
对git的支持,具体可以看官方说明,不过我就设置了快捷键`<Leader>gi :Git<Space>`,操作体验接近终端下输入`git`命令

### [scrooloose/nerdcommenter](https://github.com/scrooloose/nerdcommenter)
注释插件,神器,直接上官方的快捷键,最常用的是`<Leader>c<Space>`
  * `[count]<Leader>cc` **|NERDComComment|**
    Comment out the current line or text selected in visual mode.
  * `[count]<Leader>cn` **|NERDComNestedComment|**
    Same as <Leader>cc but forces nesting.
  * `[count]<Leader>c<Space>` **|NERDComToggleComment|**
    Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.
  * `[count]<Leader>cm` **|NERDComMinimalComment|**
    Comments the given lines using only one set of multipart delimiters.
  * `[count]<Leader>ci` **|NERDComInvertComment|**
    Toggles the comment state of the selected line(s) individually.
  * `[count]<Leader>cs` **|NERDComSexyComment|**
    Comments out the selected lines with a pretty block formatted layout.
  * `[count]<Leader>cy` **|NERDComYankComment|**
    Same as <Leader>cc except that the commented line(s) are yanked first.
  * `<Leader>c$` **|NERDComEOLComment|**
    Comments the current line from the cursor to the end of line.
  * `<Leader>cA` **|NERDComAppendComment|**
    Adds comment delimiters to the end of line and goes into insert mode between them.
  * **|NERDComInsertComment|**
    Adds comment delimiters at the current cursor position and inserts between. Disabled by default.
  * `<Leader>ca` **|NERDComAltDelim|**
    Switches to the alternative set of delimiters.
  * `[count]<Leader>cl`
    `[count]<Leader>cb` **|NERDComAlignedComment|**
    Same as **|NERDComComment|** except that the delimiters are aligned down the left side (`<Leader>cl`) or both sides (`<Leader>cb`).
  * `[count]<Leader>cu` **|NERDComUncommentLine|**
    Uncomments the selected line(s).




### [ctrlp](https://github.com/ctrlpvim/ctrlp.vim)
杀手级插件,引用网上的一段话对它的介绍
> 在 VIM 世界里，有人是分窗口编辑文件的忠实拥护者，有人则是多文件 tab 页的死忠骨灰粉。但无论哪种人， 在一些大项目内进行编辑工作时，如果要快速打开 './lib/foo/bar/comm/base_utils.py' 这类藏在大山深处的文件，都需像剥粽子一样，一层一层往下找，让人头疼。
> ctrlp.vim 则完美帮你解决了这个痛点，当你想打开某个文件时，只要按下 Ctrl + p 快捷键，输入文件名。 所有和这个文件名匹配的文件都会被按照优先级列出来，按下 enter 或者 Ctrl + t 就可以在当前 buffer 或者新 tab 页打开你要的文件了。

网上找来的图
![](http://zuyunfei.com/images/ctrlp-vim-demo.gif)

`ctrl+p`启动插件,`<Leader>fu`启动funksky函数查询功能,在启动后,用`Ctrl+f`,`Ctrl+b`在不同模式中切换.
在文件列表中,`Ctrl+k/j`或者方向键向上/下选择文件,`t`在新标签里打开文件.其他快捷键见[ctrlp中文介绍](http://blog.codepiano.com/pages/ctrlp-cn.light.html)

### [Pymode](https://github.com/python-mode/python-mode)
`python`用的插件,具有语法检查,调试等功能.`F9`: python语法检查,`S+F9`切换语法是否检查.`<Leader>R`:运行脚本;`<Leader>T`:track_point toggle

### [surround](https://github.com/tpope/vim-surround)
给一段文字加上括号的插件，下面说明文字引用自[vim中的杀手级别的插件：surround](http://zuyunfei.com/2013/04/17/killer-plugin-of-vim-surround/)
```
   Old text                  Command     New text
   "Hello *world!"           ds"         Hello world!
   [123+4*56]/2              cs])        (123+456)/2
   "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
   if *x>3 {                 ysW(        if ( x>3 ) {
   my $str = *whee!;         vlllls'     my $str = 'whee!';
   <div>Yo!*</div>           dst         Yo!
   <div>Yo!*</div>           cst<p>      <p>Yo!</p>
```
如上面代码块所示，添加替换时使用后半括号)]}，添加的括号和内容间就没有空格（如第2个示例），反之会在内容前后添加一个空格（如第4个实例）。第6个示例中的t代表一对HTML或者xml tag。其他表示范围的符号：w代表word, W代表WORD(被空格分开的连续的字符窜），p代表paragraph。

*命令列表*
```
    Normal mode
    -----------
    ds  - delete a surrounding
    cs  - change a surrounding
    ys  - add a surrounding
    yS  - add a surrounding and place the surrounded text on a new line + indent it
    yss - add a surrounding to the whole line
    ySs - add a surrounding to the whole line, place it on a new line + indent it
    ySS - same as ySs
    Visual mode
    -----------
    s   - in visual mode, add a surrounding
    S   - in visual mode, add a surrounding but place text on new line + indent it
    Insert mode "不建议使用
    -----------
    <CTRL-s> - in insert mode, add a surrounding
    <CTRL-s><CTRL-s> - in insert mode, add a new line + surrounding + indent
    <CTRL-g>s - same as <CTRL-s>
    <CTRL-g>S - same as <CTRL-s><CTRL-s>
```
### [vim-easy-align](https://github.com/junegunn/vim-easy-align)


### [EasyMotion](https://github.com/easymotion/vim-easymotion)
 又一个杀手级别的插件
 ![](http://www.wklken.me/imgs/vim/easy_motion_search.gif)
 1. 跳转到当前光标前后,快捷键`<Leader><Leader>w`和`<Leader><Leader>b`
 2. 搜索跳转,`<Leader><Leader>s`,然后输入要搜索的字母
 3. 行间/行内级别跳转,`<Leader><Leader>`再`hjkl`不解释
 4. 重复上一次的动作,`<Leader><Leader>.`
 5. 还可以`<Leader><Leader>f`和`<Leader><Leader>t`,不过不建议使用
