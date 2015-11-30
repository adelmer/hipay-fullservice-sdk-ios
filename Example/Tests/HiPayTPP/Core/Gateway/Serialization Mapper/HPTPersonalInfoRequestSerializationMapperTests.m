//
//  HPTPersonalInfoRequestSerializationMapperTests.m
//  HiPayTPP
//
//  Created by Jonathan TIRET on 14/10/2015.
//  Copyright © 2015 Jonathan TIRET. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HiPayTPP/HPTPersonalInfoRequestSerializationMapper.h>
#import <HiPayTPP/HPTAbstractSerializationMapper+Encode.h>

@interface HPTPersonalInfoRequestSerializationMapperTests : XCTestCase

@end

@implementation HPTPersonalInfoRequestSerializationMapperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSerialization
{
    HPTPersonalInfoRequest *personalInfo = [[HPTPersonalInfoRequest alloc] init];
    
    OCMockObject *mockedMapper = [OCMockObject partialMockForObject:[[HPTPersonalInfoRequestSerializationMapper alloc] initWithRequest:personalInfo]];
    HPTPersonalInfoRequestSerializationMapper *mapper = (HPTPersonalInfoRequestSerializationMapper *)mockedMapper;

    [[[mockedMapper expect] andReturn:@"John"] getStringForKey:@"firstname"];
    [[[mockedMapper expect] andReturn:@"Doe"] getStringForKey:@"lastname"];
    [[[mockedMapper expect] andReturn:@"14 Boulevard Arago"] getStringForKey:@"streetAddress"];
    [[[mockedMapper expect] andReturn:@"Bâtiment B"] getStringForKey:@"streetAddress2"];
    [[[mockedMapper expect] andReturn:@"Dr Doe"] getStringForKey:@"recipientInfo"];
    [[[mockedMapper expect] andReturn:@"Paris"] getStringForKey:@"city"];
    [[[mockedMapper expect] andReturn:@"Île-de-France"] getStringForKey:@"state"];
    [[[mockedMapper expect] andReturn:@"75013"] getStringForKey:@"zipCode"];
    [[[mockedMapper expect] andReturn:@"France"] getStringForKey:@"country"];
    
    NSDictionary *result = mapper.serializedRequest;
    
    XCTAssertEqualObjects([result objectForKey:@"firstname"], @"John");
    XCTAssertEqualObjects([result objectForKey:@"lastname"], @"Doe");
    XCTAssertEqualObjects([result objectForKey:@"streetaddress"], @"14 Boulevard Arago");
    XCTAssertEqualObjects([result objectForKey:@"streetaddress2"], @"Bâtiment B");
    XCTAssertEqualObjects([result objectForKey:@"recipientinfo"], @"Dr Doe");
    XCTAssertEqualObjects([result objectForKey:@"city"], @"Paris");
    XCTAssertEqualObjects([result objectForKey:@"state"], @"Île-de-France");
    XCTAssertEqualObjects([result objectForKey:@"zipcode"], @"75013");
    XCTAssertEqualObjects([result objectForKey:@"country"], @"France");
    
    [mockedMapper verify];
}

@end