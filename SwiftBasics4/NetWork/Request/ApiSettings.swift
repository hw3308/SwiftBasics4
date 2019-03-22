//
// ApiWrapper.swift
// RHCT
//
// Created by Cator Vee on 12/9/15.
// Copyright © 2015 Ledong. All rights reserved.
//

import Foundation

protocol ApiSettings {

    func baseURL() -> String

    func buiWebLink(_ path: String) -> String

}

