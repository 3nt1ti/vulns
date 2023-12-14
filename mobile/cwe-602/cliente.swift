import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

let MAX_TRANSFER_AMOUNT: Double = 10000.0 // Establecer el límite máximo de transferencia

func realizarTransferencia(cantidad: Double) {
    let urlString = "https://localhost:3000/realizarTransferencia"
    guard let url = URL(string: urlString) else {
        print("URL inválida")
        return
    }

    // Verificar si la cantidad es válida antes de realizar la solicitud
    guard cantidad > 0 && cantidad <= MAX_TRANSFER_AMOUNT else {
        print("Ingrese una cantidad válida para la transferencia.")
        return
    }

    // Datos a enviar en la solicitud
    let parametros: [String: Any] = [
        "cantidad": cantidad
    ]

    // Convertir los parámetros a formato JSON
    guard let jsonData = try? JSONSerialization.data(withJSONObject: parametros) else {
        print("Error al convertir los datos a JSON")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = jsonData
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            return
        }

        // Procesar la respuesta del servidor
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                print("Transferencia realizada exitosamente")
                // Manejar la respuesta del servidor según sea necesario
            } else {
                print("Error en la solicitud: \(httpResponse.statusCode)")
                // Manejar otros códigos de estado HTTP si es necesario
            }
        }
    }
    task.resume()
}

// Uso de la función
let cantidadTransferencia: Double = 100.0 // Cantidad a transferir
realizarTransferencia(cantidad: cantidadTransferencia)

