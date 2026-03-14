-- Cold backup manually
--know location of our files
select file_name from dba_data_files

-- location of control files
select name from v$controlfile;

-- find archive log files
-- only available if the database is in archive log mode
archive log list

-- shutdown database
shutdown transactional


--go to the root
cd /

ls

-- create a folder backup
mkdir coldbackup

--navigate to the files we are to backup
cp -r data /coldbackup/
cp -r control /coldbackup/
cp -r arch /coldbackup/

-- confirm if copied
cd  /
cd coldbackup
ls


-- now start the database
-------------------------------------------------------------------------------------

-- Doing hot backup
