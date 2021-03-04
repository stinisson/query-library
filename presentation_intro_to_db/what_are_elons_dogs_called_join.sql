SELECT dog.name, owner.name as 'Owner'
FROM owner INNER JOIN dog
ON owner.id = dog.owner_id
WHERE owner.name = 'Elon Musk';