//
//  NLPathMaker.h
//  Pathero
//
//  Created by Nestor Lafon-Gracia on 12/12/14.
//
//

#import <Foundation/Foundation.h>

@class NLPathMaker;
@protocol NLPathero;

typedef id<NLPathero> (^AppendPathComponentMethod)(NSString *);
typedef id<NLPathero> (^AddQueryParamMethod)(NSString *, id);

NLPathMaker * createPath(NSString *basePath);

@protocol NLPathero <NSObject>
+ (instancetype)pathMakerWithBasePath:(NSString *)basePath;

@property (readonly) NSString *path;
@property (readonly) AppendPathComponentMethod appendPathComponent;
@property (readonly) AddQueryParamMethod addQueryParam;
@end

@interface NLPathMaker : NSObject <NLPathero>

@end

