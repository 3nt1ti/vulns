import Foundation
import os.log

func iniciarSesion(usuario: String, pass: String) {
    if verificarCredenciales(usuario: usuario, password: pass) {
        os_log("Inicio de sesión exitoso para el usuario: %{public}s", log: .default, type: .info, usuario)
        // Resto del código para la sesión iniciada...
    } else {
        os_log("Intento de inicio de sesión fallido para el usuario: %{public}s", log: .default, type: .error, filtrarUsuario(usuario))
        // Resto del código para el manejo de inicio de sesión fallido...
    }
}

func filtrarUsuario(_ usuario: String) -> String {
    // Aplicar lógica para filtrar o enmascarar el usuario si es sensible
    // Por ejemplo, podrías devolver "***" o algún otro valor genérico en lugar del nombre de usuario.
    return "***"
}

func verificarCredenciales(usuario: String, password: String) -> Bool {
    // Verificación simulada de credenciales
    return usuario == "usuario_seguro" && password == "password_segura"
}

// Uso
let usuarioIngresado = "usuario_seguro"
let passIngresada = "password"
iniciarSesion(usuario: usuarioIngresado, pass: passIngresada)
