//
//  Card.h
//  Matchismo
//
//  Created by Anshul Mehra on 12/27/13.
//  Copyright (c) 2013 Anshul Mehra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
