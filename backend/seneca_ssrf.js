const seneca = require('seneca')()
const request = require('request')

seneca.add({role: 'payment', cmd: 'processPayment'}, (args, done) => {

  const paymentURL = args.urlpay
  console.log(paymentURL)

  request.post(paymentURL, (error, response, body) => {
    // console.log(error)
    if(error) return done(error)
    // console.log(response)
    done(null, {
      status: response.statusCode,
      body: body
    })
  })

})

// Call the service action:
/*
seneca.act({
  role: 'payment',
  cmd: 'processPayment',
  urlpay: 'https://paymentprocessor.com/pay'
})*/

seneca.act({
  role: 'payment',
  cmd: 'processPayment',
  urlpay: 'https://somosmach.com/'
})
