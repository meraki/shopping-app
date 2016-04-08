//
//  OfferViewController.m
//  ShoppingWithMiles_ObjC
//
//  Created by James McKee on 15/02/2016.
//  Copyright © 2016 James McKee. All rights reserved.
//
//  Credits and References:
//  https://developer.apple.com/library/ios/samplecode/AirLocate/Listings/ReadMe_txt.html
//  https://developer.apple.com/ibeacon/Getting-Started-with-iBeacon.pdf
//  https://www.packtpub.com/application-development/learning-ibeacon
//

#import "OfferViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BeaconViewController.h"
#import "AppDelegate.h"

@interface OfferViewController ()

@end

@implementation OfferViewController

@synthesize offerLabel;
@synthesize offerImageView;
@synthesize offerLogoView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 100)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:120.0f/255.0f green:190.0f/255.0f blue:32.0f/255.0f alpha:1.0f]];
    [label setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:28]];
    label.numberOfLines = 0; // Allow the label to auto wrap.
    
    [self.view addSubview:label];
    self.offerLabel = label;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 120, 300, 300)];
    [imageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [imageView.layer setBorderWidth:2.f];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.offerImageView = imageView;
    
    UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 475, 120, 120)];
    [logoView.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [logoView.layer setBorderWidth:2.f];
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logoView];
    self.offerLogoView = logoView;
    
    UIButton * dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(60.f, 440.f, 200.f, 44.f)];
    [self.view addSubview:dismissButton];
    [dismissButton setTitle:@"Exit" forState:UIControlStateNormal];
    [dismissButton.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:22]];
    [dismissButton setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:190.0f/255.0f blue:32.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissTapped:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)dismissTapped:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        AppDelegate * delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        BeaconViewController * rootVc = (BeaconViewController*)delegate.window.rootViewController;
        [rootVc offerDismissed];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

