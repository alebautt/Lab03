//
//  TableResults.h
//  Lab03
//
//  Created by Alejandra B on 03/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>


@interface TableResults : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblName;

@property (strong, nonatomic) IBOutlet UITableView *tblView;

@property (strong, nonatomic) IBOutlet UILabel *lblId;
@property (strong, nonatomic) IBOutlet UIButton *btnShared;

@end
