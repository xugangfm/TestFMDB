//
//  ViewController.m
//  TestFMDB
//
//  Created by xugang on 8/10/14.
//  Copyright (c) 2014 RongCloud. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@end

sqlite3 *database;


@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if ([db open]) {
       NSLog(@" open db ok .");
    }else{
         NSLog(@"Could not open db.");
    }
    
    [db executeUpdate:@"CREATE TABLE PersonList (Name text, Age integer, Sex integer, Phone text, Address text, Photo blob)"];
    
    //[db executeUpdate:@"INSERT INTO PersonList (Name, Age, Sex, Phone, Address, Photo) VALUES (?,?,?,?,?,?)",@"Jone", [NSNumber numberWithInt:20], [NSNumber numberWithInt:0], @"091234567", @"Taiwan, R.O.C", [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    
    FMResultSet *rs = [db executeQuery:@"SELECT Name, Age FROM PersonList"];
    
    while ([rs next]) {
        NSString *name = [rs stringForColumn:@"Name"];
        int age = [rs intForColumn:@"Age"];
        
        NSLog(@"name%@:%d",name,age);
    }
    [rs close];
    
    [db close];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
//    
//    NSSet* myset;
//    
//    myset = [NSSet setWithObjects:@"abc",[NSNumber numberWithInt:8], nil];
//    
//    NSLog(@"%@",myset);
//    
//    NSLog(@"%@",[myset anyObject]);
    
    NSLog(@"%@",@"**********************\n");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    
    if ((sqlite3_open([dbPath UTF8String], &database)) == SQLITE_OK) {
        NSLog(@"open database succeed.");
    }
    
    
    NSString *sqlString=@"SELECT Name, Age FROM PersonList";
    

    sqlite3_stmt *stmt;
    
    if (sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            char *__name= (char*)sqlite3_column_text(stmt, 0);
            
            printf("%s\n",__name);
            
        }
    }
    
    sqlite3_finalize(stmt);
    
    sqlite3_close(database);
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
