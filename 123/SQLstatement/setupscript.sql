DROP TABLE imagescount;
DROP TABLE pictures;
DROP TABLE imagesviewer;
DROP sequence images_seq;
DROP sequence pic_id_sequence;
DROP sequence group_id_sequence;
@setup.sql;
@CreateIndex.sql;
@drjobml1.sql;
@drjobml2.sql;
@drjobml3.sql;
@counter.sql;
CREATE sequence pic_id_sequence;
CREATE sequence group_id_sequence increment by 1 start with 3;
CREATE sequence images_seq MINVALUE 100;
Insert Into users Values('admin','admin',SYSDATE);
Insert Into persons Values('admin','admin','admin','admin','admin','admin');
commit;
