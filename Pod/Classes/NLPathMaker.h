//
//  NLPathMaker.h
//  Pathero
//
//  Created by Nestor Lafon-Gracia on 12/12/14.
//
//

#import <Foundation/Foundation.h>

@class NLPathMaker;

typedef NLPathMaker * (^AppendPathComponentMethod)(NSString *);
typedef NLPathMaker * (^AddQueryParamMethod)(NSString *, NSString *);

NLPathMaker * createPath(NSString *basePath);

@interface NLPathMaker : NSObject

@property (readonly) NSString *path;
@property (readonly) AppendPathComponentMethod appendPathComponent;
@property (readonly) AddQueryParamMethod addQueryParam;

@end
