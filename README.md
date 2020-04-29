# PySneak
Py is pun for Python and PinYin<br>
最近用vim写中文论文，跳转无比痛苦，又找不到合适的插件，
无奈之下拿[vim-sneak](https://github.com/justinmk/vim-sneak)
和[vim-PinyinSearch](https://github.com/ppwwyyxx/vim-PinyinSearch)硬着头皮改了一个，输入两个字的拼音首字母跳转。VimL和python都是现学现卖，轻喷。
## Requirements
Python 3
## Install
1. 用插件管理器安装插件，如[vim-plug](https://github.com/junegunn/vim-plug)在vimrc内添加 Plug 'deaniiyu/PySneak'
2. 在.vimrc内设置插件附带的PySearch.pkl字典路径，let g:PinyinSearch_Dict = “path/to/PySearch.pkl”，将引号内替换为你的实际字典路径
3. 在.vimrc内设置let g:pysneak = 1 将1改为0可使用原版[vim-sneak](https://github.com/justinmk/vim-sneak)
## Usage
基本同[vim-sneak](https://github.com/justinmk/vim-sneak)，普通模式下输入小写s+两个拼音首字母跳转，如“普通”，
输入spt跳转。敲击;跳转下一条匹配，敲击,或\跳转上一条。
普通模式下大写S为反向匹配。Visual mode下反向匹配换为大写Z，因为大写S可能被[vim-surround](https://github.com/tpope/vim-surround)占用。Operator pending mode
下正向反向匹配分别替换为z和Z，原因同上。可参考[vim-sneak](https://github.com/justinmk/vim-sneak)的帮助文档。
![PySneak](https://user-images.githubusercontent.com/20110035/80567104-0e824f00-8a27-11ea-9916-a6a9a551467c.gif)
## Known Issues
1. 无法像原生sneak一样用数字进行重复跳转，如5;
2. 不支持sneak的label mode
3. 无法一次性高亮全部匹配
4. visual mode下回退匹配(,或\)在回退到越过初始位置时只能匹配一次
