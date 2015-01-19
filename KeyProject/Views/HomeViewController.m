//
//  HomeViewController.m
//  KeyProject
//
//  Created by cscv on 1/16/15.
//  Copyright (c) 2015 cscv. All rights reserved.
//

#import "HomeViewController.h"
#import "ColaDataManager.h"

#define METERS_PER_MILE 1609.344

@interface HomeViewController ()

@end


@implementation HomeViewController
@synthesize mkView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mkView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mkView];
    // config map view
    mkView.showsUserLocation = YES;
    
    [mkView setCenterCoordinate:CLLocationCoordinate2DMake(10.7822203802915, 106.6922825) animated:YES];
    
    [[ColaDataManager sharedInstance] requestDemoData];
}
- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 10.7822203802915;
    zoomLocation.longitude= 106.6922825;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [mkView setRegion:viewRegion animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
