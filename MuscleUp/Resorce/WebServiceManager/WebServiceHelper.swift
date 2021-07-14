//
//  WebServiceHelper.swift
//  Somi
//
//  Created by Paras on 24/03/21.
//

import Foundation
import UIKit


let BASE_URL = "https://ambitious.in.net/Shubham/muscle/index.php/api/"//Live

struct WsUrl{
    static let url_SignUp  = BASE_URL + "register?"
    static let url_getBanner  = BASE_URL + "get_banner"
    static let url_getCategory = BASE_URL + "get_category?"
    static let url_Login  = BASE_URL + "login"
    static let url_getProfile = BASE_URL + "get_profile?"
    static let url_getMealsPlan = BASE_URL + "get_meal_plan"
    static let url_getMealsPlanID = BASE_URL + "get_meals?"
    static let url_getCity = BASE_URL + "get_city?"
    static let url_completeProfile = BASE_URL + "complete_profile"
    static let url_forgotPassword = BASE_URL + "forgot_password"
    static let url_updateProfile = BASE_URL + "update_profile"
    static let url_Logout = BASE_URL + "logout?"
    static let url_notificationSend = BASE_URL + "send_notification?"
    static let url_getSubscriptionList = BASE_URL + "get_membership_plan"
    static let url_validatePurchase = BASE_URL + "purchase_a_plan?"
}

//Api Header

struct WsHeader {

    //Login

    static let deviceId = "Device-Id"

    static let deviceType = "Device-Type"

    static let deviceTimeZone = "Device-Timezone"

    static let ContentType = "Content-Type"

}



//Api parameters

struct WsParam {

    

    static let itunesSharedSecret : String = "cbce81e48793457e80b00062c1a77090"

    //Signup

    static let dialCode = "dialCode"

    static let contactNumber = "contactNumber"

    static let code = "code"

    static let deviceToken = "deviceToken"

    static let deviceType = "deviceType"

    static let firstName = "firstName"

    static let lastName = "lastName"

    static let email = "email"

    static let driverImage = "driverImage"

    static let isSignup = "isSignup"

    static let licenceImage = "licenceImage"

    static let socialId = "socialId"

    static let socialType = "socialType"

    static let imageUrl = "image_url"

    static let invitationId = "invitationId"

    static let status = "status"

    static let companyId = "companyId"

    static let vehicleId = "vehicleId"

    static let type = "type"

    static let bookingId = "bookingId"

    static let location = "location"

    static let latitude = "latitude"

    static let longitude = "longitude"

    static let currentdate_time = "current_date_time"

}



//Api check for params

struct WsParamsType {

    static let PathVariable = "Path Variable"

    static let QueryParams = "Query Params"

}
