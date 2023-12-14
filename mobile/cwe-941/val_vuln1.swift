import Foundation

func enviarDatosAlServidor(datos: Data, url: String) {
    // Lista de URLs válidas permitidas
    let urlsValidas = [
        "api.bankapp.com",
        "sandbox.bankapp.com"
    ]

     guard let urlComponents = URLComponents(string: url),
          let host = urlComponents.host,
          dominiosValidos.contains(host) else {
        print("URL inválida o no permitida")
        return
    }

    var request = URLRequest(url: urlComponents.url!)
    request.httpMethod = "POST"
    request.httpBody = datos

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        // Manejo de errores y procesamiento de respuesta similar al ejemplo anterior
        // ...
    }

    task.resume()
}
