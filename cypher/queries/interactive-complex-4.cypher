// Q4. New topics
/*
:param [{ personId, startDate, durationDays }] => { RETURN
  10995116277918 AS personId,
  "2010-10-01" AS startDate,
  31 AS durationDays
}
*/
MATCH (person:Person {id: $personId })-[:KNOWS]-(friend:Person),
      (friend)<-[:HAS_CREATOR]-(post:Post)-[:HAS_TAG]->(tag)
WITH DISTINCT tag, post
WITH tag,
     CASE
       WHEN $endDate > post.creationDate >= $startDate THEN 1
       ELSE 0
     END AS valid,
     CASE
       WHEN $startDate > post.creationDate THEN 1
       ELSE 0
     END AS inValid
WITH tag, sum(valid) AS postCount, sum(inValid) AS inValidPostCount
WHERE postCount>0 AND inValidPostCount=0
RETURN tag.name AS tagName, postCount
ORDER BY postCount DESC, tagName ASC
LIMIT $limit
