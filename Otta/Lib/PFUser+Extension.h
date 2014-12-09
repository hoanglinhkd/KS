//
//  PFUser+Extension.h
//  Otta
//
//  Created by Gambogo on 12/9/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Parse/Parse.h>

@interface PFUser (Extension)

/*! Local Data - Full Display Name */
-(void) setName:(NSString*) displayName;
/*! Local Data - Full Display Name */
-(NSString*) name;

/* Local Data - Check Facebook User Token */
-(void) setFacebookUserTokenId:(NSString*)facebookUserTokenIdValue;
/*! Local Data - Check Facebook User Token */
-(NSString*) facebookUserTokenId;

/*! Local Data - whether friend or not */
-(void) setIsFriend:(BOOL)isFriendValue;
/*! Local Data - whether friend or not */
-(BOOL) isFriend;

/*! Local Data - Selection State */
-(void) setIsSelected:(BOOL)isSelectedValue;
/*! Local Data - Selection State */
-(BOOL) isSelected;

/*! Server Data - First Name on Server*/
-(void) setFirstName:(NSString*)firstNameValue;
/*! Server Data - First Name on Server*/
-(NSString*) firstName;

/*! Server Data - Last Name on Server*/
-(void) setLastName:(NSString*)lastNameValue;
/*! Server Data - Last Name on Server*/
-(NSString*) lastName;

/*! Server Data - Phone on Server*/
-(void) setPhone:(NSString*)phone;
/*! Server Data - Phone on Server*/
-(NSString*) phone;

@end
