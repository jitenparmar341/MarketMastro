//
//  DBQueryHelper.m
//  KIFS
//
//  Created by DHARMESH on 18/05/16.
//
//

#import "DBQueryHelper.h"
#import "SQLiteDatabase.h"

@implementation DBQueryHelper
static sqlite3_stmt *statement = nil;


-(BOOL)openDB
{
    [[SQLiteDatabase databaseWithFileName:@"LKS_DB"] setAsSharedInstance];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LKS_DB" ofType:@"db"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    if(sqlite3_open([[url absoluteString] UTF8String], &dbObj) == SQLITE_OK)
    {
        NSLog(@"Database connection is Successfull..");
        return YES;
    }
    else
    {
        NSLog(@"Database connection is not successfull..");
        sqlite3_close(dbObj);
        return NO;
    }
    
    
    //////////////
    
    
    
    
    
}

-(BOOL)insertData:(NSString *)strInsertQuery
{
    [self openDB];
    char *error;
    if(sqlite3_exec(dbObj, [strInsertQuery UTF8String], NULL, NULL, &error)!=SQLITE_OK)
    {
        NSLog(@"%s",error);
        sqlite3_close(dbObj);
        return NO;
    }
    else
    {
        return YES;
    }
}

-(BOOL)updateData:(NSString *)strUpdateQuery
{
    [self openDB];
    char *error;
    if(sqlite3_exec(dbObj, [strUpdateQuery UTF8String], NULL, NULL, &error)!=SQLITE_OK)
    {
        NSLog(@"%s",error);
        sqlite3_close(dbObj);
        return NO;
    }
    else
    {
        return YES;
    }
}

-(BOOL)deleteData:(NSString *)strDeleteQuery
{
    [self openDB];
    char *error;
    if(sqlite3_exec(dbObj, [strDeleteQuery UTF8String], NULL, NULL, &error)!=SQLITE_OK)
    {
        NSLog(@"%s",error);
        sqlite3_close(dbObj);
        return NO;
    }
    else
    {
        return YES;
    }
}

-(sqlite3_stmt*)selectRecords:(NSString*)queryStr
{
    if([self openDB])
    {
        NSLog(@"Database couldn't be opened..");
        sqlite3_close(dbObj);
    }
    [self openDB];
    
    if(sqlite3_prepare(dbObj, [queryStr UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        return statement;
    }
    return statement;
}

@end
