SELECT dog.name, owner.name AS "Owner" 
FROM dog, owner 
WHERE dog.owner_id = owner.id AND owner.name = 'Elon Musk';