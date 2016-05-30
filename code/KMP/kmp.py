#!/usr/local/bin/python3
#coding:utf-8

def create_nexts(pattern):
    '''
    a、当前面字符的前一个字符的对称程度为0的时候，只要将当前字符与子串第一个字符进行比较。这个很好理解啊，前面都是0，说明都不对称了，
    如果多加了一个字符，要对称的话最多是当前的和第一个对称。比如agcta这个里面t的是0，那么后面的a的对称程度只需要看它是不是等于第一个字符a
    了。
    b、按照这个推理，我们就可以总结一个规律，不仅前面是0呀，如果前面一个字符的next值是1，那么我们就把当前字符与子串第二个字符进行比较，
    因为前面的是1，说明前面的字符已经和第一个相等了，如果这个又与第二个相等了，说明对称程度就是2了。有两个字符对称了。比如上面agctag，倒数
    第二个a的next是1，说明它和第一个a对称了，接着我们就把最后一个g与第二个g比较，又相等，自然对称成都就累加了，就是2了。
    c、按照上面的推理，如果一直相等，就一直累加，可以一直推啊，推到这里应该一点难度都没有吧，如果你觉得有难度说明我写的太失败了。当然不可能
    会那么顺利让我们一直对称下去，如果遇到下一个不相等了，那么说明不能继承前面的对称性了，这种情况只能说明没有那么多对称了，但是不能说明一
    点对称性都没有，所以遇到这种情况就要重新来考虑，这个也是难点所在。
    '''
    if 0 == len(pattern):
        return []

    nexts = [0]

    if pattern[1] == pattern[0]:
        nexts.append(1)
    else:
        nexts.append(0)

    for i in range(2, len(pattern)):
        j = i - 1
        if pattern[i] == pattern[nexts[j]]:
            nexts.append(nexts[j] + 1)
        # elif pattern[i] == pattern[0]:
        #     nexts.append(1)
        # else:
        #     nexts.append(0)
        else:
            n = nexts[j]
            while n > 0:
                if pattern[n] == pattern[i]:
                    nexts.append(n + 1)
                    break
                else:
                    n = nexts[n-1]
            else:
                if pattern[i] == pattern[0]:
                    nexts.append(1)
                else:
                    nexts.append(0)
    return nexts

def kmp_search(text, pattern):
    '''
    主串不回溯.只移动pattern.
    '''
    i = 0 #index of text
    j = 0 #index of pattern
    nexts = create_nexts(pattern)
    while i+j < len(text):
        # debug info
        # print("i = " + i.__str__())
        j_origin = 0
        for j in range(j, len(pattern)):
            if text[j+i] != pattern[j]:
                j_origin = j
                j = nexts[j]
                break
            elif j == len(pattern) - 1:
                return i
        if j == j_origin :
            i += 1
        else:
            i = i + j_origin - j
    return -1

if __name__ == "__main__":
    print(create_nexts('agctagcagctagct'))
    print(6 == kmp_search('ababdabce', 'bce'))
    print(2 == kmp_search('ababdabce', 'abd'))
    print(-1 == kmp_search('ababdabce', 'abdx'))
    print(10 == kmp_search('THIS IS A TEST TEXT', 'TEST'))
    print(0 == kmp_search('AABAACAADAABAAABAA', 'AABA'))
    print(kmp_search('ababu', 'abu'))
    #agctagcagctagct
    #000012312345674
