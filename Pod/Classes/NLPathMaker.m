//
//  NLPathMaker.m
//  Pathero
//
//  Created by Nestor Lafon-Gracia on 12/12/14.
//
//

#import "NLPathMaker.h"

@interface NLPathMaker ()
@property (nonatomic, strong) NSString *basePath;
@property (nonatomic, strong) NSMutableArray *pathComponents;
@property (nonatomic, strong) NSMutableDictionary *queryParams;

+ (instancetype)pathMakerWithBasePath:(NSString *)basePath;
@end


NLPathMaker * createPath(NSString *basePath) {
    return [NLPathMaker pathMakerWithBasePath:basePath];
}

@implementation NLPathMaker

+ (instancetype)pathMakerWithBasePath:(NSString *)basePath {
    return [[[self class] alloc] initWithBasePath:basePath];
}

- (instancetype)initWithBasePath:(NSString *)basePath {
    self = [super init];
    if (self) {
        self.basePath = basePath;
        self.pathComponents = [NSMutableArray new];
        self.queryParams = [NSMutableDictionary new];
    }
    return self;
}

- (void)setBasePath:(NSString *)basePath {
    NSString *finalBasePath = [basePath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (finalBasePath.length > 0) {
        NSString *lastChar = [finalBasePath substringFromIndex:finalBasePath.length - 1];
        if ([lastChar isEqualToString:@"/"]) {
            finalBasePath = [finalBasePath substringToIndex:finalBasePath.length - 1];
        }
    }
    _basePath = finalBasePath;
}

- (AppendPathComponentMethod)appendPathComponent {
    return ^(NSString *pathComponent) {
        return [self appendPathComponent:pathComponent];
    };
}

- (AddQueryParamMethod)addQueryParam {
    return ^(NSString *key, NSString *value) {
        return [self addQueryParam:key value:value];
    };
}

- (NLPathMaker *)appendPathComponent:(NSString *)pathComponent {
    [self.pathComponents addObject:pathComponent];
    return self;
}

- (NLPathMaker *)addQueryParam:(NSString *)param value:(NSString *)value {
    [self.queryParams setValue:value forKey:param];
    return self;
}

- (NSString *)path {
    NSMutableString *path = [NSMutableString stringWithString:self.basePath];
    if ([self.pathComponents count] > 0) {
        NSString *pathComponents = [self.pathComponents componentsJoinedByString:@"/"];
        [path appendString:@"/"];
        [path appendString:pathComponents];
    }
    
    if ([self.queryParams count] > 0) {
        [path appendString:@"?"];
        NSArray *allKeys = [[self.queryParams allKeys] sortedArrayUsingSelector:@selector(compare:)];
        NSString *lastKey = [allKeys lastObject];
        for (NSString *key in allKeys) {
            [path appendFormat:@"%@=%@", key, self.queryParams[key]];
            if (key != lastKey) {
                [path appendString:@"&"];
            }
        }
    }
    
    return path;
}

@end
