//
//  JMDTools.m
//  jimidun
//
//  Created by 张传奇 on 16/4/11.
//  Copyright © 2016年 microdone. All rights reserved.
//

#import "JMDTools.h"
@implementation JMDTools
static JMDTools *_install = nil;
/**
 *  alloc方法内部会调用allocWithZone:
 *  zone : 系统分配给app的内存
 */
+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (_install == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{ // 安全(这个代码只会被调用一次)
            _install = [super allocWithZone:zone];
        });
    }
    return _install;
}

- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _install = [super init];
    });
    return _install;
}

+ (instancetype)sharedConnetionTool
{
    return [[self alloc] init];
}
//偏好设置中设置变量
+ (void)NSUserDefaultsSet:(id)data forKey:(NSString *)Key
{
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:data forKey:Key];
//    [defaults synchronize];
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:GroupItemID];
    [userDefaults setValue: data forKey:Key];
}
//偏好设置中读取变量
+ (id)NSUserDefaultsget:(NSString *)key
{

    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:GroupItemID];

    return [userDefaults objectForKey:key];
}

//文件复制
//文件复制
+ (BOOL)CopyFileOrgFileName:(NSString *)srcPath
{
    //    NSString *srcPath=oName;
    NSString * tempFileName = [srcPath lastPathComponent];
    NSString *groupURL = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileNameNew = [groupURL stringByAppendingPathComponent:tempFileName];

    
    
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.legend.shareShow"];
    [userDefaults setValue: tempFileName forKey:@"share-name"];
    
    
    
    

    NSData *imageDataOrigin = [NSData dataWithContentsOfFile:srcPath];
    
    [imageDataOrigin writeToFile:fileNameNew atomically:YES];

    
    return YES;
}


@end
