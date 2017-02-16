//
//  DBConnectionManager.h
//  MarketMastro
//
//  Created by DHARMESH on 21/01/17.
//  Copyright © 2017 Macmittal software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "AppConstants.h"

@interface DBConnectionManager : NSObject
{
    sqlite3 *dbObj;
    AppConstants *oAppConst;
}
@end
