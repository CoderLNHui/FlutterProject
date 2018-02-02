//
//  LNPageControl.m
//  🔍白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【🔍Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "LNPageControl.h"

@implementation LNPageControl

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat pageW = self.page_W;
    CGFloat clearanceW = (self.frame.size.width - self.subviews.count * pageW) /(self.subviews.count +1);
    for (int i = 0 ; i<self.subviews.count; i++)
    {
        CGFloat pageX = (i + 1) * clearanceW + i * pageW + pageW/2;
        UIImageView *subView = [self.subviews objectAtIndex:i];
        if (i == self.currentPage)
        {
            subView.bounds = CGRectMake(0, 0, pageW+0.5, pageW+0.5);
            subView.center = CGPointMake(pageX, self.frame.size.height /2);
            subView.layer.cornerRadius = (pageW+0.5) / 2;
            subView.layer.masksToBounds = YES;
        }
        else
        {
            subView.bounds = CGRectMake(0, 0, pageW, pageW);
            subView.center = CGPointMake(pageX, self.frame.size.height /2);
            subView.layer.cornerRadius = pageW / 2;
            subView.layer.masksToBounds = YES;
        }
    }
}


@end
