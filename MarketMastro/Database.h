//
//  Database.h
//  eDreamzTask
//
//  Created by Felix ITs 005 on 15/05/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database : NSObject
{
    sqlite3 *sqliteDB;
    NSString *dbpath;
}

//Staff.......

+(Database *)sharedDatabase;
-(void)getDBpath;
-(NSMutableArray *)getAllStaff;
-(int)executeQuery:(NSString *)query;


//Contractor......
-(NSMutableArray *)getAllContractor;
-(int)executeQuery1:(NSString *)query;




@end
