//
//  UIImageView+WebImageTests.m
//  WatchNBATests
//
//  Created by tigi on 2018. 3. 12..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIImageView+WebImage.h"

static NSString * const kImageURLStringCorrectly = @"https://neulionms-a.akamaihd.net/nba/player/v1/nba/site_4/images/multipleplayer.png";
static NSString * const kImageURLStringIncorrectly = @"https://neulionms-a.akamaihd.net/nba/player/v1/nba/site_4/images/incorrectly.png";

static const NSTimeInterval kTestBlockTimeout = 3;

@interface UIImageView_WebImageTests : XCTestCase

@property(nonatomic)UIImageView *testImageView;
@property(nonatomic)UIImage *placeholerImage;
@property(nonatomic)UIImage *loadFailImage;

@end

@implementation UIImageView_WebImageTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [self setTestImageView:[[UIImageView alloc] initWithFrame:CGRectZero]];
    [self setPlaceholerImage:[UIImage imageNamed:@"nba_logo.png"]];
    [self setLoadFailImage:[UIImage imageNamed:@"default_player.png"]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test Case : WebImageOptionDefault

/**
 Test   :   URLString = nil
 Result :   1.fail
            2.image set to the placeholder image
 */
- (void)testCaseImageURLStringNil_WebImageOptionDefault {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];

    [_testImageView setImage:nil];

    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:nil
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionDefault
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTAssert([[weakImageView image] isEqual:_placeholerImage], @"It must be set to the placeholderImage");
             [expectation fulfill];
         } else {
             // success
             XCTFail(@"if imageUrl is nil, result must be error result");
             [expectation fulfill];
         }
    }];

    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   URLString = @""
 Result :   1.fail
            2.image set to the loadFail image
 */
- (void)testCaseImageURLStringEmpty_WebImageOptionDefault {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:@""
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionDefault
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTAssert(aUrl, @"aUrl has to be not nil");
             XCTAssert([[weakImageView image] isEqual:_loadFailImage], @"It must be set to the loadFailImage");
             [expectation fulfill];
         } else {
             // success
             XCTFail(@"if imageUrl is empty, result must be error result");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   URLString = a incorrect image url
 Result :   1.fail
            2.image set to the loadFail image
 */
- (void)testCaseImageURLStringIncorrectly_WebImageOptionDefault {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:kImageURLStringIncorrectly
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionDefault
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTAssert(aUrl, @"aUrl has to be not nil");
             XCTAssert([[weakImageView image] isEqual:_loadFailImage], @"It must be set to the loadFailImage");
             [expectation fulfill];
         } else {
             // success
             XCTFail(@"if imageUrl is incorrect string, result must be error result");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   URLString = a correct image url
 Result :   1.success
            2.url, image is not nil
 */
- (void)testCaseImageURLStringCorrectly_WebImageOptionDefault {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:kImageURLStringCorrectly
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionDefault
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTFail(@"if imageUrl is correct string, result must be success");
             [expectation fulfill];
         } else {
             // success
             XCTAssert(aUrl, @"aUrl has to be not nil");
             XCTAssert(aImage, @"aImage has to be not nil");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

#pragma mark - Test Case : WebImageOptionSDWebImage

/**
 Test   :   URLString = nil
 Result :   1.fail
            2.image set to the placeholder image
 */
- (void)testCaseImageURLStringNil_WebImageOptionSDWebImage {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:nil
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionSDWebImage
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTAssert([[weakImageView image] isEqual:_placeholerImage], @"It must be set to the placeholderImage");
             [expectation fulfill];
         } else {
             // success
             XCTFail(@"if imageUrl is nil, result must be error result");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   URLString = @""
 Result :   1.fail
            2.image set to the loadFail image
 */
- (void)testCaseImageURLStringEmpty_WebImageOptionSDWebImage {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:@""
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionSDWebImage
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTAssert(aUrl, @"aUrl has to be not nil");
             XCTAssert([[weakImageView image] isEqual:_loadFailImage], @"It must be set to the loadFailImage");
             [expectation fulfill];
         } else {
             // success
             XCTFail(@"if imageUrl is empty, result must be error result");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   URLString = a incorrect image url
 Result :   1.fail
            2.image set to the loadFail image
 */
- (void)testCaseImageURLStringIncorrectly_WebImageOptionSDWebImage {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:kImageURLStringIncorrectly
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionSDWebImage
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTAssert(aUrl, @"aUrl has to be not nil");
             XCTAssert([[weakImageView image] isEqual:_loadFailImage], @"It must be set to the loadFailImage");
             [expectation fulfill];
         } else {
             // success
             XCTFail(@"if imageUrl is incorrect string, result must be error result");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   URLString = a correct image url
 Result :   1.success
            2.url, image is not nil
 */
- (void)testCaseImageURLStringCorrectly_WebImageOptionSDWebImage {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:kImageURLStringCorrectly
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionSDWebImage
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTFail(@"if imageUrl is correct string, result must be success");
             [expectation fulfill];
         } else {
             // success
             XCTAssert(aUrl, @"aUrl has to be not nil");
             XCTAssert(aImage, @"aImage has to be not nil");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

#pragma mark - Test Case : WebImageOptionAFNetworking

/**
 Test   :   URLString = nil
 Result :   1.fail
            2.image set to the placeholder image
 */
- (void)testCaseImageURLStringNil_WebImageOptionAFNetworking {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:nil
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionAFNetworking
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTAssert([[weakImageView image] isEqual:_placeholerImage], @"It must be set to the placeholderImage");
             [expectation fulfill];
         } else {
             // success
             XCTFail(@"if imageUrl is nil, result must be error result");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   URLString = @""
 Result :   1.fail
            2.image set to the loadFail image
 */
- (void)testCaseImageURLStringEmpty_WebImageOptionAFNetworking {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:@""
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionAFNetworking
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTAssert(aUrl, @"aUrl has to be not nil");
             XCTAssert([[weakImageView image] isEqual:_loadFailImage], @"It must be set to the loadFailImage");
             [expectation fulfill];
         } else {
             // success
             XCTFail(@"if imageUrl is empty, result must be error result");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   URLString = a incorrect image url
 Result :   1.fail
            2.image set to the loadFail image
 */
- (void)testCaseImageURLStringIncorrectly_WebImageOptionAFNetworking {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:kImageURLStringIncorrectly
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionAFNetworking
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTAssert(aUrl, @"aUrl has to be not nil");
             XCTAssert([[weakImageView image] isEqual:_loadFailImage], @"It must be set to the loadFailImage");
             [expectation fulfill];
         } else {
             // success
             XCTFail(@"if imageUrl is incorrect string, result must be error result");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   URLString = a correct image url
 Result :   1.success
            2.url, image is not nil
 */
- (void)testCaseImageURLStringCorrectly_WebImageOptionAFNetworking {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView
     setImageWithURLString:kImageURLStringCorrectly
     placeholderImage:_placeholerImage
     loadFailImage:_loadFailImage
     option:WebImageOptionAFNetworking
     completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
         if (aError) {
             // fail
             XCTFail(@"if imageUrl is correct string, result must be success");
             [expectation fulfill];
         } else {
             // success
             XCTAssert(aUrl, @"aUrl has to be not nil");
             XCTAssert(aImage, @"aImage has to be not nil");
             [expectation fulfill];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

@end
