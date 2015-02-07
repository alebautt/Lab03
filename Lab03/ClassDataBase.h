//
//  ClassDataBase.h
//  Lab03
//
//  Created by Alejandra B on 03/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
int score;


@interface ClassDataBase : NSObject
{
    NSString *DBpath;
}


+(ClassDataBase*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)saveData:(NSString*)nombre estado:(NSString*)estado video:(NSString*)video imagen:(NSString*)imagen;
-(BOOL)deleteData:(NSString*)ide;
-(BOOL)editData:(NSString*)ide;

-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;
-(NSArray*) allRecords;


@end
