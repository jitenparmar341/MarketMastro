//
//  GetPackageListClass.h
//  MarketMastro
//
//  Created by DHARMESH on 16/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetPackageListClass : NSObject

@property (copy,nonatomic) NSString *CPUsed;
@property (copy,nonatomic) NSString *ExpiredOn;
@property (copy,nonatomic) NSString *PackageID;
@property (copy,nonatomic) NSString *PackageName;
@property (copy,nonatomic) NSString *Paid;
@property (copy,nonatomic) NSString *Price;
@property (copy,nonatomic) NSString *PurchasedOn;
@property (copy,nonatomic) NSString *PurchasedStatus;
@property (copy,nonatomic) NSString *USOrderID;
@property (copy,nonatomic) NSString *WithAd;
@property (copy,nonatomic) NSString *isExpired;
@property (copy,nonatomic) NSMutableArray *ArrayGroups;

//@property (nonatomic, weak) NSInteger myInt;

@end
