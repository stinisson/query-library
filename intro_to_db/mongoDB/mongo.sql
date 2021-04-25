// 4) Skriv en query som tar fram hur många kunder som finns i Sverige
// Ans: 680
// Ans: 690?

// I mongo.exe:
// db.order.distinct( "customer._id" , { "customer.country" : "Sweden" } ).length
// -> 680
db.order.distinct( "customer._id" , { "customer.country" : "Sweden" } ).lenght

db.runCommand ( { distinct: "order", key: "customer._id", query: { "customer.country": "Sweden"} } )

db.runCommand ( { key: "customer._id", query: { "customer.country": "Sweden"} } )


db.order.aggregate([
    {$project: {"customer.country": 1,
                "customer._id": 1}},
    {$match: {"customer.country": "Sweden"}},
    {$group: { _id: "$customer._id", count: { $sum: 1 } } }
]).toArray().length

// 5) Skriv en query som tar fram hur många ordrar innehåller produkt 546
// Ans: 1331
db.order.find(
    {"items.product": 546 }
).count()

// 6) Skriv kod för att ta bort alla kunder som finns i Norge
db.order.deleteMany( { "customer.country": "Norway" } )

// 7) Skriv kod för att med MongoDBs aggregation pipeline räkna ut den totala summa som kunder
// från Kina handlat för under 2020
// Ans: 12109407.93

db.order.aggregate([
    {$project: {"customer.country": 1,
                "order_tot": 1,
                year: {$year: '$order_date'}}},
    {$match: {"customer.country": "China", year: 2020}},
    {$group: { _id: null, count: { $sum: "$order_tot" } } }
])


// Sum of orders by county year 2020
db.order.aggregate([
    {$project: {"customer.country": 1,
                "order_tot": 1,
                year: {$year: '$order_date'}}},
    {$match: {year: 2020}},
    {$group: { _id: "$customer.country", count: { $sum: "$order_tot" } } },
    {$sort: {count: 1}}
])
