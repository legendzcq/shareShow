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
    NSArray *arrayOfDocuments;
    NSURL *fileRUL;
}
@property (nonatomic, strong)QLPreviewController *QLPreVC;
@property (nonatomic, strong)UIDocumentInteractionController *documentController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _QLPreVC=[QLPreviewController new];
//    
//    _QLPreVC.dataSource=self;
//    
//    _QLPreVC.delegate=self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor redColor];

    
    
    NSString * tempabc =[JMDTools NSUserDefaultsget:@"share-url"];
//    NSString * filenameabc = [tempabc lastPathComponent];
//    
    NSLog(@"%@",tempabc);
//
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    　NSString *fileNameOld = [path stringByAppendingPathComponent:@"极密宝系统架构设计文档.DOCX"];
    　NSString *fileNameNew = [path stringByAppendingPathComponent:@"123.DOCX"];
    NSLog(@"%@",fileNameOld);
//    NSLog(@"%@",fileNameNew);
    
    
    
    


    
    
    
//    [JMDTools CopyFileOrgFileName:fileNameOld NewFileName:fileNameNew];
    
    
    
    
    
    //创建实例
//    NSLog(@"%@",[NSURL URLWithString:tempabc]);
    UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL URLWithString:tempabc]];
    self.documentController = documentController;
    documentController.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//        [self presentViewController:_QLPreVC animated:YES completion:nil];
    
    [_documentController presentPreviewAnimated:YES];
//    [self presentViewController:_documentController animated:YES completion:nil];

}

@end