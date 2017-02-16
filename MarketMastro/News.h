//
//  News.h
//  MarketMastro
//
//  Created by DHARMESH on 24/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (assign, nonatomic) long createdOn;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *link;
@property (copy, nonatomic) NSString *pubDate;
@property (copy, nonatomic) NSString *descriptionn;
@property (copy, nonatomic) NSString *image;


@end
