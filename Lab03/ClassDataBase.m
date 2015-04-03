//
//  ClassDataBase.m
//  Lab03
//
//  Created by Alejandra B on 03/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import "ClassDataBase.h"

static NSString    *DBFile = @"contacto.db";
static const char  *CreateTable  = "create table if not exists datos (id integer primary key autoincrement, nombre text, estado text, video text, imagen blob)";
static NSString    *insertScores = @"insert into datos (nombre, estado, video, imagen) values (\"%@\",\"%@\",\"%@\",\"%@\")";

static NSString    *updateScores = @"update datos set nombre=\"%@\", estado=\"%@\", video=\"%@\" where id=27)";

static NSString    *DeleteData = @"delete from datos where id=(\"%@\")";
static ClassDataBase *sharedInstance = nil;
static sqlite3         *database = nil;
static sqlite3_stmt   *statement = nil;

@implementation ClassDataBase
+(ClassDataBase*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

//create my data base
-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    DBpath = [[NSString alloc] initWithString:
              [docsDir stringByAppendingPathComponent: DBFile ]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: DBpath ] == NO)
    {
        const char *dbpath = [DBpath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = CreateTable;
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table %s",errMsg);
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}


- (BOOL) saveData: (NSString*) nombre estado:(NSString*) estado video:(NSString*) video imagen:(NSString*) imagen;
{
    const char *dbpath = [DBpath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: insertScores, nombre, estado, video, imagen];
       const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_reset(statement);
            NSLog(@"Se ha guardado");
            NSLog(@"insert_stmt: (%s)",insert_stmt);
            return YES;
        }
        else {
            NSLog(@"Statement FAILED (%s)", sqlite3_errmsg(database));
            sqlite3_reset(statement);
            return NO;
        }
    }
    return NO;
}


- (BOOL) editData: (NSString*) nombre estado:(NSString*) estado video:(NSString*) video imagen:(NSString*) imagen ide:(NSString*) ide;
{
    NSLog(@"Entra al metodo edit");
    const char *dbpath = [DBpath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSLog(@"%@",ide);
        NSString *upddateSQL = [NSString stringWithFormat: updateScores, nombre, estado, video, ide];
        NSLog(@"%@", upddateSQL);
        
        const char *updat_stmt = [upddateSQL UTF8String];
        sqlite3_prepare_v2(database, updat_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_reset(statement);
            NSLog(@"Se ha nodificado");
          //  NSLog(@"updat_stmt: (%s)",insert_stmt);
            return YES;
        } else {
            NSLog(@"Statement FAILED (%s)", sqlite3_errmsg(database));
            sqlite3_reset(statement);
            return NO;
        }
    }
    return NO;
}

- (BOOL) deleteData: (NSString*) ide;
{
    const char *dbpath = [DBpath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
      NSString *deleteSQL = [NSString stringWithFormat: DeleteData, ide];
      const char *delet_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(database, delet_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_reset(statement);
            NSLog(@"Se ha eliminado");
           // NSLog(@"insert_stmt: (%s)",insert_stmt);
            return YES;
        } else {
            NSLog(@"Statement FAILED (%s)", sqlite3_errmsg(database));
            sqlite3_reset(statement);
            return NO;
        }
    }
    return NO;
}


- (NSArray*) findByRegisterNumber:(NSString*)registerNumber
{
    NSLog(@"estoy en findbyregisternoomber");
    
    const char *dbpath = [DBpath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select id, nombre, estado, video from datos where id=\"%@\"",registerNumber];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *ide = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:ide];
                NSString *nombre = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:nombre];
                NSString *estado = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:estado];
                
                NSString *video = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 3)];
                [resultArray addObject:video];
              //  NSString *imagen = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 4)];
              //  [resultArray addObject:imagen];
                sqlite3_reset(statement);
                return resultArray;
            }
            else {
                NSLog(@"Not found");
                sqlite3_reset(statement);
                return nil;
            }
        }
    }
    return nil;
}



-(NSArray*) allRecords{
    const char *dbpath = [DBpath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select id, nombre, estado, video from datos"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *ide = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                //[resultArray addObject:nombre];
                
                NSString *nombre = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)];
                //[resultArray addObject:nombre];
                NSString *estado = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 2)];
                //[resultArray addObject:estado];
       
                NSString *video = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 3)];
                //[resultArray addObject:estado];
                
            //     NSString *imagen = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 4)];
                   [resultArray addObject:[NSMutableArray arrayWithObjects: ide, nombre, estado, video, nil]];
            }
            sqlite3_reset(statement);
            return resultArray;
        }
    }
    return nil;
}
@end
