//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Anshul Mehra on 12/28/13.
//  Copyright (c) 2013 Anshul Mehra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, getter = is3CardMode) BOOL mode;

@end
