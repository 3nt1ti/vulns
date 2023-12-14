import CryptoKit

// Función para cifrar datos sensibles
func encryptData(data: Data, key: SymmetricKey) throws -> Data {
    let sealedBox = try AES.GCM.seal(data, using: key)
    return sealedBox.combined!
}

// Función para descifrar datos
func decryptData(encryptedData: Data, key: SymmetricKey) throws -> Data {
    let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
    let decryptedData = try AES.GCM.open(sealedBox, using: key)
    return decryptedData
}

// Ejemplo de uso
func ejemploCrytoKit() {
    let sensitiveInfo = "1234567890" // Información sensible
    let sensitiveData = Data(sensitiveInfo.utf8)

    do {
        let encryptionKey = SymmetricKey(size: .bits256) // Generar una clave de cifrado segura
        let encryptedData = try encryptData(data: sensitiveData, key: encryptionKey)

        // Simulación: enviando datos cifrados a través de la red (simulada)
        // En un escenario real, esto se enviaría a un servidor seguro o almacenado de manera segura
        // y luego se recuperaría cuando sea necesario.

        // Luego, para utilizar los datos nuevamente, se desencriptan
        let decryptedData = try decryptData(encryptedData: encryptedData, key: encryptionKey)
        if let decryptedString = String(data: decryptedData, encoding: .utf8) {
            print("Datos descifrados: \(decryptedString)") // Se mostrarán los datos descifrados
        } else {
            print("No se pudieron decifrar los datos.")
        }
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}

// Llamada al ejemplo de uso
ejemploCrytoKit()
