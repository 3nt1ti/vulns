import Foundation
import CommonCrypto

func cifrarDatosConAES(plaintext: String, clave: String) -> Data? {
    // Convertir la cadena de clave a datos
    guard let claveData = clave.data(using: .utf8) else {
        return nil
    }

    // Verificar si la longitud de la clave es suficiente (esto es un ejemplo de lo que NO se debe hacer)
    if claveData.count < kCCKeySizeAES128 {
        print("Advertencia: La longitud de la clave es insuficiente para un cifrado seguro.")
    }

    // Convertir la cadena de texto plano a datos
    guard let plaintextData = plaintext.data(using: .utf8) else {
        return nil
    }

    // Realizar cifrado AES con una clave débil
    var cipherText = Data(count: plaintextData.count + kCCBlockSizeAES128)
    var numBytesEncrypted: size_t = 0

    let cryptStatus = cipherText.withUnsafeMutableBytes { cipherTextBytes in
        SecKeyEncrypt(nil, .none, plaintextData.withUnsafeBytes { $0.baseAddress }, plaintextData.count,
                      cipherTextBytes.baseAddress, &numBytesEncrypted)
    }

    guard cryptStatus == errSecSuccess else {
        print("Error al cifrar los datos.")
        return nil
    }

    // Devolver los datos cifrados
    return cipherText
}
