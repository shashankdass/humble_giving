package main

import (
  "log"
  "github.com/stellar/go/clients/horizon"
  "github.com/aws/aws-lambda-go/lambda"
)

type Request struct {
  Address string `json:"address"`
}

type Response struct {
  Balance string `json:"balance"`
}

func sendBalance(address string) (Response, error) {
  account, err := horizon.DefaultTestNetClient.LoadAccount(address)
  if err != nil {
    log.Fatal(err)
    return Response{}, err
  }

  log.Println("Balances for address:", address)
  for _, balance := range account.Balances {
    log.Println(balance.Balance)
    return Response{Balance: balance.Balance}, nil
  }
  return Response{}, nil
}

func Handler(request Request) (Response, error){
  log.Println("Inside the handler")
  log.Println("request")
  log.Println(request)

  if request.Address == "" {
    return Response{}, nil
  }

  log.Println("Sending Balance")
  return sendBalance(request.Address)
}

func main() {
  lambda.Start(Handler)
}