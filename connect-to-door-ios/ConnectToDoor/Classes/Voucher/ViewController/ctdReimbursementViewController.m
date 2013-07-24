//
//  ctdReimbursementViewController.m
//  ConnectToDoor
//
//  Created by Photon Infotech on 7/22/13.
//  Copyright (c) 2013 aldi cita putra. All rights reserved.
//

#import "ctdReimbursementViewController.h"
#import "ctdLocalStorage.h"
#import "ctdProfileService.h"
#import "ctdConstants.h"


@interface ctdReimbursementViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) NSArray *pickerViewArray;
@end


@implementation ctdReimbursementViewController

@synthesize employeeName;
@synthesize employeeID;
@synthesize projectID;
@synthesize dateTodayTxt;

@synthesize toolbarDatePicker;

@synthesize saveBtnDatePicker;
@synthesize cancelBtnDatePicker;

@synthesize datePickerCtrl;

@synthesize datePicker;
@synthesize reimbursementPicker;

@synthesize reimbursementBtn;
@synthesize dateBtn;
@synthesize backBtn;
@synthesize dateTxt;
@synthesize reimbursementTxt;
@synthesize descriptionTxt;
@synthesize quantityTxt;
@synthesize costTxt;




NSString *employeeId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hasSignoutButton = NO;
        self.hasBackButton = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    formView.frame = CGRectMake(100, 85, formView.frame.size.width, formView.frame.size.height);
    [self.view addSubview:formView];
    [self createPicker];
    [self configureAllComponent];
    [self setUserDetail];
    // Do any additional setup after loading the view from its nib.
    scrollView.frame = CGRectMake(0, 0, 891, 586);
    [scrollView setContentSize:CGSizeMake(891, 1269)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUserDetail
{
    ctdLocalStorage *localStorage = [[ctdLocalStorage alloc]init];
    employeeId = localStorage.getEmployeeId;
    ctdProfileService *profileService = [[ctdProfileService alloc] init];
    [profileService handleProfileRequest:EMPLOYEE_ID_PARAMETER :employeeId];
    profileService.delegate = self;
}



- (void)configureAllComponent{
    NSDate *today = [NSDate date];
    self.dateTodayTxt.text = [self.dateFormatter stringFromDate:today];
    
    self.datePicker.hidden = TRUE;
    self.reimbursementPicker.hidden = TRUE;
    self.toolbarDatePicker.hidden = TRUE;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.reimbursementTxt.leftView = paddingView;
    self.reimbursementTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewDatePickerTxt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.dateTxt.leftView = paddingViewDatePickerTxt;
    self.dateTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewDescriptionTxt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.descriptionTxt.leftView = paddingViewDescriptionTxt;
    self.descriptionTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewQuantityTxt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.quantityTxt.leftView = paddingViewQuantityTxt;
    self.quantityTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewCostTxt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.costTxt.leftView = paddingViewCostTxt;
    self.costTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewCaseAdvanceTxt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.cashAdvanceTxt.leftView = paddingViewCaseAdvanceTxt;
    self.cashAdvanceTxt.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)createPicker
{
	self.pickerViewArray = @[ @"Meal", @"Transportation", @"Utility" ];
}

- (IBAction)didDatePickerClicked:(id)sender{
    self.datePicker.hidden = FALSE;
    self.toolbarDatePicker.hidden = FALSE;
    self.reimbursementPicker.hidden = TRUE;
}

- (IBAction)didReimbursementTypeClicked:(id)sender{
    self.reimbursementPicker.hidden = FALSE;
    self.datePicker.hidden = TRUE;
    self.toolbarDatePicker.hidden = TRUE;
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return dateFormatter;
}

- (IBAction)didDatePickerSaveBtnTypeClicked:(id)sender{
    self.dateTxt.text = [self.dateFormatter stringFromDate:self.datePicker.date];
    self.datePicker.hidden = TRUE;
    self.toolbarDatePicker.hidden = TRUE;
}
- (IBAction)didDatePickerCancelBtnTypeClicked:(id)sender{
    self.datePicker.hidden = TRUE;
    self.toolbarDatePicker.hidden = TRUE;
}

- (IBAction)didBackClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma service Profile
- (void)didReceiveProfileResponse:(ctdProfileModel*)profileModel
{
    self.employeeName.text = profileModel.employeeName;
    self.employeeID.text = profileModel.employeeId;
    self.projectID.text = profileModel.projectId;
}

- (void)didReceiveProfileErrorResponse:(NSError*)error{
    
}


#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.reimbursementPicker){
        self.reimbursementTxt.text = [self.pickerViewArray objectAtIndex:row];
        self.reimbursementPicker.hidden = TRUE;
    }
    
}


#pragma mark - UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.pickerViewArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return 240.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.pickerViewArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}



@end
