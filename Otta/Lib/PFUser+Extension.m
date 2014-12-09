//
//  PFUser+Extension.m
//  Otta
//
//  Created by Gambogo on 12/9/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "PFUser+Extension.h"

@implementation PFUser (Extension)

/*! Local Data - Full Display Name */
-(void) setName:(NSString*) displayName
{
    [self setObject:displayName forKey:@"name"];
}

/*! Local Data - Full Display Name */
-(NSString*) name
{
    NSString *nameValue = [self objectForKey:@"name"];
    if (nameValue.length <= 0) {
        return [NSString stringWithFormat:@"%@ %@", self[@"firstName"], self[@"lastName"]];
    }
    
    return nameValue;
}

/*! Local Data - Check Facebook User Token */
-(void) setFacebookUserTokenId:(NSString*)facebookUserTokenIdValue
{
    [self setObject:facebookUserTokenIdValue forKey:@"facebookUserTokenId"];
}

/*! Local Data - Check Facebook User Token */
-(NSString*) facebookUserTokenId
{
    return [self objectForKey:@"facebookUserTokenId"];
}

/*! Local Data - whether friend or not */
-(void) setIsFriend:(BOOL)isFriendValue
{
    [self setObject:[NSNumber numberWithBool:isFriendValue] forKey:@"isFriend"];
}

/*! Local Data - whether friend or not */
-(BOOL) isFriend
{
    return [[self objectForKey:@"isFriend"] boolValue];
}

/*! Local Data - Selection State */
-(void) setIsSelected:(BOOL)isSelectedValue
{
    [self setObject:[NSNumber numberWithBool:isSelectedValue] forKey:@"isSelected"];
}

/*! Local Data - Selection State */
-(BOOL) isSelected
{
    return [[self objectForKey:@"isSelected"] boolValue];
}

/*! Server Data - First Name on Server*/
-(void) setFirstName:(NSString*)firstNameValue
{
    [self setObject:firstNameValue forKey:@"firstName"];
}

/*! Server Data - First Name on Server*/
-(NSString*) firstName
{
    return [self objectForKey:@"firstName"];
}

/*! Server Data - Last Name on Server*/
-(void) setLastName:(NSString*)lastNameValue
{
    [self setObject:lastNameValue forKey:@"lastName"];
}

/*! Server Data - Last Name on Server*/
-(NSString*) lastName
{
    return [self objectForKey:@"lastName"];
}

/*! Server Data - Phone on Server*/
-(void) setPhone:(NSString*)phone
{
    [self setObject:phone forKey:@"phone"];
}

-(NSString*) phone
{
    return [self objectForKey:@"phone"];
}
@end
