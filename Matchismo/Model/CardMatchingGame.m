//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Anshul Mehra on 12/28/13.
//  Copyright (c) 2013 Anshul Mehra. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
//@property (nonatomic, strong) NSMutableSet *othercards;


@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init]; //super's degignated initializer
    
    if (self) {
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!self.is3CardMode){
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            } else {
                //match against other chosen card
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched){
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        break; // can only chose 2 cards for now
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    } else if (self.is3CardMode){
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            } else {
                NSMutableArray *otherCards = [NSMutableArray array];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched && ![otherCard isEqual:card]){
                        [otherCards addObject:otherCard];
                    }
                }
                if ([otherCards count] == 2){
                    int matchScore = [card match:otherCards];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        for (Card *otherCard in otherCards) otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *otherCard in otherCards) otherCard.chosen = NO;
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }
    
}

@end
