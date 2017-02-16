//
//  DBQueryHelper.h
//  KIFS
//
//  Created by DHARMESH on 18/05/16.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
//#import "ConnectionConstants.h"

@interface DBQueryHelper : NSObject
{
    sqlite3 *dbObj;
}
-(BOOL)insertData:(NSString *)strInsertQuery;
-(BOOL)deleteData:(NSString *)strDeleteQuery;
-(BOOL)updateData:(NSString *)strUpdateQuery;
-(sqlite3_stmt*)selectRecords:(NSString*)queryStr;
-(BOOL)openDB;

@end
