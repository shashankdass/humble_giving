package main

import (
  "log"
  "github.com/stellar/go/build"
  "github.com/stellar/go/clients/horizon"
  "github.com/aws/aws-lambda-go/lambda"
)

type Request struct {
  Address string `json:"address"`
}

func sendLumens( destinationAddress string) {
   log.Println(destinationAddress)
   sourceSeed := "SD4CZFIDOUR3YFZPS6KCEFW6UUF3L2J7RX4ZN6ELOVNNIGXRGTFVNCU3"
   amount := "100"

   tx, err := build.Transaction(
      build.SourceAccount{sourceSeed},
      build.TestNetwork,
      build.AutoSequence{SequenceProvider: horizon.DefaultTestNetClient},
      build.Payment(
         build.Destination{AddressOrSeed: destinationAddress},
         build.NativeAmount{Amount: amount},
      ),
   )

   if err != nil {
      panic(err)
   }

   txe, err := tx.Sign(sourceSeed)
   if err != nil {
      panic(err)
   }

   txeB64, err := txe.Base64()
   if err != nil {
      panic(err)
   }

   resp, err := horizon.DefaultTestNetClient.SubmitTransaction(txeB64)
   if err != nil {
      panic(err)
   }

   log.Println("Successfully sent", amount, "lumens to", destinationAddress,". Hash:", resp.Hash)
}

func Handler(request Request) {
  log.Println("Inside the handler")
  log.Println("request")
  log.Println(request)
  log.Println(request.Address)

  if request.Address == "" {
    return
  }

  log.Println("Sending Lumnes")
  sendLumens(request.Address)
}

func main() {
  lambda.Start(Handler)
}