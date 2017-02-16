//
//  Commodity.h
//  MarketMastro
//
//  Created by DHARMESH on 21/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commodity : NSObject

@property (assign, nonatomic)int CommodityID;////
@property (assign, nonatomic)int CityID;////
@property (assign, nonatomic)int StateID;
@property (assign, nonatomic)int CountryID;

@property (assign, nonatomic)int CompanyID;////
@property (assign, nonatomic)int CPTypeInt;////
@property (assign, nonatomic)int TickSize;////
@property (assign, nonatomic)int LotSize;////

@property (assign, nonatomic)int ULToken;////
@property (assign, nonatomic)int OFISTypeInt;////
@property (assign, nonatomic)int CALevel;////
@property (assign, nonatomic)int SortOrder;////
@property (assign, nonatomic)long Expiry;////
@property (assign, nonatomic)double StrikeRate;////

@property (copy, nonatomic) NSString *ScriptCode;////
@property (copy, nonatomic) NSString *Symbol;////
@property (copy, nonatomic) NSString *Name;////
@property (copy, nonatomic) NSString *CommodityType;////
@property (copy, nonatomic) NSString *Exch;/////


@property (copy, nonatomic) NSString *ExchType;////
@property (copy, nonatomic) NSString *SubTitle;////
@property (copy, nonatomic) NSString *Series;////
@property (copy, nonatomic) NSString *CreatedDate;////
@property (copy, nonatomic) NSString *TimeSpan;/////

@property (copy, nonatomic) NSString *ShortName;////
@property (copy, nonatomic) NSString *Digits;////
@property (copy, nonatomic) NSString *Type;////
@property (copy, nonatomic) NSString *BidTopic;////
@property (copy, nonatomic) NSString *BidItem;/////


@property (copy, nonatomic) NSString *Date;////
@property (copy, nonatomic) NSString *Description;////
@property (copy, nonatomic) NSString *CreatedID;////
@property (copy, nonatomic) NSString *ModifiedID;////
@property (copy, nonatomic) NSString *ModifiedDate;/////


@property (assign, nonatomic) BOOL isPopular;
@property (assign, nonatomic) BOOL AllowOnUpdate;
@property (assign, nonatomic) BOOL Status;
@property (assign, nonatomic) BOOL DeletedFlag;
@property (assign, nonatomic) BOOL UpdateFlag;


@end
