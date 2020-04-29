# PySneak
Py is pun for Python and PinYin<br>
最近用vim写中文论文，跳转无比痛苦，又找不到合适的插件，
无奈之下拿[vim-sneak](https://github.com/justinmk/vim-sneak)
和[vim-PinyinSearch](https://github.com/ppwwyyxx/vim-PinyinSearch)硬着头皮改了一个，输入两个字的拼音首字母跳转。现学现卖VimL和python，轻喷。
## Requirements
Python 3，文档需要utf8编码
## Install
1. 用插件管理器安装插件，如[vim-plug](https://github.com/junegunn/vim-plug)在vimrc内添加 Plug 'deaniiyu/PySneak'
2. 在.vimrc内设置插件附带的PySearch.pkl字典路径，let g:PinyinSearch_Dict = “path/to/PySearch.pkl”，将引号内替换为你的实际字典路径
3. 在.vimrc内设置let g:pysneak = 1 将1改为0可使用原版[vim-sneak](https://github.com/justinmk/vim-sneak)
## Usage
基本同[vim-sneak](https://github.com/justinmk/vim-sneak)，普通模式下输入小写s+两个拼音首字母跳转，如“普通”，
输入spt跳转。敲击;跳转下一条匹配，敲击,或\跳转上一条。
普通模式下大写S为反向匹配。Visual mode下反向匹配换为大写Z，因为大写S可能被[vim-surround](https://github.com/tpope/vim-surround)占用。Operator pending mode
下正向反向匹配分别替换为z和Z，原因同上。输入单个字母或符号后可按enter直接跳转。可参考[vim-sneak](https://github.com/justinmk/vim-sneak)的帮助文档。
![PySneak](https://user-images.githubusercontent.com/20110035/80567104-0e824f00-8a27-11ea-9916-a6a9a551467c.gif)
###Custom input length
原生的sneak支持自定义输入字母个数，我自己把默认数从两位改为五位（输入字母达到5个时自动触发跳转，小于5位时需摁enter跳转），可以提高定位准确度。vimrc设置如下，你可以把5调为你自己认为合适的数字。<br>
nnoremap <silent> s :<C-U>call sneak#wrap('',           5, 0, 2, 1)<CR>           <br>
nnoremap <silent> S :<C-U>call sneak#wrap('',           5, 1, 2, 1)<CR><br>
xnoremap <silent> s :<C-U>call sneak#wrap(visualmode(), 5, 0, 2, 1)<CR><br>
xnoremap <silent> Z :<C-U>call sneak#wrap(visualmode(), 5, 1, 2, 1)<CR><br>
onoremap <silent> z :<C-U>call sneak#wrap(v:operator,   5, 0, 2, 1)<CR><br>
onoremap <silent> Z :<C-U>call sneak#wrap(v:operator,   5, 1, 2, 1)<CR><br>
效果如下：
![PySneak2](https://user-images.githubusercontent.com/20110035/80630785-5638c300-8a87-11ea-9d05-2c5233ebb803.gif)
## Known Issues
~~1. 无法像原生sneak一样用数字进行重复跳转，如5;~~
2. 不支持sneak的label mode
3. 无法一次性高亮全部匹配
~~4. visual mode下回退匹配(,或\\)在回退到越过初始位置时只能匹配一次~~

