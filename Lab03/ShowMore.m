//
//  ShowMore.m
//  Lab03
//
//  Created by Alejandra B on 06/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import "ShowMore.h"

@implementation ShowMore

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)viewDidLoad{
    
        
    NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/watch?v=4azEx8NII10"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wvMore loadRequest:request];
}
@end
