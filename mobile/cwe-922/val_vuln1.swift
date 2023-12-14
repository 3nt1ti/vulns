import Foundation
import CryptoKit

// Función para almacenar la contraseña de manera segura
func almacenarContraseñaSegura(contraseña: String) {    
    let sal = "s4ltF0rH4sh1ng"  // Genera una sal única para cada usuario
    let contraseñaConSal = contraseña + sal

    if let hashedData = hashString(data: contraseñaConSal) {
        UserDefaults.standard.set(hashedData, forKey: "hashedPassword")
    }
}

// Función para recuperar la contraseña de manera segura
func recuperarContraseñaSegura() -> String? {
    if let hashedData = UserDefaults.standard.data(forKey: "hashedPassword"),
       let contraseñaRecuperada = String(data: hashedData, encoding: .utf8) {
        return contraseñaRecuperada
    }
    return nil
}

// Función para aplicar hash a una cadena de texto
func hashString(data: String) -> Data? {
    return SHA256.hash(data: data.data(using: .utf8)!).data
}

// Ejemplo de uso
let contraseñaUsuario = "contraseña123"

// Almacenar la contraseña de manera segura
almacenarContraseñaSegura(contraseña: contraseñaUsuario)

// Recuperar la contraseña de manera segura
if let contraseñaRecuperada = recuperarContraseñaSegura() {
    print("Contraseña recuperada de manera segura: \(contraseñaRecuperada)")
} else {
    print("No se pudo recuperar la contraseña.")
}
