//
//  PatheroTests.m
//  PatheroTests
//
//  Created by Nestor Lafon-Gracia on 12/12/2014.
//  Copyright (c) 2014 Nestor Lafon-Gracia. All rights reserved.
//

#import "Kiwi.h"
#import "NLPathMaker.h"

SPEC_BEGIN(InitialTests)

describe(@"Basic test", ^{
    
    context(@"possitive test", ^{
        
        it(@"should create a path", ^{
            NSString *path1 = @"A";
            NSString *path2 = @"B";
            
            NSString *path =
            createPath(@"origin/").
            appendPathComponent(path1).
            appendPathComponent(@"fixed").
            appendPathComponent(path2).
            appendPathComponent(@"endpoint").
            addQueryParam(@"version", @"1").
            addQueryParam(@"tags", @"one").path;
            [[path should] equal:@"origin/A/fixed/B/endpoint?tags=one&version=1"];
        });
    });
    
    context(@"query array test", ^{
        
        it(@"should create a path", ^{
            NSString *path =
            createPath(@"origin/").
            appendPathComponent(@"endpoint").
            addQueryParam(@"version", @"1").
            addQueryParam(@"tags", @[@1,@"2",@"three"]).
            addQueryParam(@"client", @"XXXxxxXXX").path;
            [[path should] equal:@"origin/endpoint?client=XXXxxxXXX&tags=1&tags=2&tags=three&version=1"];
        });
    });
    
    context(@"query conditional test", ^{
        
        it(@"should create a path", ^{
            
            NSString *path =
            createPath(@"origin/").
            appendPathComponent(@"endpoint").
            addQueryParamConditional(@"version", @"1", NO).
            addQueryParamConditional(@"tags", @"one", YES).
            addQueryParam(@"client", @"XXXxxxXXX").path;
            [[path should] equal:@"origin/endpoint?client=XXXxxxXXX&tags=one"];
        });
    });
    
});

SPEC_END
