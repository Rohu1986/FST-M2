-- Load input file from HDFS
A = LOAD 'hdfs:///user/rohan/episodes/' USING PigStorage('\t') AS
(Character:chararray,Dialogue:chararray);
-- Group data using the character column
grpd = GROUP A BY Character;
-- Count the occurence of each dialogue (Reduce)
cntd = FOREACH grpd GENERATE group, COUNT(A) AS cnt;
counts_ordered = ORDER cntd BY cnt DESC;
-- Store the result in HDFS
rmf hdfs:///user/rohan/episodeIV_dialogues
STORE counts_ordered INTO 'hdfs:///user/rohan/episodeIV_dialogues';
