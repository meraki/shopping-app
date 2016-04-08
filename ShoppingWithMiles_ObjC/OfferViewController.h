//
//  OfferViewController.h
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

#import <UIKit/UIKit.h>


@interface OfferViewController : UIViewController

@property (nonatomic, strong) UILabel * offerLabel;
@property (nonatomic, strong) UIImageView * offerImageView;
@property (nonatomic, strong) UIImageView * offerLogoView;

@end