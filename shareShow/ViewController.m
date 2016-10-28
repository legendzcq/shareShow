//
//  ViewController.m
//  shareTest
//
//  Created by 张传奇 on 16/10/27.
//  Copyright © 2016年 张传奇. All rights reserved.
//

#import "ViewController.h"
#import "JMDTools.h"

@interface ViewController ()
{

    NSURL *fileRUL;
}

@property (nonatomic, strong)UIDocumentInteractionController *documentController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor redColor];

   
    
//    NSString * tempabc =[JMDTools NSUserDefaultsget:@"share-url"];
//    NSLog(@"%@",tempabc);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"%@",path);
//    [JMDTools NSUserDefaultsSet:path forKey:@"DocumetID"];
//    NSString *fileNameOld = [path stringByAppendingPathComponent:@"极密宝系统架构设计文档.docx"];
//    　NSString *fileNameNew = [path stringByAppendingPathComponent:@"123.docx"];
//    NSLog(@"%@",fileNameOld);
    
//       ImageValue

    
    
    
    NSString * tempname = [JMDTools NSUserDefaultsget:@"share-name"];

    NSString * newfilename = [path stringByAppendingPathComponent:tempname];
    
    NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:GroupItemID];
    NSString * tempgroupURL =[NSString stringWithFormat:@"%@/%@",groupURL.path,[JMDTools NSUserDefaultsget:@"share-name"]];
//    ？[groupURL.path stringByAppendingPathComponent:tempname];
    NSLog(@"%@",groupURL);
    NSLog(@"%@",tempgroupURL);
    NSURL *fileURL = [NSURL fileURLWithPath:tempgroupURL];
    NSLog(@"%@",fileURL);
 
    [JMDTools CopyFileOrgFileName:tempgroupURL];
    

    //创建实例
 
    UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:newfilename]];
    self.documentController = documentController;
    documentController.delegate = self;
//           [self deleteFile:tempgroupURL];

}


//代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller {
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller {
    　　return self.view.frame;
}

//点击预览窗口的“Done”(完成)按钮时调用
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller {
}



- (IBAction)btnccc:(id)sender {

    
    [_documentController presentPreviewAnimated:YES];


}

-(BOOL) deleteFile:(NSString *)fileName
{
    if (fileName == nil) {
        return false;
    }
    
    NSError *error = nil;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (fileManager != nil) {
        BOOL result = [fileManager removeItemAtPath:fileName error:&error];
        if (result != YES) {
            return false;
        }
        return true;
    }
    return false;
}

@end