db.purchase_orders.aggregate(
    [
        {$match: {customer: {$in: ["Mike", "Karen"]}} },
        {$group: {_id: "$customer", total: {$sum: "$total"}} },
        {$sort: {total: -1}}
    ]
)

db.purchase_orders.aggregate(
     [
          {$match: {product: {$in: ["toothbrush", "pizza"]} } },
          {$group: {_id: "$product", total: { $sum: "$total"} } },
     ]
)

db.todo.updateOne( {_id: ObjectId('6081cece228062496c854191') },
{$set: { title: 'Make dinner', dueDate: '2021-04-24', priority: 1, tags: [ 'Cannelloni', 'tomatoes' ] }});