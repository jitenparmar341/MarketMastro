//
//  CommodityGroup.h
//  MarketMastro
//
//  Created by DHARMESH on 24/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommodityGroup : NSObject

@property (assign, nonatomic)int ParentGroupID;
@property (assign, nonatomic)int CreatedID;
@property (assign, nonatomic)int GroupID;

@property (copy, nonatomic) NSString *GroupDesc;
@property (copy, nonatomic) NSString *GroupType;
@property (copy, nonatomic) NSString *GroupName;
@property (copy, nonatomic) NSString *CreatedDate;

@property (assign, nonatomic) BOOL DeletedFlag;

@end
