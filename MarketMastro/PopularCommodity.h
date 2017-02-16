//
//  PopularCommodity.h
//  MarketMastro
//
//  Created by DHARMESH on 24/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopularCommodity : NSObject

@property (assign, nonatomic)int TypeID;
@property (assign, nonatomic)int CommodityID;
@property (assign, nonatomic)int GroupID;

@property (copy, nonatomic) NSString *TypeName;
@property (copy, nonatomic) NSString *GroupName;
@property (copy, nonatomic) NSString *Name;

@property (assign, nonatomic) BOOL isLocalSpot;
@property (assign, nonatomic) BOOL isPopular;
@property (assign, nonatomic) BOOL DeletedFlag;

@end
