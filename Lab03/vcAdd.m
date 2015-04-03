//
//  vcAdd.m
//  Lab03
//
//  Created by Alejandra B on 03/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import "vcAdd.h"
#import "ClassDataBase.h"
#import "VarGlobal.h"

UIAlertView *alert;
NSString *msgAdd;
NSString *salir;

@interface vcAdd ()

@end

@implementation vcAdd

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%d",intFlag);
    
    if(intFlag == 1){
        self.lblGuardar.text=@"Guardar";
        guarda=@"Guardar";
        [self Save];
    }
    else if(intFlag==2){
        self.lblGuardar.text=@"Modificar";
        guarda=@"Modificar";

        self.txtName.text = nom;
        self.txtStatus.text=estad;
        self.txtVideo.text=vide;
        self.lblId.text=idee;
        
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Save{
    BOOL success = NO;
    success = [[ClassDataBase getSharedInstance]
                saveData:self.txtName.text
               estado:self.txtStatus.text
               video:self.txtVideo.text
            //   imagen:@"image"
              imagen:UIImagePNGRepresentation(self.imgPhoto.image)];
}

-(void)Updat{
    BOOL success = NO;
    success =
    [[ClassDataBase getSharedInstance]
            editData:self.txtName.text
               estado:self.txtStatus.text
               video:self.txtVideo.text
     imagen:UIImagePNGRepresentation(self.imgPhoto.image)
            ide:self.lblId.text];
    
}

- (IBAction)btnSave:(id)sender {
       if([self.txtName.text  isEqual: @""])
       {msgAdd = @"Captura el campo: Nombre";
        [self msgAlert];
        }
       else if([self.txtStatus.text  isEqual: @""])
       {msgAdd = @"Captura el campo: Status";
           [self msgAlert];
       }
       else if([self.txtVideo.text  isEqual: @""])
        {
            msgAdd = @"Captura el campo: Video";
            [self msgAlert];
        }
       else{
            if(intFlag==1){
               NSLog(@"guardado");
               [self Save];
               msgAdd = @"Guardado Correctamente";
            }
           if(intFlag==2){
               [self Updat];
               
             //  NSLog(@"modificado");
           }
           
           
           [self msgAlert];
           self.txtName.text = @"";
           self.txtStatus.text = @"";
           self.txtVideo.text = @"";
           self.imgPhoto.image = [UIImage imageNamed:@""];
                 }
}
-(void) msgAlert{
    alert = [[UIAlertView alloc] initWithTitle:@"Alerta sistema"
                                       message: msgAdd
                                      delegate:self
                             cancelButtonTitle:@"ok"
                             otherButtonTitles:nil];
    [alert show];
}
-(void) msgAlertAction{
    alert = [[UIAlertView alloc] initWithTitle:@"Foto de perfil"
                                       message:@""
                                      delegate:self
                             cancelButtonTitle:@"Cancelar"
                             otherButtonTitles:@"Usar camara",@"Galeria",nil];
    [alert show];
}





- (IBAction)btnImg:(id)sender
{
    [self msgAlertAction];
    
}
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
    {
     if(buttonIndex==1)
     {
         NSLog(@"estas en el simulador");
         UIImagePickerController *picker = [[UIImagePickerController alloc] init];
         picker.delegate = self;
         picker.allowsEditing = YES;
         picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
         
     }
     else if(buttonIndex==2){
         UIImagePickerController *picker = [[UIImagePickerController alloc] init];
         picker.delegate = self;
         picker.allowsEditing = YES;
         picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
         [self presentViewController:picker animated:YES completion:NULL];
     }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imgPhoto.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"%ld", picker.sourceType);
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *datos = globalArray[indexPath.row];
    self.txtName.text = [datos objectAtIndex:1];
    self.txtStatus.text = [datos objectAtIndex:2];
    self.txtVideo.text = [datos objectAtIndex:3];

    //self.txtName.text = [datos objectAtIndex:0];

 //   .lblName.text = record[RECORD_NAME];
   // cell.lblStatus.text = record[RECORD_STATUS];
    //cell.imgPhoto.image = [UIImage imageWithData:record[RECORD_IMAGE]];
    return 0;
}
- (IBAction)btnBack:(id)sender {
    
}

@end
