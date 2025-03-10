MATCH (person:Person {id: $personId})-[:KNOWS*1..2]-(friend:Person)
WHERE person <> friend
WITH DISTINCT friend
MATCH (friend)-[workAt:WORK_AT]->(company:Organisation)-[:IS_LOCATED_IN]->(:Country {name: $countryName})
WHERE workAt.workFrom < $workFromYear
RETURN
  friend.id AS personId,
  friend.firstName AS personFirstName,
  friend.lastName AS personLastName,
  company.name AS organizationName,
  workAt.workFrom AS organizationWorkFromYear
ORDER BY organizationWorkFromYear ASC, personId ASC, organizationName DESC
LIMIT 10
