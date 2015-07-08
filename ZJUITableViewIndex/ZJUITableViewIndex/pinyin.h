//
//  pinyin.h
//  TestUITableviewIndex
//
//  Created by jyd on 15/7/8.
//  Copyright (c) 2015年 jyd. All rights reserved.
//

#ifndef __TestUITableviewIndex__pinyin__
#define __TestUITableviewIndex__pinyin__

#include <stdio.h>

#endif /* defined(__TestUITableviewIndex__pinyin__) */

/*
 * // Example
 *
 * #import "pinyin.h"
 *
 * NSString *hanyu = @"中国共产党万岁！";
 * for (int i = 0; i < [hanyu length]; i++)
 * {
 *     printf("%c", pinyinFirstLetter([hanyu characterAtIndex:i]));
 * }
 *
 */
char pinyinFirstLetter(unsigned short hanzi);


//Example
//这样我们就可以根据名字的第一个字，取其ascii码，根据上述算法，得到对应的拼音首字母，
//如：“白沙”
//NSString * name = @"白沙";
//unichar firstHanzi = [name characterAtIndex:0];//取“白”的ascii码（30333）
//char py = pinyinFirstLetter(firstHanzi);//得到拼音首字母为b
