//
//  ApiError.swift
//  RHCT
//
//  Created by Cator Vee on 12/9/15.
//  Copyright © 2015 Ledong. All rights reserved.
//

import Foundation

enum ApiError: Error {
    
	case httpRequestError(status: Int)
    
	case apiError(message: String)
    
	case dataError
}
