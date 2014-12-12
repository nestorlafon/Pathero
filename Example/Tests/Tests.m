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
            NSString *merchant = @"A-merchant";
            NSString *country = @"A-country";
            
            NSString *path =
            createPath(@"v2/").
            appendPathComponent(country).
            appendPathComponent(@"merchants").
            appendPathComponent(merchant).
            appendPathComponent(@"messages").
            addQueryParam(@"subversion", @"1").
            addQueryParam(@"tags_supported", @"popup").path;
            [[path should] equal:@"v2/A-country/merchants/A-merchant/messages?subversion=1&tags_supported=popup"];
        });
    });
});

SPEC_END
