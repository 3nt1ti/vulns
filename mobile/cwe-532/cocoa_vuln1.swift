import Foundation
import CocoaLumberjack

// Configuración de CocoaLumberjack
DDLog.add(DDOSLogger.sharedInstance) // Salida de logs en la consola

let fileLogger: DDFileLogger = DDFileLogger() // Salida de logs en archivos
fileLogger.rollingFrequency = TimeInterval(60 * 60 * 24) // Un nuevo archivo de log cada 24 horas

// Crear un filtro para evitar que las entradas que contienen contraseñas lleguen al log
let sensitiveDataFilter = DDBlacklistFilter(logFormatter: nil)
sensitiveDataFilter.add(.password)
fileLogger.add(sensitiveDataFilter)

DDLog.add(fileLogger)


func iniciarSesion(usuario: String, pass: String) {
    print("iniciarSesion")

    if verificarCredenciales(usuario: usuario, password: pass) {
        print("exito a log")
        // Registro de inicio de sesión exitoso utilizando CocoaLumberjack
        DDLogInfo("Inicio de sesión exitoso para el usuario: \(usuario)")
        // Resto del código para la sesión iniciada...
    } else {
        print("fallo a log")
        // Registro de intento fallido utilizando CocoaLumberjack
        DDLogWarn("Intento de inicio de sesión fallido para el usuario: \(usuario)")
        // Resto del código para el manejo de inicio de sesión fallido...
    }
}

func verificarCredenciales(usuario: String, password: String) -> Bool {
    // Validación simulada (¡Este es solo un ejemplo y no debe utilizarse en un entorno real!)
    return usuario == "usuario_seguro" && password == "password_segura"
}

func registrarEnArchivoDeLog(_ mensaje: String) {
    // Registro en un archivo de log (ERROR: incluye información sensible en el registro)
    let rutaArchivoLog = obtenerRutaDelArchivoDeLog()
    print(rutaArchivoLog)
    do {
        try mensaje.appendLineToURL(fileURL: rutaArchivoLog)
    } catch {
        print("Error al escribir en el archivo de log: \(error)")
    }
}

func obtenerRutaDelArchivoDeLog() -> URL {
    // Ruta ficticia para el archivo de log (solo para fines demostrativos)
    // En un entorno real, se debe especificar una ubicación segura y adecuada para el archivo de log.
    let directorioDocumentos = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return directorioDocumentos.appendingPathComponent("archivo_log.txt")
}

extension String {
    // Extensión para agregar una línea a un archivo
    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }

    // Extensión para agregar texto a un archivo
    func appendToURL(fileURL: URL) throws {
        try self.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
    }
}

// Ejemplo de uso
let usuarioIngresado = "usuario_seguro"
// let passIngresada = "password_segura"
let passIngresada = "password"
iniciarSesion(usuario: usuarioIngresado, pass: passIngresada)

