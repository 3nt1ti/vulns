import Foundation

func enviarDatosAlServidor(datos: Data,  url: String) {

    guard let url = URL(string: url) else {
        print("URL invalida")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = datos

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        // Procesar la respuesta del servidor
        // ...
    }

    task.resume()
}

// Ejemplo de uso
let datosConfidenciales = "Información confidencial".data(using: .utf8)!
let servidorURL = "https://api.bankapp.com/mobile"

enviarDatosAlServidor(datos: datosConfidenciales, url: servidorURL)
