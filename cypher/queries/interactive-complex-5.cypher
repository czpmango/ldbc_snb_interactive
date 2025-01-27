MATCH (person:Person {id: $personId})-[:KNOWS*1..2]-(friend:Person)<-[membership:HAS_MEMBER]-(forum:Forum)
WHERE membership.joinDate > datetime($minDate)
  AND person <> friend
WITH DISTINCT friend, forum
OPTIONAL MATCH (friend)<-[:HAS_CREATOR]-(post:Post)<-[:CONTAINER_OF]-(forum)
WITH forum, count(post) AS postCount
RETURN
  forum.title AS forumTitle,
  postCount
ORDER BY postCount DESC, forum.id ASC
LIMIT 20
