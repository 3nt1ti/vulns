func iniciarSesion(usuario: String, pass: String) {
    print("iniciarSesion")

    if verificarCredenciales(usuario: usuario, password: pass) {
        print("exito a log")
        // Registro de inicio de sesión exitoso utilizando CocoaLumberjack
        DDLogInfo("Inicio de sesión exitoso para el usuario: \(mascararUsuario(usuario))")
        // Resto del código para la sesión iniciada...
    } else {
        print("fallo a log")
        // Registro de intento fallido utilizando CocoaLumberjack
        DDLogWarn("Intento de inicio de sesión fallido para el usuario: \(mascararUsuario(usuario))")
        // Resto del código para el manejo de inicio de sesión fallido...
    }
}

func mascararUsuario(_ usuario: String) -> String {
    // Aquí podrías aplicar lógica para enmascarar o filtrar el usuario si es sensible
    // Por ejemplo, podrías devolver "***" o algún otro valor genérico en lugar del nombre de usuario.
    return "***"
}

func verificarCredenciales(usuario: String, password: String) -> Bool {
    // Validación simulada (¡Este es solo un ejemplo y no debe utilizarse en un entorno real!)
    return usuario == "usuario_seguro" && password == "password_segura"
}


// Ejemplo de uso
let usuarioIngresado = "usuario_seguro"
let passIngresada = "password_segura"

iniciarSesion(usuario: usuarioIngresado, pass: passIngresada)
