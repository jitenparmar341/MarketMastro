//
//  NetworkManager.h
//  MarketOfMums
//
//  Created by IsoDev1 on 10/27/15.
//  Copyright © 2015 Neha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
@interface NetworkManager : NSObject
+(BOOL)connectedToNetwork;

+(void)sendWebRequest:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

+(void)signUp:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

+(void)uploadProductImages:(NSDictionary*)parameters withMethod:(NSString*)method WithImageArr:(NSMutableArray*)imageArr successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure;



//swati PostMethod
+(void)PostMethod:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

//swati put method
+(void)PutMethodWithParameters:(NSDictionary *)parameters withMethod:(NSString *)method successResponce:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
