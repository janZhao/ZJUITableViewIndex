//
//  NameIndex.m
//  TestUITableviewIndex
//
//  Created by jyd on 15/7/8.
//  Copyright (c) 2015年 jyd. All rights reserved.
//

#import "NameIndex.h"
#import "pinyin.h"

@implementation NameIndex

- (NSString *) getFirstName {
    if ([self.firstName canBeConvertedToEncoding: NSASCIIStringEncoding]) {//如果是英文
        return self.firstName;
    }
    else { //如果是非英文
        return [NSString stringWithFormat:@"%c",pinyinFirstLetter([self.firstName characterAtIndex:0])];
    }
    
}
- (NSString *) getLastName {
    if ([self.lastName canBeConvertedToEncoding:NSASCIIStringEncoding]) {
        return self.lastName;
    }
    else {
        return [NSString stringWithFormat:@"%c",pinyinFirstLetter([self.lastName characterAtIndex:0])];
    }
    
}

@end
