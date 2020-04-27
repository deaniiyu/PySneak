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

def char2dict(char):
    flags = 0
    r = 0
    for c in char:
        try:
            t = Dict[c]
        except KeyError:
            t = c
        if chars[r] in t:
            flags += 1
        r += 1
    return (flags==charlen)

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

        #def hitlist_original(t,rev,cl):
        #    ret = []
        #    if rev: buftext = buf[:cl-1]+[t]
        #    else:
        #        buftext = [t] + buf[cl:]
        #    text = ''.join(map(lambda x : x.strip(), buftext))
        #    l = 0
        #    while True:
        #        r = find_next(text[l:])
        #        if r >= 0:
        #            word = text[(l + r) : (l + r + charlen)]
        #            ret.append(word)
        #            l = l + r + 1
        #        else :
        #            return ret

def hitlist(t,r,cl):
    hits = []
    if r:
        text = buf[:cl-1]+[t]
    else: 
        text = [t] + buf[cl:]
    for line in text:
        line.strip()
        l = 0
        h = 0
        linehits = []
        while True:
            hp = find_next(line[l:])
            if hp >= 0:
                word = line[(l + hp) : (l + hp + charlen)]
                if h>0 and hp == 0 and linehits[-1][-1] == word[0] and len(set(word)) ==1:
                    linehits[-1] += word
                else:
                    linehits.append(word)
                    h = 1
                l = l + hp + charlen
            else:
                break
        hits += linehits
    return hits

def gen_list():
    if charlen == 0:
        return []
    else: 
        return hitlist(ttle,reverse,curlin)

result = gen_list()
if reverse:
    result.reverse()
EOF
return py3eval('result')
endfunc
