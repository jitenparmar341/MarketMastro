//
//  webManager.h
//  MarketOfMums
//
//  Created by IsoDev1 on 10/28/15.
//  Copyright © 2015 Neha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define WEB_MANAGER ([webManager sharedObject])

@interface webManager : NSObject
+(webManager*)sharedObject;

-(void)loginRequest:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

-(void)signUp:(NSDictionary*)Parameters andMethod:(NSString*)methodName successResponce:(void (^)(id Responce))success failure:(void (^)(NSError *error))failure;

-(void)OrderRequest:(NSDictionary *)parameters withMethod:(NSString *)method successResponse:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

-(void)UploadMultipleImagesWithParam:(NSDictionary *)parameters withArr:(NSMutableArray *)ProductImgArr andMethod :(NSString *)methodName successResponce:(void (^)(id Responce))success failure:(void (^)(NSError *error))failure;


//Swati Call post method
-(void)CallPostMethod:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure;


//swati call put method
-(void)CallPutMethodwithParameters:(NSDictionary*)parameters withMethod:(NSString*)method successResponce:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

@end
