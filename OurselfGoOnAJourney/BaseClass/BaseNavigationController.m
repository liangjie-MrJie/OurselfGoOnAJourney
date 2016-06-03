//
//  BaseNavigationController.m
//  OurselfGoOnAJourney
//
//  Created by liangjie on 16/5/21.
//  Copyright © 2016年 liangjie. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftBarButtonItemType:@"返回"];
    [self titleViewType:self.title];
}

#pragma mark - Handle Action

- (void)leftBarButtonItemType:(id)leftBarType {
    if ([leftBarType isKindOfClass:[NSString class]]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:leftBarType style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarAction)];
    }
    else if ([leftBarType isKindOfClass:[UIImage class]]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarType style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarAction)];
    }
    else if ([leftBarType isKindOfClass:[UIView class]]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarType];
    }
}
- (void)leftBarAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)titleViewType:(id)titleType {
    if ([titleType isKindOfClass:[NSString class]]) {
        UILabel *titleLabel = [[UILabel alloc] init];
        
        titleLabel.backgroundColor  = [UIColor clearColor];
        titleLabel.textColor        = [UIColor blueColor];
        titleLabel.text             = titleType;
        [titleLabel sizeToFit];
        self.navigationItem.titleView = titleLabel;
    }
    else if ([titleType isKindOfClass:[UIView class]]) {
        self.navigationItem.titleView = titleType;
    }
}


@end
