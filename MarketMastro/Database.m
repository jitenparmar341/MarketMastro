//
//  Database.m
//  eDreamzTask
//
//  Created by Felix ITs 005 on 15/05/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "Database.h"
#import "Commodity.h"
#import "Staff.h"


@implementation Database

+(Database *)sharedDatabase
{
    static Database * db;
    
    if (db == nil)
    {
        db= [[Database alloc]init];
    }
    
    [db getDBpath];
    return db;
    
}
-(void)getDBpath
{
    
    //LKS_DB.db
    
    NSString * libraryPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    
    dbpath = [libraryPath stringByAppendingPathComponent:@"LKS_DB.db"];
}


//staff..............
-(NSMutableArray *)getAllStaff
{
    
    NSMutableArray * staffArray = [[NSMutableArray alloc]init];
    NSString * query = @"select * from Commodity";
    
    const char * sqlitePath = [dbpath UTF8String];
    const char * sqliteQuery = [query UTF8String];
    
    sqlite3_stmt * statement;
    
    if (sqlite3_open(sqlitePath, &sqliteDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(sqliteDB, sqliteQuery, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_DONE)
            {
                Staff * stf = [[Staff alloc]init];
                stf.name = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
                stf.uniqueId = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];

               stf.emailId = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 2)];
               stf.PhoneNo = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 3)];
    
                [staffArray addObject:stf];
                
            }
        }
        else
        {
            NSLog(@"Unalble to prepare due to error = %s",sqlite3_errmsg(sqliteDB));
        }
        
    }
    else
    {
        NSLog(@"Unable to open due to error = %s",sqlite3_errmsg(sqliteDB));
        
    }
    
    sqlite3_close(sqliteDB);
    return staffArray;
    
}

-(int)executeQuery:(NSString *)query
{
    const char * sqlitePath = [dbpath UTF8String];
    
    const char * sqliteQuery = [query UTF8String];
    
    sqlite3_stmt * statement;
    
    int success;
    
    if (sqlite3_open(sqlitePath, &sqliteDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(sqliteDB, sqliteQuery, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success=1;
            }
            else
            {
                NSLog(@"Unable to execute due to error = %s",sqlite3_errmsg(sqliteDB));
                success=0;
            }
        }
        else
        {
            NSLog(@"Unable to Prepare due to error = %s",sqlite3_errmsg(sqliteDB));
            
        }
    }
    else
    {
        NSLog(@"Unable to open due to error = %s",sqlite3_errmsg(sqliteDB));
    }
    
    sqlite3_close(sqliteDB);
    
    return success;
}

//contractor...............
-(NSMutableArray *)getAllContractor
{
    
    
    
    NSMutableArray * contractorArray = [[NSMutableArray alloc]init];
    NSString * query = @"select * from contractortable";
    
    const char * sqlitePath = [dbpath UTF8String];
    const char * sqliteQuery = [query UTF8String];
    
    sqlite3_stmt * statement;
    
    if (sqlite3_open(sqlitePath, &sqliteDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(sqliteDB, sqliteQuery, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                
//                Contractor *con = [[Contractor alloc]init];
//                con.name = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
//                con.uniqueId = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
//            con.emailId = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 2)];
//                con.address = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 3)];
//                
//                [contractorArray addObject:con];
            }
        }
        else
        {
            NSLog(@"Unalble to prepare due to error = %s",sqlite3_errmsg(sqliteDB));
        }
        
    }
    else
    {
        NSLog(@"Unable to open due to error = %s",sqlite3_errmsg(sqliteDB));
        
    }
    
    sqlite3_close(sqliteDB);
    return contractorArray;
    
    
    
    
    
}
-(int)executeQuery1:(NSString *)query
{
    const char * sqlitePath = [dbpath UTF8String];
    
    const char * sqliteQuery = [query UTF8String];
    
    sqlite3_stmt * statement;
    
    int success;
    
    if (sqlite3_open(sqlitePath, &sqliteDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(sqliteDB, sqliteQuery, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success=1;
            }
            else
            {
                NSLog(@"Unable to execute due to error = %s",sqlite3_errmsg(sqliteDB));
                success=0;
            }
        }
        else
        {
            NSLog(@"Unable to Prepare due to error = %s",sqlite3_errmsg(sqliteDB));
        }
    }
    else
    {
        NSLog(@"Unable to open due to error = %s",sqlite3_errmsg(sqliteDB));
    }
    
    sqlite3_close(sqliteDB);
    
    return success;
}



@end
