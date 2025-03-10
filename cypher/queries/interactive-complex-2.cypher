MATCH (:Person {id:$personId})-[:KNOWS]-(friend:Person)<-[:HAS_CREATOR]-(message:Message)
WHERE message.creationDate < datetime($maxDate)
RETURN
  friend.id AS personId,
  friend.firstName AS personFirstName,
  friend.lastName AS personLastName,
  message.id AS messageId,
  CASE exists(message.content)
    WHEN true THEN message.content
    ELSE message.imageFile
  END AS messageContent,
  message.creationDate AS messageCreationDate
ORDER BY messageCreationDate DESC, messageId ASC
LIMIT 20
