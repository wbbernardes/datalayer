//
//  APIError.swift
//
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation

enum APIError: Error {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case serverError // 500
    case unknown
}
