//
//  JMDTools.h
//  jimidun
//
//  Created by 张传奇 on 16/4/11.
//  Copyright © 2016年 microdone. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GroupItemID @"group.legend.shareShow"


@interface JMDTools : NSObject
//偏好设置存储数据
+(void)NSUserDefaultsSet:(id)data forKey:(NSString *)Key;
+(id)NSUserDefaultsget:(NSString *)key;
//文件复制
+ (BOOL)CopyFileOrgFileName:(NSString *)srcPath;
@end
