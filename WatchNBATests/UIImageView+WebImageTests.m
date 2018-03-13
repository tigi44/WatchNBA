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

static const NSTimeInterval kTestBlockTimeout = 2;

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
 Test   :   ImageURLString = nil
            WebImageOption = WebImageOptionDefault
 
 Result :   1.fail
            2.aUrl has to be nil
            3.aImage has to be nil
            4.the imageView set to the placeholder image
 */
- (void)testCaseImageURLStringNil_WebImageOptionDefault {
    NSString *sImageURLString = nil;
    WebImageOption sWebImageOption = WebImageOptionDefault;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];

    [_testImageView setImage:nil];

    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTAssertNil(aUrl, @"aUrl has to be nil");
                                       XCTAssertNil(aImage, @"aImage has to be nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:_placeholerImage], @"the imageView must be set to the placeholderImage");
                                   } else {
                                       // success
                                       XCTFail(@"if the imageUrl is nil, the result must be error result");
                                   }
                                   [expectation fulfill];
                               }];

    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   ImageURLString = @""
            WebImageOption = WebImageOptionDefault
 
 Result :   1.fail
            2.aUrl has to be not nil
            3.aImage has to be nil
            4.the imageView set to the loadFail image
 */
- (void)testCaseImageURLStringEmpty_WebImageOptionDefault {
    NSString *sImageURLString = @"";
    WebImageOption sWebImageOption = WebImageOptionDefault;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTAssertNotNil(aUrl, @"aUrl has to be not nil");
                                       XCTAssertNil(aImage, @"aImage has to be nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:_loadFailImage], @"the imageView must be set to the loadFailImage");
                                   } else {
                                       // success
                                       XCTFail(@"if the imageUrl is empty, the result must be error result");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   ImageURLString = a incorrect image url
            WebImageOption = WebImageOptionDefault
 
 Result :   1.fail
            2.aUrl has to be not nil
            3.aImage has to be nil
            4.the imageView set to the loadFail image
 */
- (void)testCaseImageURLStringIncorrectly_WebImageOptionDefault {
    NSString *sImageURLString = kImageURLStringIncorrectly;
    WebImageOption sWebImageOption = WebImageOptionDefault;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTAssertNotNil(aUrl, @"aUrl has to be not nil");
                                       XCTAssertNil(aImage, @"aImage has to be nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:_loadFailImage], @"the imageView must be set to the loadFailImage");
                                   } else {
                                       // success
                                       XCTFail(@"if the imageUrl is a incorrect string, the result must be error result");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   ImageURLString = a correct image url
            WebImageOption = WebImageOptionDefault
 
 Result :   1.success
            2.aUrl has to be not nil
            3.aImage has to be not nil
            4.the imageView set to be not nil
 */
- (void)testCaseImageURLStringCorrectly_WebImageOptionDefault {
    NSString *sImageURLString = kImageURLStringCorrectly;
    WebImageOption sWebImageOption = WebImageOptionDefault;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTFail(@"if the imageUrl is a correct string, the result must be success");
                                   } else {
                                       // success
                                       XCTAssertNotNil(aUrl, @"aUrl has to be not nil");
                                       XCTAssertNotNil(aImage, @"aImage has to be not nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:aImage], @"the imageView must be set to aImage");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

#pragma mark - Test Case : WebImageOptionSDWebImage

/**
 Test   :   ImageURLString = nil
            WebImageOption = WebImageOptionSDWebImage
 
 Result :   1.fail
            2.aUrl has to be nil
            3.aImage has to be nil
            4.the imageView set to the placeholder image
 */
- (void)testCaseImageURLStringNil_WebImageOptionSDWebImage {
    NSString *sImageURLString = nil;
    WebImageOption sWebImageOption = WebImageOptionSDWebImage;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTAssertNil(aUrl, @"aUrl has to be nil");
                                       XCTAssertNil(aImage, @"aImage has to be nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:_placeholerImage], @"the imageView must be set to the placeholderImage");
                                   } else {
                                       // success
                                       XCTFail(@"if the imageUrl is nil, the result must be error result");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   ImageURLString = @""
            WebImageOption = WebImageOptionSDWebImage
 
 Result :   1.fail
            2.aUrl has to be not nil
            3.aImage has to be nil
            4.the imageView set to the loadFail image
 */
- (void)testCaseImageURLStringEmpty_WebImageOptionSDWebImage {
    NSString *sImageURLString = @"";
    WebImageOption sWebImageOption = WebImageOptionSDWebImage;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTAssertNotNil(aUrl, @"aUrl has to be not nil");
                                       XCTAssertNil(aImage, @"aImage has to be nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:_loadFailImage], @"the imageView must be set to the loadFailImage");
                                   } else {
                                       // success
                                       XCTFail(@"if the imageUrl is empty, the result must be error result");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   ImageURLString = a incorrect image url
            WebImageOption = WebImageOptionSDWebImage
 
 Result :   1.fail
            2.aUrl has to be not nil
            3.aImage has to be nil
            4.the imageView set to the loadFail image
 */
- (void)testCaseImageURLStringIncorrectly_WebImageOptionSDWebImage {
    NSString *sImageURLString = kImageURLStringIncorrectly;
    WebImageOption sWebImageOption = WebImageOptionSDWebImage;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTAssertNotNil(aUrl, @"aUrl has to be not nil");
                                       XCTAssertNil(aImage, @"aImage has to be nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:_loadFailImage], @"the imageView must be set to the loadFailImage");
                                   } else {
                                       // success
                                       XCTFail(@"if the imageUrl is a incorrect string, the result must be error result");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   ImageURLString = a correct image url
            WebImageOption = WebImageOptionSDWebImage
 
 Result :   1.success
            2.aUrl has to be not nil
            3.aImage has to be not nil
            4.the imageView set to be not nil
 */
- (void)testCaseImageURLStringCorrectly_WebImageOptionSDWebImage {
    NSString *sImageURLString = kImageURLStringCorrectly;
    WebImageOption sWebImageOption = WebImageOptionSDWebImage;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTFail(@"if the imageUrl is a correct string, the result must be success");
                                   } else {
                                       // success
                                       XCTAssertNotNil(aUrl, @"aUrl has to be not nil");
                                       XCTAssertNotNil(aImage, @"aImage has to be not nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:aImage], @"the imageView must be set to aImage");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

#pragma mark - Test Case : WebImageOptionAFNetworking

/**
 Test   :   ImageURLString = nil
            WebImageOption = WebImageOptionAFNetworking
 
 Result :   1.fail
            2.aUrl has to be nil
            3.aImage has to be nil
            4.the imageView set to the placeholder image
 */
- (void)testCaseImageURLStringNil_WebImageOptionAFNetworking {
    NSString *sImageURLString = nil;
    WebImageOption sWebImageOption = WebImageOptionAFNetworking;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTAssertNil(aUrl, @"aUrl has to be nil");
                                       XCTAssertNil(aImage, @"aImage has to be nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:_placeholerImage], @"the imageView must be set to the placeholderImage");
                                   } else {
                                       // success
                                       XCTFail(@"if the imageUrl is nil, the result must be error result");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   ImageURLString = @""
            WebImageOption = WebImageOptionAFNetworking
 
 Result :   1.fail
            2.aUrl has to be not nil
            3.aImage has to be nil
            4.the imageView set to the loadFail image
 */
- (void)testCaseImageURLStringEmpty_WebImageOptionAFNetworking {
    NSString *sImageURLString = @"";
    WebImageOption sWebImageOption = WebImageOptionAFNetworking;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTAssertNotNil(aUrl, @"aUrl has to be not nil");
                                       XCTAssertNil(aImage, @"aImage has to be nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:_loadFailImage], @"the imageView must be set to the loadFailImage");
                                   } else {
                                       // success
                                       XCTFail(@"if the imageUrl is empty, the result must be error result");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   ImageURLString = a incorrect image url
            WebImageOption = WebImageOptionAFNetworking
 
 Result :   1.fail
            2.aUrl has to be not nil
            3.aImage has to be nil
            4.the imageView set to the loadFail image
 */
- (void)testCaseImageURLStringIncorrectly_WebImageOptionAFNetworking {
    NSString *sImageURLString = kImageURLStringIncorrectly;
    WebImageOption sWebImageOption = WebImageOptionAFNetworking;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTAssertNotNil(aUrl, @"aUrl has to be not nil");
                                       XCTAssertNil(aImage, @"aImage has to be nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:_loadFailImage], @"the imageView must be set to the loadFailImage");
                                   } else {
                                       // success
                                       XCTFail(@"if the imageUrl is a incorrect string, the result must be error result");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

/**
 Test   :   ImageURLString = a correct image url
            WebImageOption = WebImageOptionAFNetworking
 
 Result :   1.success
            2.aUrl has to be not nil
            3.aImage has to be not nil
            4.the imageView set to be not nil
 */
- (void)testCaseImageURLStringCorrectly_WebImageOptionAFNetworking {
    NSString *sImageURLString = kImageURLStringCorrectly;
    WebImageOption sWebImageOption = WebImageOptionAFNetworking;
    
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    [_testImageView setImage:nil];
    
    __weak UIImageView *weakImageView = _testImageView;
    [weakImageView setImageWithURLString:sImageURLString
                        placeholderImage:_placeholerImage
                           loadFailImage:_loadFailImage
                                  option:sWebImageOption
                               completed:^(NSURL *aUrl, UIImage *aImage, NSError *aError) {
                                   if (aError) {
                                       // fail
                                       XCTFail(@"if the imageUrl is a correct string, the result must be success");
                                   } else {
                                       // success
                                       XCTAssertNotNil(aUrl, @"aUrl has to be not nil");
                                       XCTAssertNotNil(aImage, @"aImage has to be not nil");
                                       XCTAssertTrue([[weakImageView image] isEqual:aImage], @"the imageView must be set to aImage");
                                   }
                                   [expectation fulfill];
                               }];
    
    [self waitForExpectationsWithTimeout:kTestBlockTimeout handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

@end
