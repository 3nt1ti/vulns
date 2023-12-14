import Foundation
import FoundationNetworking // Importar FoundationNetworking para algunas versiones de Swift
extension String: Error {}


let MAX_TRANSFER_AMOUNT: Double = 10000.0 // Establecer el límite máximo de transferencia

// Uso de la función con una cantidad de transferencia específica
print("Cliente swift linux")
let cantidad: Double = 50000.0 // Cantidad a transferir
print(cantidad)

// Verificar si la cantidad es válida antes de realizar la solicitud
     guard cantidad > 0 && cantidad <= MAX_TRANSFER_AMOUNT else {
        print("Ingrese una cantidad valida para la transferencia.")
        throw "Ingrese una cantidad valida para la transferencia."
    }

    let urlString = "http://localhost:3000/realizarTransferencia";
    guard let url = URL(string: urlString) else {
        print("URL invalida")
        throw "URL invalida"
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let parametros: [String: Any] = [
        "cantidad": cantidad
    ]

    guard let jsonData = try? JSONSerialization.data(withJSONObject: parametros) else {
        print("Error al convertir los datos a JSON")
        throw "Error al convertir los datos a JSON"
    }

    request.httpBody = jsonData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error)")
        }

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

