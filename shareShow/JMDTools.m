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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:Key];
    [defaults synchronize];
}
//偏好设置中读取变量
+ (id)NSUserDefaultsget:(NSString *)key
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults objectForKey:key];
    
    
    //初始化一个供App Groups使用的NSUserDefaults对象
//    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.cn.vimfung.ShareExtensionDemo"];
//    
//    //写入数据
//    [userDefaults setValue:@"value" forKey:@"key"];
//    
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.legend.shareShow"];
//    [userDefaults setValue: ((NSURL *)item).absoluteString forKey:@"share-url"];
//    //用于标记是新的分享
//    [userDefaults setBool:YES forKey:@"has-new-share"];
    return [userDefaults objectForKey:key];
}

//文件复制
+ (BOOL)CopyFileOrgFileName:(NSString *)oName NewFileName:(NSString *)Nname
{
    NSString *srcPath=oName;
    NSString *tarPath=Nname;
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL success=[fileManager createFileAtPath:tarPath contents:nil attributes:nil];
    if (success) {
        NSLog(@"文件创建成功");

           NSData *imageDataOrigin = [NSData dataWithContentsOfFile:oName];
        NSLog(@"%@",oName);
        NSFileHandle *inFile=[NSFileHandle fileHandleForReadingAtPath:oName];
//        [NSFileHandle fileHandleForReadingAtPath:srcPath];
        NSFileHandle *outFile=[NSFileHandle fileHandleForWritingAtPath:tarPath];
        
        NSDictionary   *fileAttu=[fileManager attributesOfItemAtPath:srcPath error:nil];
        NSNumber *fileSizeNum=[fileAttu objectForKey:NSFileSize];
        

        int n=0;
        
        BOOL isEnd=YES;
        NSInteger readSize=0;//已经读取的数量
        NSInteger fileSize=[fileSizeNum longValue];//文件的总长度
        while (isEnd) {
            

            
            NSInteger subLength=fileSize-readSize;
            NSData *data=nil;
            if (subLength<5000) {
                isEnd=NO;
                data=[inFile readDataToEndOfFile];
            }else{
                data=[inFile readDataOfLength:5000];
                readSize+=5000;
                [inFile seekToFileOffset:readSize];
            }
            [outFile writeData:data];
            n++;
        }
        
        [inFile closeFile];
        [outFile closeFile];
    }

    return YES;
}


@end
