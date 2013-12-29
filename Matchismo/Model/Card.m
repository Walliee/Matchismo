//
//  Card.m
//  Matchismo
//
//  Created by Anshul Mehra on 12/27/13.
//  Copyright (c) 2013 Anshul Mehra. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
