//
//  NetworkError.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 29/8/23.
//

import Foundation

public enum NetworkError: Error {
    
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case nonHTTP
    case unknown
    case requestCancel
    
    public var description: String {
        switch self {
        case .general(let error):
            return "Error general: \(error.localizedDescription)"
        case .status(let status):
            return "Error de status: \(status)"
        case .json(let json):
            return "Error en el JSON: \(json)"
        case .dataNotValid:
            return "Dato no válido"
        case .nonHTTP:
            return "No es una conexión HTTP"
        case .unknown:
            return "Error desconocido"
        case .requestCancel:
            return "Llamada cancelada"
        }
    }
}
