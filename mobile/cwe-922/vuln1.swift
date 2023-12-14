import Foundation

// Ejemplo de almacenamiento no seguro de contraseña
func almacenarContraseñaNoSegura(contraseña: String) {
    
    UserDefaults.standard.set(contraseña, forKey: "contraseña")
}

// Ejemplo de recuperación no segura de contraseña
func recuperarContraseñaNoSegura() -> String? {
    
    return UserDefaults.standard.string(forKey: "contraseña")
}

// Ejemplo de uso
let contraseñaUsuario = "contraseña123"

// Almacenar la contraseña de manera no segura
almacenarContraseñaNoSegura(contraseña: contraseñaUsuario)

if let contraseñaRecuperada = recuperarContraseñaNoSegura() {
    print("Contraseña recuperada de manera no segura: \(contraseñaRecuperada)")
} else {
    print("No se pudo recuperar la contraseña.")
}
