//
//  NameIndex.h
//  TestUITableviewIndex
//
//  Created by jyd on 15/7/8.
//  Copyright (c) 2015年 jyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameIndex : NSObject

@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic) NSInteger sectionNum;
@property (nonatomic) NSInteger originIndex;

- (NSString *) getFirstName;
- (NSString *) getLastName;

@end
