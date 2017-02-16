//
//  LocalSpotCommodity.h
//  MarketMastro
//
//  Created by DHARMESH on 24/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalSpotCommodity : NSObject

//private Commodity commodity;

@property (assign, nonatomic)int CommodityID;
@property (assign, nonatomic)int CompanyID;
@property (assign, nonatomic)int CityID;

@property (assign, nonatomic)double AskItem;
@property (assign, nonatomic)double BidItem;

@property (copy, nonatomic) NSString *CommodityName;
@property (copy, nonatomic) NSString *AskTopic;
@property (copy, nonatomic) NSString *BidTopic;
@property (copy, nonatomic) NSString *CompanyName;
@property (copy, nonatomic) NSString *ContactNo;

@property (copy, nonatomic) NSString *Address;
@property (copy, nonatomic) NSString *Pincode;
@property (copy, nonatomic) NSString *Description;

@end
