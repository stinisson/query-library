SELECT owner.name as 'Owner', dog.name
FROM owner INNER JOIN dog
ON owner.id = dog.owner_id
ORDER BY owner.name;