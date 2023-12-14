import Foundation
import CommonCrypto

let keyData = "12345".data(using: .utf8)!
let plaintextData = "4547-7559-8630-9988".data(using: .utf8)!

var encryptedData = Data(count: plaintextData.count + kCCBlockSizeDES)
let cryptStatus = encryptedData.withUnsafeMutableBytes { encryptedBytes in
    plaintextData.withUnsafeBytes { plainBytes in
        keyData.withUnsafeBytes { keyBytes in
            CCCrypt(
                CCOperation(kCCEncrypt),            // Operación: cifrado
                CCAlgorithm(kCCAlgorithmDES),       // Algoritmo: DES
                CCOptions(kCCOptionPKCS7Padding),  // Opciones: relleno PKCS7
                keyBytes.baseAddress,              // Clave
                kCCKeySizeDES,                     // Tamaño de la clave
                nil,                               // Vector de inicialización
                plainBytes.baseAddress,            // Datos a cifrar
                plaintextData.count,               // Tamaño de los datos a cifrar
                encryptedBytes.baseAddress,        // Buffer de salida
                encryptedData.count,               // Tamaño del buffer de salida
                nil                                // Tamaño de los datos cifrados
            )
        }
    }
}

if cryptStatus == kCCSuccess {
    let encryptedString = encryptedData.base64EncodedString()
    print("Datos cifrados: \(encryptedString)")
} else {
    print("Ha ocurrido un error durante el cifrado")
}
