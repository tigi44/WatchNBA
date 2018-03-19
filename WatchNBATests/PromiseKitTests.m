//
//  PromiseKitTests.m
//  WatchNBATests
//
//  Created by tigi on 2018. 3. 19..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <PromiseKit/PromiseKit.h>

@interface PromiseKitTests : XCTestCase

@end

@implementation PromiseKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPromise {
    [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
        id foo = [NSString stringWithFormat:@"resolver test"];
//        foo = [NSError errorWithDomain:@"resolver error" code:-1 userInfo:nil];
        resolver(foo);
    }].catch(^(NSError *error){
        NSLog(@"promiseWithResolverBlock error : %@", error);
    }).then(^(id object) {
        NSLog(@"promiseWithResolverBlock object : %@", object);
        id foo = [NSString stringWithFormat:@"value test"];
        return [AnyPromise promiseWithValue:foo];
//        @throw [NSError errorWithDomain:@"resolver error" code:-1 userInfo:nil];
    }).ensure(^{
        NSLog(@"ensure, after promiseWithValue");
    }).catch(^(NSError *error){
        NSLog(@"promiseWithValue error : %@", error);
    }).then(^(id object) {
        NSLog(@"promiseWithValue object : %@", object);
        return [AnyPromise promiseWithAdapterBlock:^(PMKAdapter adapter) {
            id foo = [NSString stringWithFormat:@"adapter test"];
            NSError *error = nil;
            adapter(foo, error);
        }];
    }).catch(^(NSError *error){
        NSLog(@"promiseWithAdapterBlock error : %@", error);
    }).then(^(id object) {
        NSLog(@"promiseWithAdapterBlock object : %@", object);
    }).ensure(^{
        NSLog(@"ensure");
    });
}

- (void)testWhen {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    // 첫번째 객체는 바로 수행
    AnyPromise *firstPromise = [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
        NSLog(@"first promise");
        id foo = [NSString stringWithFormat:@"first resolver test"];
//        foo = [NSError errorWithDomain:@"resolver error" code:-1 userInfo:nil];
        resolver(foo);
    }];
    // 두번째 객체는 5초후에 수행
    AnyPromise *secondPromise = [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
        dispatch_queue_t q_global   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), q_global, ^{
            NSLog(@"second promise");
            id foo = [NSString stringWithFormat:@"second resolver test"];
//            foo = [NSError errorWithDomain:@"resolver error" code:-1 userInfo:nil];
            resolver(foo);
        });
    }];
    
    PMKWhen(@[firstPromise, secondPromise]).then(^(id object) {
        NSLog(@"PMKWhen object : %@", object);
    }).catch(^(NSError *error){
        NSLog(@"PMKWhen error : %@", error);
    }).ensure(^{
        NSLog(@"ensure");
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

- (void)testAfter {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    // 5초후에 수행
    PMKAfter(5).then(^(id object) {
        NSLog(@"PMKAfter object : %@", object);
        return PMKAfter(2); // 2초후에 다음단계 수행
    }).catch(^(NSError *error){
        NSLog(@"PMKAfter error : %@", error);
    }).ensure(^{
        NSLog(@"ensure");
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

- (void)testjoin {
    NSString *description = [NSString stringWithFormat:@"%s", __FUNCTION__];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    // 첫번째 객체는 바로 수행
    AnyPromise *firstPromise = [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
        NSLog(@"first promise");
        id foo = [NSString stringWithFormat:@"first resolver test"];
//        foo = [NSError errorWithDomain:@"resolver error" code:-1 userInfo:nil];
        resolver(foo);
    }];
    // 두번째 객체는 5초후에 수행
    AnyPromise *secondPromise = [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
        dispatch_queue_t q_global   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), q_global, ^{
            NSLog(@"second promise");
            id foo = [NSString stringWithFormat:@"second resolver test"];
//            foo = [NSError errorWithDomain:@"resolver error" code:-1 userInfo:nil];
            resolver(foo);
        });
    }];
    
    PMKJoin(@[firstPromise, secondPromise]).then(^(id object) {
        NSLog(@"PMKJoin object : %@", object);
    }).catch(^(NSError *error){
        NSLog(@"PMKJoin error : %@", error);
    }).ensure(^{
        NSLog(@"ensure");
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *aError) {
        XCTAssertNil(aError, @"Timeout Error : %@", aError);
    }];
}

- (void)testDispatchQueue {
    // dispatch_get_global_queue(0, 0) 큐에서 새로운 AnyPromise객체를 만든 후 수행
    dispatch_promise(^(id object){
        id foo = [NSString stringWithFormat:@"dispatch_promise test"];
        return [AnyPromise promiseWithValue:foo];
    }).then(^(id object) {
        NSLog(@"dispatch_promise object : %@", object);
    }).catch(^(NSError *error){
        NSLog(@"dispatch_promise error : %@", error);
    }).ensure(^{
        NSLog(@"ensure");
    });
}

- (void)testHang {
    id object = PMKHang([AnyPromise promiseWithValue:[NSString stringWithFormat:@"PMKHang test"]]);
    NSLog(@"PMKHang object : %@", object);
}


@end
