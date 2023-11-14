LOAD CSV WITH HEADERS FROM 'http://localhost:11001/project-5c8d4429-af60-4ebc-8b9e-745f6cb5b454/base_index.csv' AS line
WITH line WHERE line.prime IS NOT NULL AND line.target IS NOT NULL
MERGE (prime:Word {name: line.prime})
MERGE (target:Word {name: line.target})
MERGE (prime)-[:RELATED_TO {id: line.id}]->(target)

LOAD CSV WITH HEADERS FROM 'http://localhost:11001/project-5c8d4429-af60-4ebc-8b9e-745f6cb5b454/base_index.csv' AS line
WITH line, split(line["prime;target;id"], ';') AS parts
WHERE parts[0] IS NOT NULL AND parts[1] IS NOT NULL
MERGE (prime:Word {name: parts[0]})
MERGE (target:Word {name: parts[1]})
MERGE (prime)-[:RELATED_TO {id: parts[2]}]->(target)

LOAD CSV WITH HEADERS FROM 'http://localhost:11001/project-c44f8a0f-b7a8-429e-b2d0-3ec50607da3b/base_index.csv' AS line
WITH line WHERE line.prime IS NOT NULL AND line.target IS NOT NULL
MERGE (prime:Word {name: line.prime})
MERGE (target:Word {name: line.target})
MERGE (prime)-[:REL_TO {id: line.id}]->(target)


LOAD CSV WITH HEADERS FROM 'http://localhost:11001/project-5c8d4429-af60-4ebc-8b9e-745f6cb5b454/base_index.csv' AS line
RETURN line

MATCH (n)
WHERE n.Prime IS NOT NULL
RETURN n AS node
LIMIT 10;

MATCH (n:Prime)
WHERE n.Prime IS NOT NULL AND n.Prime CONTAINS 'HAVE'
WITH n
LIMIT 25
MATCH (n)-[:YOUR_RELATIONSHIP_TYPE]->(nextNode:Prime)
RETURN n AS startNode, nextNode AS node
LIMIT 25;

MATCH (n)
WHERE n.Prime IS NOT NULL AND (n.Prime) CONTAINS ('HAVE')
RETURN n AS node
LIMIT 25;

MATCH (n:priming)
RETURN n, keys(n)

WITH 'HAVE' AS Prime
MATCH (n:priming)
WHERE n.Prime = Prime OR n.Target = Prime
RETURN n.Prime, n.Target;

MATCH (a:priming {Prime: 'HAVE'}), (b:priming {Target: 'GRAND'})
MERGE (a)-[r:RELATIONSHIP_TYPE]->(b)
RETURN type(r)

WITH 'HAVE' AS Prime
MATCH (n:priming)
WHERE n.Prime = Prime OR n.Target = Prime
MERGE (a:priming {Prime: n.Prime})
ON CREATE SET a.Target = n.Target
MERGE (a)-[r:RELACIONAMENTO]->(b:priming {Target: n.Target})
RETURN a, r, b

MATCH ()-[r:RELACIONAMENTO]->()
CREATE (startNode)-[newRel:Rel_Have]->(endNode)
SET newRel = r
DELETE r

MATCH ()-[r:RELATIONSHIP_TYPE]->()
DELETE r

WITH 'HAVE' AS Prime
MATCH (n:priming)
WHERE n.Prime = Prime OR n.Target = Prime
MERGE (a:priming {Prime: n.Prime})
ON CREATE SET a.Target = n.Target
MERGE (a)-[r:Rel_Have6]->(b:priming {Target: n.Target})
RETURN a, r, b

WITH 'HAVE' AS Prime
MATCH (n:priming)
WHERE n.Prime = Prime OR n.Target = Prime
WITH n, COALESCE(n.Prime, 'defaultPrime') AS Prime, COALESCE(n.Target, 'defaultTarget') AS Target
MERGE (a:priming {Prime: Prime})
ON CREATE SET a.Target = Target
MERGE (a)-[r:Rel_Priming]->(b:priming {Target: Target})
RETURN a, r, b

// Criar alguns departamentos
CREATE (d1:Department {name: 'Computer Science'})
CREATE (d2:Department {name: 'Mathematics'})
CREATE (d3:Department {name: 'Physics'})

// Criar alguns estudantes e relacioná-los com departamentos
CREATE (s1:Student {name: 'John Doe', birthYear: 1995, country: 'USA'})
CREATE (s2:Student {name: 'Jane Smith', birthYear: 1998, country: 'Canada'})
CREATE (s3:Student {name: 'Bob Johnson', birthYear: 1997, country: 'UK'})

CREATE (s1)-[:BELONGS_TO]->(d1)
CREATE (s2)-[:BELONGS_TO]->(d2)
CREATE (s3)-[:BELONGS_TO]->(d3)

// Criar algumas relações de aprendizado
CREATE (s1)-[:IS_LEARNING]->(l1:IsLearningRelation {subject: 'Programming'})
CREATE (s1)-[:IS_LEARNING]->(l2:IsLearningRelation {subject: 'Database'})

CREATE (s2)-[:IS_LEARNING]->(l3:IsLearningRelation {subject: 'Algebra'})
CREATE (s2)-[:IS_LEARNING]->(l4:IsLearningRelation {subject: 'Statistics'})

CREATE (s3)-[:IS_LEARNING]->(l5:IsLearningRelation {subject: 'Quantum Mechanics'})
CREATE (s3)-[:IS_LEARNING]->(l6:IsLearningRelation {subject: 'Thermodynamics'})

MATCH (student:Student)-[:BELONGS_TO]->(department:Department)
OPTIONAL MATCH (student)-[:IS_LEARNING]->(learningRelation:IsLearningRelation)
RETURN student, department, COLLECT(learningRelation) AS learningRelations;

Time taken
00:00:22
File size
13.1 MiB
File rows
639,976
Nodes created
3,348
Properties set
1,282,216
Labels added
3,348
Query count
14
Query time
00:00:20S