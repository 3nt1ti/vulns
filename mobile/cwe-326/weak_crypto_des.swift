import CommonCrypto

// Función para cifrar datos sensibles con DES
func encryptWithDES(data: Data, key: Data, iv: Data) -> Data? {
    let bufferSize = data.count + kCCBlockSizeDES
    var buffer = [UInt8](repeating: 0, count: bufferSize)
    var numBytesEncrypted = 0

    let cryptStatus = key.withUnsafeBytes { keyBytes in
        data.withUnsafeBytes { dataBytes in
            iv.withUnsafeBytes { ivBytes in
                CCCrypt(
                    CCOperation(kCCEncrypt),
                    CCAlgorithm(kCCAlgorithmDES),
                    CCOptions(kCCOptionPKCS7Padding),
                    keyBytes.baseAddress, key.count,
                    ivBytes.baseAddress,
                    dataBytes.baseAddress, data.count,
                    &buffer, bufferSize,
                    &numBytesEncrypted
                )
            }
        }
    }

    guard cryptStatus == kCCSuccess else {
        print("Error en la encriptación: \(cryptStatus)")
        return nil
    }

    return Data(buffer.prefix(numBytesEncrypted))
}

// Función para descifrar datos cifrados con DES
func decryptWithDES(data: Data, key: Data, iv: Data) -> Data? {
    let bufferSize = data.count + kCCBlockSizeDES
    var buffer = [UInt8](repeating: 0, count: bufferSize)
    var numBytesDecrypted = 0

    let cryptStatus = key.withUnsafeBytes { keyBytes in
        data.withUnsafeBytes { dataBytes in
            iv.withUnsafeBytes { ivBytes in
                CCCrypt(
                    CCOperation(kCCDecrypt),
                    CCAlgorithm(kCCAlgorithmDES),
                    CCOptions(kCCOptionPKCS7Padding),
                    keyBytes.baseAddress, key.count,
                    ivBytes.baseAddress,
                    dataBytes.baseAddress, data.count,
                    &buffer, bufferSize,
                    &numBytesDecrypted
                )
            }
        }
    }

    guard cryptStatus == kCCSuccess else {
        print("Error en la desencriptación: \(cryptStatus)")
        return nil
    }

    return Data(buffer.prefix(numBytesDecrypted))
}

// Ejemplo de uso
func ejemploDES() {
    let sensitiveInfo = "4547-7559-8630-9988" // Información sensible (solo un ejemplo)
    let sensitiveData = Data(sensitiveInfo.utf8)

    let key = "secretKey" // Clave de cifrado DES (8 bytes)
    let iv = "01234567" // Vector de inicialización (8 bytes)

    guard let keyData = key.data(using: .utf8), let ivData = iv.data(using: .utf8) else {
        print("Error al generar datos de clave o IV")
        return
    }

    // Cifrar datos
    if let encryptedData = encryptWithDES(data: sensitiveData, key: keyData, iv: ivData) {
        // Simulación: enviando datos cifrados a través de la red (simulada)
        // En un escenario real, esto se enviaría a un servidor seguro o almacenado de manera segura
        // y luego se recuperaría cuando sea necesario.

        // Luego, para utilizar los datos nuevamente, se desencriptan
        if let decryptedData = decryptWithDES(data: encryptedData, key: keyData, iv: ivData),
           let decryptedString = String(data: decryptedData, encoding: .utf8) {
            print("Datos descifrados: \(decryptedString)") // Mostrar los datos descifrados
        } else {
            print("No se pudieron decifrar los datos.")
        }
    } else {
        print("Error al cifrar los datos.")
    }
}

// Llamada al ejemplo de uso
ejemploDES()
