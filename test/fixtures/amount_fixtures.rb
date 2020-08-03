module AmountFixtures

  NUMBER_FORMATS = [
    { source: " 31,68 ", target: "31.68" },
    { source: "31 . 68", target: "31.68" },
    { source: "310,68", target: "310.68" },
    { source: "310.   68", target: "310.68" },
    { source: "3410,68", target: "3410.68" },
    { source: "3410.68", target: "3410.68" },
    { source: "3   410,68", target: "3410.68" },
    { source: "3 410.68", target: "3410.68" },
    { source: "3,410,68", target: "3410.68" },
    { source: "3,410.68", target: "3410.68" },
    { source: "3.410,68", target: "3410.68" },
    { source: "3.410.68", target: "3410.68" }
  ]

  EURO_SIGNS = [
    { source: "€31,68", target: "31.68" },
    { source: "€ 31.68", target: "31.68" },
    { source: "€€310,68", target: "310.68" },
    { source: "€  310.68", target: "310.68" },
    { source: "3410,68€", target: "3410.68" },
    { source: "3410.68 €", target: "3410.68" },
    { source: "3 410,68 €€", target: "3410.68" },
    { source: "31,68 EUR", target: "31.68" },
    { source: "31.68 eur", target: "31.68" },
    { source: "310,68 EuR", target: "310.68" },
    { source: "EUR310.68", target: "310.68" },
    { source: "EUR  3410,68 €", target: "3410.68" }
  ]

  USD_SIGNS = [
    { source: "$31,68", target: "31.68" },
    { source: "UsD310.68", target: "310.68" },
    { source: "USd  3410,68 $", target: "3410.68" }
  ]

end