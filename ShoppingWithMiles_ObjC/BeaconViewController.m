//
//  BeaconViewController.m
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

#import "BeaconViewController.h"

@interface BeaconViewController ()
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic, strong) NSMutableDictionary * offersSeen;
@property (nonatomic, strong) OfferViewController * currentOffer;
@end


@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetBeacons];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self resetBeacons];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)resetBeacons {
    // Initialise location manager that will range for beacons
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Request permission to access location
    // NSLocationAlwaysUsageDescription String required in info.plist
    [self.locationManager requestAlwaysAuthorization];
    
    // Clear the offers seen. Create NSMutableDictionay of offer size.
    self.offersSeen = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    // Create new beacon region, using device proximity to beacon of chosen UUID
    NSUUID * regionId = [[NSUUID alloc]
                         initWithUUIDString:@"E2C56DB5-DFFB-48D2-0002-D0F5A71096E0"];
    
    CLBeaconRegion * beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:regionId identifier:@"MilesShopping"];
    
    // Start monitoring and ranging beacons.
    [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
}

// Check location authorization status
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
}

// When region is entered start ranging for beacons
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
}

// When region is exited stop ranging for beacons
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    for (CLBeacon * beacon in beacons) {
        if (self.currentOffer) return;
        
        NSString * majorMinorValue = [NSString stringWithFormat:@"%@|%@", beacon.major, beacon.minor];
        
        // Stop presenting offer if seen previously in active session.
        if ([self.offersSeen objectForKey:majorMinorValue]) continue;
        
        [self.offersSeen setObject:[NSNumber numberWithBool:YES] forKey:majorMinorValue];
        OfferViewController * offerVc = [[OfferViewController alloc] init];
        offerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        UIColor * backgroundColor;
        NSString * labelValue;
        UIImage * productImage;
        UIImage * logoImage;
        
        // Set Major Beacon Value
        if (([beacon.major intValue] == 0)) {
            
            // Set background colour to white.
            backgroundColor = [UIColor colorWithRed:255.0/255.0
                                              green:255.0/255.0
                                               blue:255.0/255.0
                                              alpha:1.0];
            
            // Set Minor Beacon Value per Offer based on beacon ranging results
            
            // Present offer one: Major:0 Minor:1 via Offer View Controller
            if ([beacon.minor intValue] == 1) {
                labelValue = @"25% off Meraki MR Access Points.";
                productImage = [UIImage imageNamed:@"MR-Offer.png"];
                logoImage = [UIImage imageNamed:@"Cisco-Meraki.png"];
                
                [offerVc.view setBackgroundColor:backgroundColor];
                [offerVc.offerLabel setText:labelValue];
                [offerVc.offerImageView setImage:productImage];
                [offerVc.offerLogoView setImage:logoImage];
                [self presentViewController:offerVc animated:YES completion:nil];
                self.currentOffer = offerVc;
                
            // Present offer one: Major:0 Minor:3 via Offer View Controller
            } else if ([beacon.minor intValue] == 3)  {
                labelValue = @"Buy one Meraki MS Switch, get one free.";
                productImage = [UIImage imageNamed:@"MS-Offer.png"];
                logoImage = [UIImage imageNamed:@"Cisco-Meraki.png"];
                
                [offerVc.view setBackgroundColor:backgroundColor];
                [offerVc.offerLabel setText:labelValue];
                [offerVc.offerImageView setImage:productImage];
                [offerVc.offerLogoView setImage:logoImage];
                [self presentViewController:offerVc animated:YES completion:nil];
                self.currentOffer = offerVc;
                
            // Present offer one: Major:0 Minor:2 via Offer View Controller
            } else if ([beacon.minor intValue] == 2)  {
                labelValue = @"50% off all Meraki MX Security Appliances.";
                productImage = [UIImage imageNamed:@"MX-Offer.png"];
                logoImage = [UIImage imageNamed:@"Cisco-Meraki.png"];
                
                [offerVc.view setBackgroundColor:backgroundColor];
                [offerVc.offerLabel setText:labelValue];
                [offerVc.offerImageView setImage:productImage];
                [offerVc.offerLogoView setImage:logoImage];
                [self presentViewController:offerVc animated:YES completion:nil];
                self.currentOffer = offerVc;
                
            // Present offer one: Major:0 Minor:4 via Offer View Controller
            } else if ([beacon.minor intValue] == 4)  {
                labelValue = @"100 SME Users Free!";
                productImage = [UIImage imageNamed:@"SM-Offer.png"];
                logoImage = [UIImage imageNamed:@"Cisco-Meraki.png"];
                
                [offerVc.view setBackgroundColor:backgroundColor];
                [offerVc.offerLabel setText:labelValue];
                [offerVc.offerImageView setImage:productImage];
                [offerVc.offerLogoView setImage:logoImage];
                [self presentViewController:offerVc animated:YES completion:nil];
                self.currentOffer = offerVc;
            }
        }
    }
}

// Clear current offer
-(void)offerDismissed {
    self.currentOffer = nil;
}


@end
