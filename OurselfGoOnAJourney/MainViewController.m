//
//  MainViewController.m
//  OurselfGoOnAJourney
//
//  Created by liangjie on 16/5/20.
//  Copyright © 2016年 liangjie. All rights reserved.
//

#import "MainViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <MAMapKit/MAMapKit.h>
#import "MAMapView+IsShowAccuracyCircle.h"


NSString *const GAODEAMAP = @"ce38cc5640804d06555ff143abbabb9f";

@interface MainViewController () <MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

@end

@implementation MainViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MAMapServices sharedServices].apiKey = GAODEAMAP;
    
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.rotateEnabled = NO;
    _mapView.rotateCameraEnabled = NO;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    [self startLocation];
    _mapView.showAccuracyCircle = NO;
}
- (void)startLocation {
    _mapView.showsUserLocation = YES;
    _mapView.pausesLocationUpdatesAutomatically = NO;
    _mapView.allowsBackgroundLocationUpdates = YES;
    //_mapView.userTrackingMode = MAUserTrackingModeFollow;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
}
- (MACircleRenderer *)defaultAccuracyCircleRenderer:(id <MAOverlay>)overlay {
    MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
    accuracyCircleRenderer.lineWidth    = 2.f;
    accuracyCircleRenderer.strokeColor  = kMAOverlayRendererDefaultStrokeColor;
    accuracyCircleRenderer.fillColor    = kMAOverlayRendererDefaultFillColor;
    
    return accuracyCircleRenderer;
}

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if (mapView.showAccuracyCircle) {
        /* 自定义定位精度对应的MACircleView. */
        if (overlay == mapView.userLocationAccuracyCircle)
        {
            return [self defaultAccuracyCircleRenderer:overlay];
        }
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        
        self.userLocationAnnotationView = annotationView;
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading - _mapView.rotationDegree;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
    }
}


@end
