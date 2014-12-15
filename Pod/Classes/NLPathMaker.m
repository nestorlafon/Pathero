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

- (instancetype)appendPathComponent:(NSString *)pathComponent {
    [self.pathComponents addObject:pathComponent];
    return self;
}

- (instancetype)addQueryParam:(NSString *)param value:(id)value {
    [self.queryParams setValue:value forKey:param];
    return self;
}

- (NSString *)paramStringValue:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    else if ([value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    }
    else {
        return nil;
    }
}

- (NSString *)stringParamForKey:(NSString *)key value:(id)value {
    NSString *paramStringValue = [self paramStringValue:value];
    if (paramStringValue) {
        return [NSString stringWithFormat:@"%@=%@", key, paramStringValue];
    }
    else if ([value isKindOfClass:[NSArray class]]) {
        NSMutableString *arrayStringParam = [NSMutableString new];
        [value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [arrayStringParam appendString:[self stringParamForKey:key value:obj]];
            if (idx < [value count] -1) {
                [arrayStringParam appendString:@"&"];
            }
        }];
        return arrayStringParam;
    }
    else {
        NSAssert(YES, @"Error creating the path");
        return nil;
    }
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
            [path appendString:[self stringParamForKey:key value:self.queryParams[key]]];
            if (key != lastKey) {
                [path appendString:@"&"];
            }
        }
    }
    
    return path;
}

@end
