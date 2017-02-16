//
//  Alert.h
//  MarketMastro
//
//  Created by DHARMESH on 21/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alert : NSObject

@property (assign, nonatomic)int AlertID;
@property (assign, nonatomic)int UserID;
@property (assign, nonatomic)int CommodityID;
@property (assign, nonatomic)int ExpiresInDays;


@property (copy, nonatomic) NSString *ScriptCode;
@property (copy, nonatomic) NSString *Condition;
@property (copy, nonatomic) NSString *Value;
@property (copy, nonatomic) NSString *CreatedDateTime;
@property (copy, nonatomic) NSString *ExpiryDateTime;


@property (assign, nonatomic) BOOL PauseAlerts;
@property (assign, nonatomic) BOOL isHistory;
@property (assign, nonatomic) BOOL DeletedFlag;



@property (copy, nonatomic) NSString *Text;
@property (assign, nonatomic) long CreatedOn;
@property (copy, nonatomic) NSString *CommodityName;
@property (copy, nonatomic) NSString *HistoryText;

@end
