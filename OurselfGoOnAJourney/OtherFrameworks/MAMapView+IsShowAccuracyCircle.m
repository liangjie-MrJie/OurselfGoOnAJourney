//
//  MAMapView+IsShowAccuracyCircle.m
//  OurselfGoOnAJourney
//
//  Created by liangjie on 16/5/20.
//  Copyright © 2016年 liangjie. All rights reserved.
//

#import "MAMapView+IsShowAccuracyCircle.h"
#import <objc/runtime.h>


@implementation MAMapView (IsShowAccuracyCircle)

static void *key = "key";

- (void)setShowAccuracyCircle:(BOOL)showAccuracyCircle {
    objc_setAssociatedObject(self, &key, @(showAccuracyCircle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)showAccuracyCircle {
    NSNumber *number = objc_getAssociatedObject(self, &key);
    return number.boolValue;
}

@end
