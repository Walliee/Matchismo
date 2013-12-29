//
//  PlayingCard.h
//  Matchismo
//
//  Created by Anshul Mehra on 12/27/13.
//  Copyright (c) 2013 Anshul Mehra. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
