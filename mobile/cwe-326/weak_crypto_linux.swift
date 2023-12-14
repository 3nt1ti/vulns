import NIO
import NIOSSL
import Foundation

// Configuración de OpenSSL
let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
let sslContext = try! NIOSSLContext(configuration: TLSConfiguration.forClient())
let sslHandler = try! NIOSSLClientHandler(context: sslContext, serverHostname: "localhost")

// Datos a cifrar
let plaintext = "4547-7559-8630-9988"
let plaintextData = plaintext.data(using: .utf8)!

// Cifrado usando OpenSSL
let encryptedData = try! sslContext.withSSLClientHandler(sslHandler) { sslClient -> EventLoopFuture<ByteBuffer> in
    let buffer = sslClient.channel.allocator.buffer(bytes: plaintextData)
    return sslClient.writeAndFlush(buffer)
}.wait()

// Convertir los datos cifrados a una cadena legible
let encryptedString = encryptedData.getString(at: encryptedData.readerIndex, length: encryptedData.readableBytes)!
print("Datos cifrados: \(encryptedString)")
