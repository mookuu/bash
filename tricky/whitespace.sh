#!/bin/bash
#
# whitespace in(空白字符) iso c:
# 空格（‘ ’） ->Space
# 回车（‘\r’）->Return
# 换行（‘\n’）->Newline
# 水平制表符（‘\t’） ->H tab
# 垂直制表符（‘\v’） ->V tab
# 换页（‘\f’）->Clear


# Space
# ASCII: 0x20


# Return
# return to begin of current line
# Sample:
# puts("hello world!\rxxx"); // C language
# result: xxxlo world!

# Newline
# IN *NIX: \n
# IN MAC: \r(show as ^M in *NIX)
# IN WIN: \n\r

# Horizontal tab
# unit:8 charcters
# Sample:
# puts("1234567\txx");
# Result: 1234567 xx
# puts("12345678\txx");
# Result: 12345678	xx

# Vertical tab
# Sample:
# puts("01\v2345");
# Result:
# 01
#   2345

# Clear
# same as clear command in *nix
