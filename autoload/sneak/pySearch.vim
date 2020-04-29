func! sneak#pySearch#Pinyin(table, char, curlin, ttle,reverse)
    call clearmatches()
py3 << EOF
import vim,sys,pickle
ENCODING = vim.eval("&fileencoding")
if not ENCODING or ENCODING == 'none':
    ENCODING = 'utf-8'
table = vim.eval("a:table")
chars = vim.eval("a:char")
curlin = int(vim.eval("a:curlin"))
ttle = vim.eval("a:ttle")
reverse = int(vim.eval("a:reverse"))
charlen = len(chars)
if charlen == 0:
	vim.command("return") # XXX error on no input
cur = vim.current; window = cur.window; buf = cur.buffer
with open(table,'rb') as f:
    Dict = pickle.load(f)
    f.close()

def find_next(line):
    flag = r = 0
    for i in line:
        r += 1
        try :
            t = Dict[i]
        except KeyError:
            t = i
        if chars[flag] in t:
            flag += 1
        elif chars[0] in t:
            flag = 1
        else:
            flag = 0
        if flag == charlen:
            break
    if flag != charlen:
        return -1
    else:
        return r - charlen

def hit(t,r,cl):
    if r:
        buftext = buf[:cl-1]
        buftext.reverse()
    else: 
        buftext = buf[cl:]
    text = [t] + buftext
    for line in text:
        line.strip()
        hp = 0
        l = 0
        hits = []
        while True:
            hp = find_next(line[l:])
            if hp>= 0: 
                word = line[(l + hp) : (l + hp + charlen)]
                hits.append(word)
                l = l + hp + 1
            else:
                break
        if hits:
            break
    if hits:
        if r:
            return hits[-1]
        else:
            return hits[0]
    else:
        return ''

def gen_hit():
    if charlen == 0:
        return []
    else: 
        return hit(ttle,reverse,curlin)

result = gen_hit()
EOF
return py3eval('result')
endfunc
