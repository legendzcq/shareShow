//
//  ShareViewController.m
//  shareZcq
//
//  Created by 张传奇 on 16/10/27.
//  Copyright © 2016年 张传奇. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    

    
    __block BOOL hasExistsUrl = NO;
    [self.extensionContext.inputItems enumerateObjectsUsingBlock:^(NSExtensionItem * _Nonnull extItem, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [extItem.attachments enumerateObjectsUsingBlock:^(NSItemProvider * _Nonnull itemProvider, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@",itemProvider);
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"])
            {
                [itemProvider loadItemForTypeIdentifier:@"public.url"
                                                options:nil
                                      completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                                          
                                          if ([(NSObject *)item isKindOfClass:[NSURL class]])
                                          {
                                              NSLog(@"分享的URL = %@", item);
                                              
                                              NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.legend.shareShow"];
                                              [userDefaults setValue: ((NSURL *)item).absoluteString forKey:@"share-url"];
                                              //用于标记是新的分享
                                              [userDefaults setBool:YES forKey:@"has-new-share"];
                                          }
                                          
                                      }];
                
                hasExistsUrl = YES;
                *stop = YES;
            }
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.jpeg"])
            {
                [itemProvider loadItemForTypeIdentifier:@"public.jpeg"
                                                options:nil
                                      completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                                          NSLog(@"%@",item);
                                          //                                          if ([(NSObject *)item isKindOfClass:[NSURL class]])
                                          //                                          {
                                          //                                              NSLog(@"分享的URL = %@", item);
                                          //                                          }
                                          
                                      }];
                
                hasExistsUrl = YES;
                *stop = YES;
            }
        }];
        NSLog(@"标题:%@",extItem.attributedTitle);
        NSLog(@"内容:%@",extItem.attributedContentText);
        NSLog(@"照片:%@",extItem.attachments);
        if (hasExistsUrl)
        {
            *stop = YES;
        }
        
    }];
    
    
    

}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

@end
