//
//  TableResults.m
//  Lab03
//
//  Created by Alejandra B on 03/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import "TableResults.h"
#import "VarGlobal.h"
#import "CellResults.h"
#import "ClassDataBase.h"
int position=2;
NSInteger seleccionado;

UIAlertView     *alert;
NSString *accion;
NSMutableArray *ref;

@interface TableResults ()

@end

@implementation
TableResults

- (void)viewDidLoad {
    
    [super viewDidLoad];
  //  [self initController];
    globalArray = [NSMutableArray arrayWithArray:[[ClassDataBase getSharedInstance]allRecords]];
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
 //   [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return globalArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *datos = globalArray[indexPath.row];
    idee   = [datos objectAtIndex:0];
    nom   = [datos objectAtIndex:1];
             // stringByAppendingString: @" Fue seleccionado"];
   estad   = [datos objectAtIndex:2];
vide   = [datos objectAtIndex:3];
 //   imag   = [datos objectAtIndex:4];
    NSLog(@"este es el estado: %@", [datos objectAtIndex:2]);
    NSLog(@"este es el ide: %@", idee);
    [self msgAlert];
}
-(void)msgAlert{
    alert = [[UIAlertView alloc] initWithTitle:@"Alerta Sistema"
                                       message:nom
                                      delegate:self
                             cancelButtonTitle:@"Cancelar"
                             otherButtonTitles:@"Eliminar", @"Editar", @"Ver mas",@"Compartir",nil];
    [alert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69;
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
       if(buttonIndex==1){//Eliminar
        [self Delet];
     }
   else if(buttonIndex==2){//editar
       [self performSegueWithIdentifier:@"segueEditar" sender:self];
        }
    else if(buttonIndex==3){//ver
        [self performSegueWithIdentifier:@"segueMore" sender:self];
        NSLog(@"el nombre es: %@",nom);
    }
    else if(buttonIndex==4){//compartir
        [self Compartir];
    }
}


-(void)Compartir{
    NSString                    *strMsg;
    NSArray                     *activityItems;
    //  UIImage                     *imgShare;
    UIActivityViewController    *actVC;
    
    //  imgShare = [UIImage imageNamed:@"chavo.png"];
    strMsg = [self.lblName.text stringByAppendingString: @" fué seleccionado"];
    
    activityItems = @[strMsg];
    
    //Init activity view controller
    actVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    actVC.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeAirDrop, nil];
    
    [self presentViewController:actVC animated:YES completion:nil];
    
    
    

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellResults";
    CellResults *cell = (CellResults *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CellResults alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSMutableArray *datos = globalArray[indexPath.row];
    cell.lblId.text      = [datos objectAtIndex:0];
    cell.lblName.text       = [datos objectAtIndex:1];
    cell.lblStatus.text      = [datos objectAtIndex:2];
  //  cell.imageView.image =[datos objectAtIndex:4];
 //   NSLog(@"nombre %@ estado %@", [datos objectAtIndex:0],[datos objectAtIndex:1]);
     return cell;
}

-(void)Delet{
   BOOL success = NO;
    success = [[ClassDataBase getSharedInstance]
               deleteData:idee];
}

-(void)refresh
{
    //ref = [[NSMutableArray alloc] init];
    
}

- (IBAction)btnShared:(id)sender {
    NSLog(@"comp");
    NSString                    *strMsg;
    NSArray                     *activityItems;
  //  UIImage                     *imgShare;
    UIActivityViewController    *actVC;
    
  //  imgShare = [UIImage imageNamed:@"chavo.png"];
    strMsg = [self.lblName.text stringByAppendingString: @" fué seleccionado"];
    
    activityItems = @[strMsg];
    
    //Init activity view controller
    actVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    actVC.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeAirDrop, nil];
    
    [self presentViewController:actVC animated:YES completion:nil];

}
  @end

