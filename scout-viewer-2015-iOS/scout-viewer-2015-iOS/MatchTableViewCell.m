//
//  TableViewCell.m
//  scout-viewer-2015-iOS
//
//  Created by Citrus Circuits on 2/8/15.
//  Copyright (c) 2015 Citrus Circuits. All rights reserved.
//

#import "MatchTableViewCell.h"

@implementation MatchTableViewCell

- (NSArray *)teamFields {
    return [[NSArray alloc] initWithObjects:self.redOneLabel, self.redTwoLabel, self.redThreeLabel, self.blueOneLabel, self.blueTwoLabel, self.blueThreeLabel, nil];
}

@end
